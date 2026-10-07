// 3-D half of the PCA dual example (pcaDual.asy draws the 2-D half).
// Kept separate: loading graph and graph3 together makes Arrow3/Ticks ambiguous.
// u_1 = X v_1 is the eigenvector of C = X X^T, as in the slides
size(0,150);
import myutil;
import settings;
render=0;
import three;
import graph3;

currentprojection=perspective(5,4,2);
// Arrow3 is overloaded; pin down the arrowbar3 version for the axes
arrowbar3 axisarrow = Arrow3;

xaxis3(Label("$x_1$",EndPoint),-5,5, axisarrow);
yaxis3(Label("$x_2$",EndPoint),-5,5, axisarrow);
zaxis3(Label("$x_3$",EndPoint),-5,5, axisarrow);

dot((-3,-1,2), red);
dot((3,1,-2), red);
shipout("pcaDual3D-0");
dot((0,0,0), blue);
draw((0,0,0)--2*unit((3,1,-2)), blue+dashed, Arrow3);
label("$\bm{u}_1$", 2.3*unit((3,1,-2)));
shipout("pcaDual3D-1");
