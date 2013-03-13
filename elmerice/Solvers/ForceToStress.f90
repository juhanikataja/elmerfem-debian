!/*****************************************************************************/
! *
! *  Elmer/Ice, a glaciological add-on to Elmer
! *  http://elmerice.elmerfem.org
! *
! * 
! *  This program is free software; you can redistribute it and/or
! *  modify it under the terms of the GNU General Public License
! *  as published by the Free Software Foundation; either version 2
! *  of the License, or (at your option) any later version.
! * 
! *  This program is distributed in the hope that it will be useful,
! *  but WITHOUT ANY WARRANTY; without even the implied warranty of
! *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! *  GNU General Public License for more details.
! *
! *  You should have received a copy of the GNU General Public License
! *  along with this program (in file fem/GPL-2); if not, write to the 
! *  Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, 
! *  Boston, MA 02110-1301, USA.
! *
! *****************************************************************************/
! ******************************************************************************
! *
! *  Authors: Olivier Gagliardini, Ga¨el Durand
! *  Email:   
! *  Web:     http://elmerice.elmerfem.org
! *
! *  Original Date: 

! ****************************************************************************/
! -----------------------------------------------------------------------
!> Solver to go from a Force (or Debit) to Stress (or Flux) SDOFs = 1
   RECURSIVE SUBROUTINE ForceToStress( Model,Solver,dt,TransientSimulation )
!------------------------------------------------------------------------------

    USE DefUtils

    IMPLICIT NONE

!------------------------------------------------------------------------------
!******************************************************************************
!
!  Solve stress equations for one timestep
!
!  ARGUMENTS:
!
!  TYPE(Model_t) :: Model,  
!     INPUT: All model information (mesh,materials,BCs,etc...)
!
!  TYPE(Solver_t) :: Solver
!     INPUT: Linear equation solver options
!
!  REAL(KIND=dp) :: dt,
!     INPUT: Timestep size for time dependent simulations (NOTE: Not used
!            currently)
!
!******************************************************************************

     TYPE(Model_t)  :: Model
     TYPE(Solver_t), TARGET :: Solver

     LOGICAL ::  TransientSimulation
     REAL(KIND=dp) :: dt
!------------------------------------------------------------------------------
!    Local variables
!------------------------------------------------------------------------------
     TYPE(Solver_t), POINTER :: PSolver

     TYPE(Matrix_t),POINTER :: StiffMatrix

     INTEGER :: i, j, k, l, n, t, iter, NDeg, STDOFs, LocalNodes, istat
     INTEGER :: dim

     TYPE(ValueList_t),POINTER :: Material, BC
     TYPE(Nodes_t) :: ElementNodes
     TYPE(Element_t),POINTER :: CurrentElement

     REAL(KIND=dp) :: RelativeChange, UNorm, PrevUNorm, s
                      
     LOGICAL :: stat, CSymmetry 

     INTEGER :: NewtonIter, NonlinearIter

     TYPE(Variable_t), POINTER :: StressSol, ForceSol 

     REAL(KIND=dp), POINTER :: Stress(:), ForceValues(:), &
                      ForceVector(:)

     INTEGER, POINTER :: StressPerm(:), ForcePerm(:), NodeIndexes(:)

     LOGICAL :: GotIt, AllocationsDone = .FALSE.

     REAL(KIND=dp), ALLOCATABLE:: LocalMassMatrix(:,:), &
       LocalStiffMatrix(:,:), LocalForce(:), &
       NodalForce(:)
            
     CHARACTER(LEN=MAX_NAME_LEN) :: FlowSolverName

     REAL(KIND=dp) :: at, at0, CPUTime, RealTime


!------------------------------------------------------------------------------
     SAVE LocalMassMatrix, LocalStiffMatrix, LocalForce, &
          ElementNodes, AllocationsDone  
     SAVE NodalForce,  dim

!------------------------------------------------------------------------------
!  Get Force variable                                         
!------------------------------------------------------------------------------
      
     ForceSol => VariableGet( Solver % Mesh % Variables, 'Force' )
     IF ( ASSOCIATED( ForceSol ) ) THEN
       ForcePerm    => ForceSol % Perm
       ForceValues  => ForceSol % Values
     ELSE
       CALL Info('ForceToStress', &
                      & 'No variable for Force associated.', Level=4)
     END IF
