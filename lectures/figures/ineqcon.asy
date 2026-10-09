import graph;
import contour;
import stats;
size(300);
real f(real x, real y) {return x^2+2y^2-x*y;}
pair gradf(pair p) {return (2p.x-p.y,4p.y-p.x);}
real g(real x, real y) {return y+(x-1)^2;}
real gg(real x) {return -(x-1)^2;}

path const = graph(gg,0,1.2,operator..);
fill(const--(1.2,-1)--(0,-1)--cycle, paleblue);
real l = length(const);
for (real t=0.1*l; t<l; t+=0.2*l) {
  pair p = point(const, t);
  pair grad = -0.09*(2*(p.x-1), 1);
  draw(p--p+grad, blue, Arrow);
  label("$\nabla g(\mathbf{x})$", p+1.5*grad, blue);
}


real[] con = {0.25,0.5,0.75,1};
guide[][] contours = contour(f,(-1.2,-1.0),(1.2,1.0), con);
draw(contours, lightred);
draw(contour(g,(-1.2,-1.0),(1.2,1.0), new real[]{0}), blue);

label("$g(\mathbf{x})\geq0$", (0.9, -0.5), blue);
label("$f(\mathbf{x})$",(0,0), red);

for(int i=0; i<con.length; ++i) {
  real len = length(contours[i][0]);
  for(real t=0.1*len*unitrand(); t<len; t+=0.1*len) {
    pair pos = point(contours[i][0],t);
    draw(pos--pos+0.05*gradf(pos), lightred, Arrow);
    //    label("$\nabla f(\mathbf{x})$", pos+1.5*grad, red);
  }
}


dot((0.505,-0.24), linewidth(5));
label("$\mathbf{x}^*$", (0.5,-0.24), NW);


