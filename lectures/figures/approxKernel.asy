import myutil;
import graph;

size(300,0);

real f(real x) {
  real y = x-6;
  real z = x+4;
  return 1/(1+x*x+0.4x*x*x*x) + 4.0/(0.5+0.1y*y+0.3y*y*y*y)
    + 6/(1+z*z+0.4z*z*z*z);}

real r = 8;
draw(graph(f,-r,r));
draw((-1.1*r,8)--(-1.1*r,0)--(1.15*r,0), Arrows);
label("$y$", (1.15*r,0), E);
label(rotate(90)*Label("$K(x,y)\,f(y)$"),(-1.1*r,4), W); 
draw(box((-1.12r,-0.7),(r+0.5, 8.1)), white);

int n = 8;
for(int i=0; i<=n; ++i) {
  real x = -r +i*2*r/(n);
  draw(box((x-r/(n),0),(x+r/(n),f(x))), dotted+red+linewidth(1));
  draw((x,0)--(x,f(x)), red);
  dot((x,f(x)), red);
  label("$y_{" + string(i) + "}$", (x,-0.05), S);
}

ship();
real x = -r +7*2*r/(n);
draw((x-r/(n),0.5f(x))--(x+r/(n),0.5f(x)), blue, Arrows);
label("$\Delta$", (x,0.5f(x)), blue, UnFill);
ship();