!              
!------------------------------------------------------------------------------
!    Get variables needed for solution
!------------------------------------------------------------------------------
      IF ( .NOT. ASSOCIATED( Solver % Matrix ) ) RETURN

      StressSol => Solver % Variable
      StressPerm => StressSol % Perm
      STDOFs =  StressSol % DOFs
      Stress => StressSol % Values

      LocalNodes = COUNT( StressPerm > 0 )
      IF ( LocalNodes <= 0 ) RETURN


      StiffMatrix => Solver % Matrix
      ForceVector => StiffMatrix % RHS
      UNorm = Solver % Variable % Norm

!------------------------------------------------------------------------------
!     Allocate some permanent storage, this is done first time only
!------------------------------------------------------------------------------
      IF ( .NOT. AllocationsDone .OR. Solver % Mesh % Changed) THEN
        N = Model % MaxElementNodes
        dim = CoordinateSystemDimension()

       IF ( AllocationsDone ) THEN
         DEALLOCATE( ElementNodes % x,     &
                     ElementNodes % y,     &
                     ElementNodes % z,     &
                     NodalForce,           &
                     LocalMassMatrix,      &
                     LocalStiffMatrix,     &
                     LocalForce )
       END IF

       ALLOCATE( ElementNodes % x( N ), &
                 ElementNodes % y( N ), &
                 ElementNodes % z( N ), &
                 NodalForce(N ), &                                    
                 LocalMassMatrix( 2*STDOFs*N,2*STDOFs*N ),  &
                 LocalStiffMatrix( 2*STDOFs*N,2*STDOFs*N ),  &
                 LocalForce( 2*STDOFs*N ),  STAT=istat )

       IF ( istat /= 0 ) THEN
          CALL Fatal( 'ForceToStress', 'Memory allocation error.' )
       END IF
!------------------------------------------------------------------------------
       AllocationsDone = .TRUE.
      END IF


!------------------------------------------------------------------------------
      NonlinearIter = 1
      DO iter=1,NonlinearIter

       at  = CPUTime()
       at0 = RealTime()

       CALL Info( 'ForceToStress', ' ', Level=4 )
       CALL Info( 'ForceToStress', ' ', Level=4 )
       CALL Info( 'ForceToStress', ' ', Level=4 )
       CALL Info( 'ForceToStress', ' ', Level=4 )
       CALL Info( 'ForceToStress', 'Starting assembly...',Level=4 )

!------------------------------------------------------------------------------
       CALL DefaultInitialize()
!------------------------------------------------------------------------------
       DO t=1,Solver % NumberOFActiveElements

         IF ( RealTime() - at0 > 1.0 ) THEN
           WRITE(Message,'(a,i3,a)' ) '   Assembly: ',  &
             INT(100.0 - 100.0 * (Solver % NumberOfActiveElements-t) / &
             (1.0*Solver % NumberOfActiveElements)), ' % done'
           CALL Info( 'ForceToStress', Message, Level=5 )
           at0 = RealTime()
         END IF

         CurrentElement => GetActiveElement(t)
         n = GetElementNOFNodes()
         NodeIndexes => CurrentElement % NodeIndexes

         ElementNodes % x(1:n) = Model % Nodes % x(NodeIndexes(1:n))
         ElementNodes % y(1:n) = Model % Nodes % y(NodeIndexes(1:n))
         ElementNodes % z(1:n) = Model % Nodes % z(NodeIndexes(1:n))

         Material => GetMaterial()


!------------------------------------------------------------------------------
!        Get element local stiffness & mass matrices
!------------------------------------------------------------------------------

          NodalForce= 0.0d0
          NodalForce(1:n) = ForceValues(ForcePerm(NodeIndexes(1:n)))

          CALL LocalMatrix( LocalMassMatrix, LocalStiffMatrix, &
              LocalForce, NodalForce, CurrentElement, n, ElementNodes )
              

!------------------------------------------------------------------------------
!        Update global matrices from local matrices 
!------------------------------------------------------------------------------
         CALL DefaultUpdateEquations( LocalStiffMatrix, LocalForce )
 
      END DO
      
      DO i=1, Model % Mesh % NumberOfNodes
         IF (ForcePerm(i)>0) THEN 
            ForceVector(StressPerm(i)) = ForceValues(ForcePerm(i))
         END IF
      END DO

      CALL Info( 'ForceToStress', 'Assembly done', Level=4 )


      CALL DefaultFinishAssembly()

