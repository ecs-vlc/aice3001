// Inequality constraint g(x)>=0 whose boundary misses the unconstrained
// minimum x*.  Frame 0: the problem.  Frame 1: the boundary points where a
// contour of f touches the boundary.  Frame 2: there grad f = alpha grad g,
// but with alpha<0.  Frame 3: so they are not local optima.
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
real g(real x, real y) {return 0.8-(x-0.5)^2-y;}
pair gradg(pair p) {return (-2*(p.x-0.5), -1);}
real gg(real x) {return -(x-0.5)^2+0.8;}

picture background() {
  picture pic;
  path const = graph(gg,-0.842,1.2,operator..);
  fill(pic, const--(1.2,-1)--cycle, paleblue);
  // keep these clear of the points marked in frames 1-3
  for (real x : new real[] {-0.7, 0.1, 1.15}) {
    pair p = (x, gg(x));
    pair grad = 0.09*gradg(p);
    draw(pic, p--p+grad, blue, Arrow);
    label(pic, "$\nabla g(\mathbf{x})$", p+1.5*grad, blue);
  }

  real[] con = {0.25,0.5,0.75,1};
  guide[][] contours = contour(f,(-1.2,-1.0),(1.2,1.0), con);
  draw(pic, contours, lightred);
  draw(pic, const, blue);

  label(pic, "$g(\mathbf{x})\geq0$", (0.9, -0.5), blue);
  label(pic, "$f(\mathbf{x})$",(-0.8,0.4), red);

  for(int i=0; i<con.length; ++i) {
    real len = length(contours[i][0]);
    for(real t=0.1*len*unitrand(); t<len; t+=0.1*len) {
      pair pos = point(contours[i][0],t);
      draw(pic, pos--pos+0.05*gradf(pos), lightred, Arrow);
    }
  }

  dot(pic, (0,0), linewidth(5));
  label(pic, "$\mathbf{x}^*$", (0,0), NW);
  draw(pic, box((-1.25,-1.02), (1.65,1.32)), invisible);   // same size every frame
  return pic;
}
picture bg = background();

// Points on the boundary where grad f is parallel to grad g, found by
// bisection on d f(x, gg(x))/dx (three in this window, all with alpha<0)
real dphi(real x) { pair p = (x, gg(x)); return dot(gradf(p), (1, -2*(x-0.5))); }
pair[] touch;
real[] alpha;
int n = 400;
for (int i = 0; i < n; ++i) {
  real a = -0.842 + 2.042*i/n, b = -0.842 + 2.042*(i+1)/n;
  if (dphi(a)*dphi(b) < 0) {
    for (int j = 0; j < 50; ++j) {
      real c = (a+b)/2;
      if (dphi(a)*dphi(c) <= 0) b = c; else a = c;
    }
    pair p = ((a+b)/2, gg((a+b)/2));
    touch.push(p);
    alpha.push(dot(gradf(p), gradg(p))/dot(gradg(p), gradg(p)));
  }
}

pen touchpen = heavygreen;
void marks() {
  for (pair p : touch) {
    draw(contour(f, (-1.2,-1.0), (1.2,1.0), new real[] {f(p.x,p.y)}),
         red+dashed);
    dot(p, touchpen+linewidth(5));
  }
}

real s = 0.15;   // one scale for both gradients, so alpha is their length ratio
pair[] alphadir = {W, N, E};
void gradients() {
  for (int i = 0; i < touch.length; ++i) {
    pair p = touch[i];
    draw(p--p+s*gradf(p), red+linewidth(1.2), Arrow(6));
    draw(p--p+s*gradg(p), blue+linewidth(1.2), Arrow(6));
    label("$\alpha\approx"+format("%.1f", alpha[i])+"$",
          p+s*gradf(p), alphadir[i], touchpen, Fill(white));
  }
  label("$\nabla f(\mathbf{x}) = \alpha\,\nabla g(\mathbf{x})$, $\alpha<0$",
        (-1.25, 1.2), E, touchpen, Fill(white));
}

add(bg); ship();
erase(); add(bg); marks(); ship();
erase(); add(bg); marks(); gradients(); ship();
erase(); add(bg); marks(); gradients();
label("not a local optimum", (-1.25, 1.05), E, touchpen, Fill(white));
ship();
