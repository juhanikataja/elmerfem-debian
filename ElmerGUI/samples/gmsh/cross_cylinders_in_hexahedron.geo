cl1 = 1;
cl2=0.2;
Point(1) = {0, 0, 0, cl2};
Point(2) = {1, 0, 0, cl2};
Point(4) = {-1, 0, 0, cl2};
Point(5) = {0, -1, 0, cl2};
Point(6) = {5, 0, 0, cl1};
Point(7) = {-5, 0, 0, cl1};
Point(8) = {1, 0, 10, cl2};
Point(9) = {5, 0, 10, cl1};
Point(10) = {0, -1, 10, cl2};
Point(11) = {0, 0, 10, cl2};
Point(12) = {-1, 0, 10, cl2};
Point(14) = {-5, 0, 10, cl1};
Point(15) = {5, -5, 10, cl1};
Point(16) = {-5, -5, 10, cl1};
Point(17) = {-5, -5, 0, cl1};
Point(18) = {5, -5, 0, cl1};
Point(19) = {5, -5, 4, cl2};
Point(21) = {5, -5, 6, cl2};
Point(24) = {5, -5, 5, cl2};
Point(25) = {5, -4, 5, cl2};
Point(33) = {-5, -5, 6, cl2};
Point(34) = {-5, -4, 5, cl2};
Point(35) = {-5, -5, 5, cl2};
Point(36) = {-5, -5, 4, cl2};
Circle(1) = {4, 1, 5};
Circle(2) = {5, 1, 2};
Line(3) = {2, 6};
Line(4) = {4, 7};
Line(5) = {8, 9};
Line(6) = {2, 8};
Line(7) = {6, 9};
Circle(9) = {10, 11, 8};
Line(10) = {5, 10};
Circle(13) = {12, 11, 10};
Line(14) = {4, 12};
Line(17) = {12, 14};
Line(19) = {7, 14};
Line(21) = {9, 15};
Line(22) = {14, 16};
Line(23) = {7, 17};
Line(24) = {6, 18};
Line(25) = {17, 18};
Line(26) = {15, 16};
Circle(31) = {19, 24, 25};
Circle(32) = {25, 24, 21};
Line(33) = {19, 18};
Line(34) = {21, 15};
Line(51) = {33, 16};
Line(52) = {21, 33};
Circle(55) = {34, 35, 33};
Line(56) = {25, 34};
Circle(59) = {36, 35, 34};
Line(60) = {19, 36};
Line(63) = {36, 17};
Line Loop(8) = {3, 7, -5, -6};
Ruled Surface(8) = {8};
Line Loop(12) = {2, 6, -9, -10};
Ruled Surface(12) = {12};
Line Loop(16) = {1, 10, -13, -14};
Ruled Surface(16) = {16};
Line Loop(20) = {4, 19, -17, -14};
Ruled Surface(20) = {20};
Line Loop(28) = {4, 23, 25, -24, -3, -2, -1};
Plane Surface(28) = {28};
Line Loop(30) = {22, -26, -21, -5, -9, -13, 17};
Plane Surface(30) = {30};
Line Loop(54) = {34, 26, -51, -52};
Ruled Surface(54) = {54};
Line Loop(58) = {32, 52, -55, -56};
Ruled Surface(58) = {58};
Line Loop(62) = {31, 56, -59, -60};
Ruled Surface(62) = {62};
Line Loop(66) = {33, -25, -63, -60};
Ruled Surface(66) = {66};
Line Loop(68) = {34, -21, -7, 24, -33, 31, 32};
Plane Surface(68) = {68};
Line Loop(70) = {51, -22, -19, 23, -63, 59, 55};
Plane Surface(70) = {70};
Surface Loop(72) = {30, 70, 54, 68, 8, 28, 20, 16, 12, 66, 62, 58};
Volume(72) = {72};