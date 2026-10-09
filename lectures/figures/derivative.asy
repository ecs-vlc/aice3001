import myutil;
import graph;
size(300,0);

real func(real x) {
  return x*x;
}

picture bg = new picture;

draw(bg, graph(func,0,0.8), blue);
draw(bg, (0,func(0.81))--(0,0)--(0.81,0), Arrows);
label(bg, "$f(x)$", (0, func(0.81)), N);
label(bg, "$x$", (0.81, 0), E);
label(bg, "\small $f'(x_0) = \left.\frac{\mathrm{d} f(x)}{\mathrm{d} x}\right|_{x=x_0} = \lim\limits_{\epsilon \rightarrow 0} \frac{f(x_0+\epsilon)-f(x_0)}{\epsilon}$", (0.32, func(0.64)));
real[] eps = {0.2, 0.1, 0.05, 0.025, 0.01};
dot(bg, (0.9,0), white);
real x = 0.5;
draw(bg, (x,0)--(x,-0.03));
label(bg, "$x_0$", (x,-0.03), S);

for(int i=0; i<eps.length; ++i) {
  add(bg);
  pair p = (x, func(x));
  dot(p, red);
  real xp = x+eps[i];
  pair p1 = (xp, func(xp));
  dot(p1, red);
  real grad = (func(xp) - func(x))/eps[i];
  pair pp = p + 0.25*(1, grad);
  pair pm = p - 0.25*(1, grad);
  draw(pm--pp, red+dashed);
  pair ppp = p+(eps[i], 0);
  draw(p--ppp--p1--cycle, red);
  label("\tiny $\epsilon$", 0.5*(p+ppp), S, red);
  label("\tiny $f(x_0+\epsilon)-f(x_0)$", 0.5*(p1+ppp), E, red);
  ship();
  erase();
}
