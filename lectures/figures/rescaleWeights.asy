settings.outformat="pdf";
import myutil;
import palette;
import graph;
import contour;

size(400,0);

real f(pair p)
{
  return 0.2*p.x*p.x+3.2*p.y*p.y - 0.3*p.x*p.y;
}

real g(real x, real y)
{
  return 1-f((x,y));
}


pair gradient(pair p) {
  return (0.4*p.x-1.3*p.y, 6.4*p.y-1.3p.x);
}

pair ll = (-2.2,-1.8);
pair ur = (2.2,1.8);
path bb = box(ll, ur);


image(g,ll, ur,BWRainbow());

real c[] = new real[100];
for(int i=0; i<c.length; ++i) {
  c[i] = 0.5*(1+i);
}

draw(contour(f, ll, ur, c));


clip(bb);

draw((-2.2,0)--(2.2,0), linewidth(1), Arrow);
draw((0,-1.8)--(0,1.8), linewidth(1), Arrow);

real u = -0.05;
bool show = true;
for(real x=-2; x<2.1; x+=0.5) {
  if (show) {
    draw((x,0)--(x,u));
    label(string(x,1), (x,u), S);
  } else {
    draw((x,0)--(x,0.7*u));
  }
  show = ! show;
}

real u = -0.05;
show = false;
for(real y=-1.5; y<1.6; y+=0.5) {
  if (show) {
    draw((0,y)--(u,y));
    label(string(y, 1), (u, y), W);
  } else {
    draw((0, y)--(0.7*u, y));
  }
  show = ! show;
}

ship();

pair pos = (-1.91,0.18);
dot(pos,linewidth(6));
draw(pos--pos-0.2*gradient(pos), linewidth(1)+blue, Arrow);
ship();

/* Rescaled Landscape */

real r = 4;

erase();
real f(pair p)
{
  real x = r*p.x;
  return 0.2*x*x+3.2*p.y*p.y - 0.3*x*p.y;
}

pair gradient(pair p) {
  real x = r*p.x;
  return (0.4*x*r- 0.3*p.y, 6.4*p.y - 0.3*x);
}

real g(real x, real y)
{
  return 1-f((x,y));
}

image(g,ll, ur,BWRainbow());

draw(contour(f, ll, ur, c));



draw((-2.2,0)--(2.2,0), linewidth(1), Arrow);
draw((0,-1.8)--(0,1.8), linewidth(1), Arrow);

real u = -0.05;
bool show = true;
for(real x1=-0.5; x1<0.51; x1+=0.25) {
  real x = r*x1;
  if (show) {
    draw((x,0)--(x,u));
    label(string(x1,1), (x,u), S);
  } else {
    draw((x,0)--(x,0.7*u));
  }
  show = ! show;
}

real u = -0.05;
show = false;
for(real y=-1.5; y<1.6; y+=0.5) {
  if (show) {
    draw((0,y)--(u,y));
    label(string(y, 1), (u, y), W);
  } else {
    draw((0, y)--(0.7*u, y));
  }
  show = ! show;
}

clip(bb);

ship();

dot(pos,linewidth(6));
draw(pos--pos-0.1*gradient(pos), linewidth(1)+blue, Arrow);
ship();
