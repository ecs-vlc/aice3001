// Inequality constraint g(x)>=0 that excludes the unconstrained minimum, so
// the constrained minimum x* is on the boundary.  Frame 0: the problem.
// Frame 1: grad f and grad g at x*.  Frame 2: grad f = alpha grad g, alpha>0.
settings.outformat="pdf";
import graph;
import contour;
import stats;
import myutil;
unitsize(105);   // fixed scale: size() would rescale as labels are added
srand(1);   // the light-red gradient arrows are placed at random
real f(real x, real y) {return x^2+2y^2-x*y;}
pair gradf(pair p) {return (2p.x-p.y,4p.y-p.x);}
// g >= 0 below the parabola (the shaded region)
real g(real x, real y) {return -(x-1)^2-y;}
pair gradg(pair p) {return (-2*(p.x-1), -1);}
real gg(real x) {return -(x-1)^2;}

// x*: where d f(x, gg(x))/dx = 0 on the boundary, by bisection
real dphi(real x) { pair p = (x, gg(x)); return dot(gradf(p), (1, -2*(x-1))); }
real a = 0.2, b = 0.9;
for (int j = 0; j < 50; ++j) {
  real c = (a+b)/2;
  if (dphi(a)*dphi(c) <= 0) b = c; else a = c;
}
pair xs = ((a+b)/2, gg((a+b)/2));
real alpha = dot(gradf(xs), gradg(xs))/dot(gradg(xs), gradg(xs));

picture background() {
  picture pic;
  path const = graph(gg,0,1.2,operator..);
  fill(pic, const--(1.2,-1)--(0,-1)--cycle, paleblue);
  // keep these clear of x*
  for (real x : new real[] {0.1, 0.28, 1.05}) {
    pair p = (x, gg(x));
    pair grad = 0.09*gradg(p);
    draw(pic, p--p+grad, blue, Arrow);
    label(pic, "$\nabla g(\mathbf{x})$", p+1.5*grad, blue);
  }

  // the second contour is the one through x*, so it touches the boundary
  real[] con = {0.25,f(xs.x,xs.y),0.75,1};
  guide[][] contours = contour(f,(-1.2,-1.0),(1.2,1.0), con);
  draw(pic, contours, lightred);
  draw(pic, const, blue);

  label(pic, "$g(\mathbf{x})\geq0$", (1.0, -0.9), blue);
  label(pic, "$f(\mathbf{x})$",(0,0), red);

  for(int i=0; i<con.length; ++i) {
    real len = length(contours[i][0]);
    for(real t=0.1*len*unitrand(); t<len; t+=0.1*len) {
      pair pos = point(contours[i][0],t);
      draw(pic, pos--pos+0.05*gradf(pos), lightred, Arrow);
    }
  }

  dot(pic, xs, linewidth(5));
  label(pic, "$\mathbf{x}^*$", xs, NW);
  draw(pic, box((-1.25,-1.02), (1.3,1.02)), invisible);   // same size every frame
  return pic;
}
picture bg = background();

real s = 0.3;   // one scale for both gradients, so alpha is their length ratio
void gradients() {
  // parallel, so draw them slightly apart to see both
  pair off = 0.025*unit(rotate(90)*gradg(xs));
  draw(xs+off--xs+off+s*gradf(xs), red+linewidth(1.2), Arrow(6));
  draw(xs-off--xs-off+s*gradg(xs), blue+linewidth(1.2), Arrow(6));
  label("$\nabla f$", xs+off+s*gradf(xs), E, red, Fill(white));
  label("$\nabla g$", xs-off+s*gradg(xs), S, blue, Fill(white));
}

add(bg); ship();
erase(); add(bg); gradients(); ship();
erase(); add(bg); gradients();
label("$\nabla f(\mathbf{x}^*) = \alpha\,\nabla g(\mathbf{x}^*)$, $\alpha\approx"
      + format("%.1f", alpha) + ">0$", (-1.25, 0.95), E, heavygreen, Fill(white));
ship();