!------------------------------------------------------------------------------
!     Dirichlet boundary conditions
!------------------------------------------------------------------------------
!     CALL DefaultDirichletBCs()

!------------------------------------------------------------------------------

      CALL Info( 'ForceToStress', 'Set boundaries done', Level=4 )

!------------------------------------------------------------------------------
!     Solve the system and check for convergence
!------------------------------------------------------------------------------
      PrevUNorm = UNorm

      UNorm = DefaultSolve()

      unorm = 0
      n = Solver % Variable % DOFs
      DO i=1,n-1
        unorm = unorm + SUM( solver % variable % values(i::n)**2 )
      END DO
      unorm = SQRT( unorm )
      solver % variable % norm = unorm

      IF ( PrevUNorm + UNorm /= 0.0d0 ) THEN
         RelativeChange = 2.0d0 * ABS( PrevUNorm - UNorm) / ( PrevUnorm + UNorm)
      ELSE
         RelativeChange = 0.0d0
      END IF

      WRITE( Message, * ) 'Result Norm   : ',UNorm, PrevUNorm
      CALL Info( 'ForceToStress', Message, Level=4 )
      WRITE( Message, * ) 'Relative Change : ',RelativeChange
      CALL Info( 'ForceToStress', Message, Level=4 )


!------------------------------------------------------------------------------
    END DO ! of nonlinear iter
!------------------------------------------------------------------------------

      
CONTAINS


!------------------------------------------------------------------------------
      SUBROUTINE LocalMatrix( MassMatrix, StiffMatrix, ForceVector, &
              NodalForce, Element, n, Nodes )
              
!------------------------------------------------------------------------------

     REAL(KIND=dp) :: StiffMatrix(:,:), MassMatrix(:,:)
     REAL(KIND=dp) ::  NodalForce(:), ForceVector(:)
     TYPE(Nodes_t) :: Nodes
     TYPE(Element_t) :: Element
     INTEGER :: n
!------------------------------------------------------------------------------
!
     REAL(KIND=dp) :: Basis(2*n), ddBasisddx(1,1,1)
     REAL(KIND=dp) :: dBasisdx(2*n,3), detJ

     REAL(KIND=dp) :: LGrad(3,3), SR(3,3),  Li(9)

     INTEGER :: i, j, k, p, q, t, dim, cc

     REAL(KIND=dp) :: s, u, v, w, Radius
  
     TYPE(GaussIntegrationPoints_t), TARGET :: IntegStuff

     INTEGER :: N_Integ

     REAL(KIND=dp), DIMENSION(:), POINTER :: U_Integ, V_Integ, W_Integ, S_Integ

     LOGICAL :: stat, CSymmetry

!------------------------------------------------------------------------------

      ForceVector = 0.0D0
      StiffMatrix = 0.0D0
      MassMatrix  = 0.0D0

      IntegStuff = GaussPoints( Element )

      U_Integ => IntegStuff % u
      V_Integ => IntegStuff % v
      W_Integ => IntegStuff % w
      S_Integ => IntegStuff % s
      N_Integ =  IntegStuff % n
!
!   Now we start integrating
!
      DO t=1,N_Integ

      u = U_Integ(t)
      v = V_Integ(t)
      w = W_Integ(t)

!------------------------------------------------------------------------------
!     Basis function values & derivatives at the integration point
!------------------------------------------------------------------------------
       stat = ElementInfo(Element,Nodes,u,v,w,detJ, &
                 Basis,dBasisdx,ddBasisddx,.FALSE.,.FALSE.)


       s = detJ * S_Integ(t)


       Radius = SUM( Nodes % x(1:n) * Basis(1:n) )
       CSymmetry = CurrentCoordinateSystem() == AxisSymmetric
       IF ( CSymmetry ) s = s * Radius


          DO p=1,n         
            DO q=1,n        
            StiffMatrix(p,q) =  &
               StiffMatrix(p,q) + s*Basis(q)*Basis(p)
            END DO
          END DO
      END DO 

!------------------------------------------------------------------------------
      END SUBROUTINE LocalMatrix
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
      END SUBROUTINE ForceToStress
!------------------------------------------------------------------------------
