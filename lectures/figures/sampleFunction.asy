import myutil;
import graph;

size(500,0);

real f(real x) {
  real y = x-6;
  real z = x+4;
  return 1/(1+x*x+0.4x*x*x*x) + 4.0/(0.5+0.1y*y+0.3y*y*y*y)
    + 6/(1+z*z+0.4z*z*z*z);}

real r = 8;
draw(graph(f,-r,r));
draw((-1.1*r,0)--(1.1*r,0), Arrow);
label("$x$", (1.1*r,0), E);
draw(box((-1.12r,-0.7),(r+3.5, 8.1)), white);

picture pic = new picture;
add(pic, currentpicture);

ship();

int n = 4;
string vec;
for(int i=0; i<=n; ++i) {
  real x = -r +i*2*r/(n);
  draw((x,-0.05)--(x,f(x)), red);
  dot((x,f(x)), red);
  label("$x_{" + string(i) + "}$", (x,-0.05), S);
  vec = vec + string(f(x),3) + "\\";
}

label("$\bm{v}=\begin{pmatrix}" + vec + "\end{pmatrix}$", (r,4), E);
ship();
erase();
add(pic);

int n = 8;
string vec;
for(int i=0; i<=n; ++i) {
  real x = -r +i*2*r/(n);
  draw((x,0)--(x,f(x)), red);
  dot((x,f(x)), red);
  label("$x_{" + string(i) + "}$", (x,-0.05), S);
  vec = vec + string(f(x),3) + "\\";
}

label("$\bm{v}=\begin{pmatrix}" + vec + "\end{pmatrix}$", (r,4), E);
ship();
