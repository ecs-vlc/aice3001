import myutil;
import graph;
size(400,0);

real f(real x) {
  return - exp(-0.3*x*x) - exp(-3*x*x);
}

real grad(real x) {
  return 0.6*x*exp(-0.3*x*x) + 6*x*exp(-3*x*x);
}

draw(graph(f,-3,3));

real x =-2.5;
dot((x, f(x)), red+linewidth(3));
ship();

real eta = 2;
for(int i=0; i<20; ++i) {
  erase();
  draw(graph(f,-3,3));
  label("$\bm{w}(t+1) = \bm{w}(t) - " + string(eta,3)
	+ "\bm{\nabla} L_{\mathcal{B}}(\bm{w}(t))$", (0, 0), 3S); 
  dot((x, f(x)), red+linewidth(3));
  real y = x - eta*grad(x);
  if (i==9)
    eta = 0.2;
  draw((x, f(x))--(y, f(y)), red, MidArrow);
  dot((y, f(y)), red+linewidth(3));
  ship();
  x = y;
}
