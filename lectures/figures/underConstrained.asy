size(300,0);

import three;
import graph3;
currentprojection=orthographic(5,3,2);

draw((0,0,0)--(1,0,0), Arrow3);
draw((0,0,0)--(0,1,0), Arrow3);
draw((0,0,0)--(0,0,1), Arrow3);
label("$x_1$", (1.05,0,0));
label("$x_2$", (0,1.05,0));
label("$x_3$", (0,0,1.05));


draw((-2,0,0)--(-1,0,0), Arrow3);
draw((-2,0,0)--(-2,1,0), Arrow3);
draw((-2,0,0)--(-2,0,1), Arrow3);
label("$y_1$", (1.05-2,0,0));
label("$y_2$", (-2,1.05,0));
label("$y_3$", (-2,0,1.05));

draw((0.2,0,0.1)--(0.8,1,0.6), red);

triple onLine(real t) {
  return t*(0.2,0,0.1) + (1-t)*(0.8,1,0.6);
}

triple y = (-1.5,0.6, 0.7);

for (real t=0.2; t<0.9; t+=0.2) {
  triple p = onLine(t);
  label("x", p, blue);
  draw(p--0.5*(p+y), green, Arrow3);
  draw(0.5*(p+y)--y, green);
}

dot(y, blue+linewidth(5));
label("$\mathbf{y}=\mathbf{M}\mathbf{x}$", y, N);
shipout("underConstrained0");

erase();


draw((0,0,0)--(1,0,0), Arrow3);
draw((0,0,0)--(0,1,0), Arrow3);
draw((0,0,0)--(0,0,1), Arrow3);
label("$x_1$", (1.05,0,0));
label("$x_2$", (0,1.05,0));
label("$x_3$", (0,0,1.05));


draw((-2,0,0)--(-1,0,0), Arrow3);
draw((-2,0,0)--(-2,1,0), Arrow3);
draw((-2,0,0)--(-2,0,1), Arrow3);
label("$y_1$", (1.05-2,0,0));
label("$y_2$", (-2,1.05,0));
label("$y_3$", (-2,0,1.05));

draw((0.2,0,0.1)--(0.8,1,0.6), red);

triple onLine(real t) {
  return t*(0.2,0,0.1) + (1-t)*(0.8,1,0.6);
}

triple y = (-1.5,0.6, 0.7);

for (real t=0.2; t<0.9; t+=0.2) {
  triple p = onLine(t);
  label("?", p, blue);
  draw(0.5*(p+y)--p, green);
  draw(y--0.5*(p+y), green, Arrow3);
}

label("$\mathbf{M}^{-1}\mathbf{y}=?$", onLine(0.5), SE);

dot(y, blue+linewidth(5));
label("$\mathbf{y}$", y, N);
shipout("underConstrained1");
