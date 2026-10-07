// v_1: eigenvector of the dual D = X^T X (2-D, one axis per data point)
// u_1 = X v_1: eigenvector of C = X X^T (3-D feature space), as in the slides
size(0,150);
import graph;
import myutil;
import settings;
render=0;


xaxis(Label("$x^1$",EndPoint), -5, 5, Ticks(Step=2), Arrow);
yaxis(Label("$x^2$",EndPoint), -5, 5, Ticks(Step=2), Arrow);


dot((-3,3), red);
dot((-1,1), red);
dot((2,-2), red);
shipout("pcaDual2D-0");
dot((-2,2)/3, blue);
draw((-2,2)/3--(1,-1), blue+dashed, Arrow);
label("$\bm{v}_1$", (1,-1), SE);

shipout("pcaDual2D-1");
