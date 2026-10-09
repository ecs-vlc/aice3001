settings.outformat="pdf";
import myutil;
size(200,0);

draw((0,0)--(0,2.2), Arrow);
label("$p(x)$", (0,2.2), N, red);
draw((-3,0)--(3,0), Arrow);
label("$x$", (3,0), E);
guide g = (-3,0);
real d = 0.25;
for(real x=-3+d/2; x<3.001; x+=d) {
  real y = 0.1*floor(20*exp(-0.5*x*x));
  g = g--(x-d/2, y)--(x+d/2, y);
}

draw(g, red);

real u = -3;

draw((-3,u)--(3,u), Arrow);
draw((0,u)--(0,2.2+u), Arrow);
label("$q(x)$", (0,2.2+u), N, blue);
label("$x$", (3,u), E);
guide g = (-3,u);
real d = 0.25;
int i = 0;
real yold = 0;
for(real x=-3+d/2; x<3.001; x+=d) {
  real y = 0.1*floor(20*exp(-0.5*x*x))+u;
  if (i==3) {
    yold = y;
    y = u;
    write(x,y);
  }
  if (i==4)
    y = y+yold-u;
  g = g--(x-d/2, y)--(x+d/2, y);
  ++i;
 }

draw(g, blue);
