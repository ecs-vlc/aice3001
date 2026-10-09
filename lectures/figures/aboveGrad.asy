settings.outformat="pdf";
size(200,0);
import myutil;
import graph;

void axis(real xmin, real xmax, real ymin, real ymax, pair offset, string f) {
  draw(offset+(xmin,0)--offset+(xmax,0), Arrow);
  draw(offset+(0,ymin)--offset+(0,ymax), Arrow);
  pair o = (ymax>ymin)? N:S;
  label("$" + f + "$", offset+(0,ymax), o);
  label("$x$", offset+(xmax,0), E);
}


/* sqr */

pair offset = (0,0);

axis(-1,1,0,1,offset, "x^2");

real sqr(real x) {return x*x;}

draw(shift(offset)*graph(sqr,-1,1), blue);

ship();

void grad(real x) {
  real y = sqr(x);
  pair z = (x, y);
  dot(z, red);
  real g = 2*x;
  picture fg = new picture;
  draw(fg,(-1,g*(-1-x)+y)--(1,g*(1-x)+y), red);
  clip(fg,box((-1,-0.02),(1,1.02)));
  add(fg);
}

for(real x=-0.8; x<0.9; x+=0.3) {
  grad(x);
  ship();
}
  
