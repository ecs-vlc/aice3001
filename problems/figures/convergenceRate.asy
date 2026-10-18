// Problem sheet optimisation, 1(c): per-step contraction factors |1-ra| and |1-rb|
// for gradient descent on f = (a w1^2 + b w2^2)/2.  Drawn with a=3, b=1 so
// the marked points 1/a, 2/(a+b), 1/b are well spaced; ticks are symbolic.
settings.outformat="pdf";
import graph;

size(9cm, 5.5cm, IgnoreAspect);

real a = 3, b = 1;
real rmax = 1.25, ymax = 1.5;

real fa(real r) { return abs(1-a*r); }
real fb(real r) { return abs(1-b*r); }

// |1-ra| leaves the plot once it passes ymax
real rcut = (1+ymax)/a;

draw((0,1)--(rmax,1), gray+dotted);
label("diverges above $1$", (rmax,1), NW, gray);

draw(graph(fa, 0, rcut, n=200), red+linewidth(1.2));
draw(graph(fb, 0, rmax, n=200), blue+linewidth(1.2));
label("$|1-a\,r|$", (rcut, ymax), 1.5W, red);
label("$|1-b\,r|$", (0.25, fb(0.25)), NE, blue);

real ropt = 2/(a+b), rho = (a-b)/(a+b);
draw((ropt,0)--(ropt,rho), heavygreen+dashed);
dot((ropt,rho), heavygreen+linewidth(4));
// read the optimal contraction factor off the y-axis
draw((0,rho)--(ropt+0.15,rho), heavygreen+dotted+linewidth(1));
label("$\displaystyle\frac{\kappa-1}{\kappa+1}$", (ropt+0.15,rho), 2E, heavygreen);

xaxis("$r$", 0, rmax+0.08, Arrow);
yaxis(0, ymax+0.1, Arrow);
label(rotate(90)*"contraction factor $|w_{t+1}/w_t|$", (-0.16, ymax/2));
real[] rt = {1/a, ropt, 1/b};
string[] rl = {"$\frac1a$", "$\frac{2}{a+b}$", "$\frac1b$"};
for (int i = 0; i < rt.length; ++i) {
  draw((rt[i],0)--(rt[i],-0.04));
  label(rl[i], (rt[i],-0.04), S);
}
draw((0,1)--(-0.015,1));
label("$1$", (-0.015,1), W);
label("$0$", (0,0), SW);
