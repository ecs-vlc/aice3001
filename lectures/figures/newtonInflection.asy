// Which stationary point Newton's method heads for depends on the sign of
// f'' at the start, not on which stationary point is nearer.  Newton jumps
// to the stationary point of the local quadratic (Taylor) approximation:
// a minimum where f''>0, a maximum where f''<0.
// Frame 0: start in an f''>0 region     Frame 1: the parabola and the jump
// Frame 2: start in an f''<0 region     Frame 3: the parabola and the jump
// (replaces the xfig figure hess-missleading)
settings.outformat="pdf";
import graph;
import myutil;

size(13cm, 5cm, IgnoreAspect);   // small, so the fonts are large on the slide

real xmin = 0, xmax = 10, ymin = 0, ymax = 2.25;
real k = 2pi/5.6;
real amp(real x) { return 0.7 - 0.04*x; }
real f(real x)   { return 1.2 + amp(x)*cos(k*(x-0.8)); }
real fp(real x)  { return -0.04*cos(k*(x-0.8)) - amp(x)*k*sin(k*(x-0.8)); }
real fpp(real x) { return 0.08*k*sin(k*(x-0.8)) - amp(x)*k^2*cos(k*(x-0.8)); }

// inflection points: sign changes of f'', refined by bisection
real[] inflections;
int n = 1000;
for (int i = 0; i < n; ++i) {
  real a = xmin + (xmax-xmin)*i/n, b = xmin + (xmax-xmin)*(i+1)/n;
  if (fpp(a)*fpp(b) < 0) {
    for (int j = 0; j < 50; ++j) {
      real c = (a+b)/2;
      if (fpp(a)*fpp(c) <= 0) b = c; else a = c;
    }
    inflections.push((a+b)/2);
  }
}

picture background() {
  picture pic;
  real[] edges = {xmin};
  for (real x : inflections) edges.push(x);
  edges.push(xmax);
  for (real x : inflections)
    draw(pic, (x,ymin)--(x,ymax), heavygreen+dashed);
  for (int i = 0; i < edges.length-1; ++i) {
    real mid = (edges[i]+edges[i+1])/2;
    string s = fpp(mid) > 0 ? "$f''(x)>0$" : "$f''(x)<0$";
    label(pic, s, (mid, ymax), S);
  }
  draw(pic, graph(f, xmin, xmax, n=400), black+linewidth(1));
  xaxis(pic, "$x$", ymin, xmax+0.3, Arrow);
  yaxis(pic, "$f(x)$", xmin, ymax+0.1, Arrow);
  return pic;
}

void start(real x0) {
  dot((x0, f(x0)), red+linewidth(5));
  label("$x_0$", (x0, f(x0)), S, red);
}

// the local quadratic at x0, and the Newton jump to its stationary point
void jump(real x0) {
  real a = fpp(x0), g = fp(x0), f0 = f(x0);
  real q(real x) { return f0 + g*(x-x0) + 0.5*a*(x-x0)^2; }
  real x1 = x0 - g/a;
  real lo = min(x0, x1) - 1.2, hi = max(x0, x1) + 1.2;
  picture par;
  draw(par, graph(q, lo, hi, n=200), blue+dashed+linewidth(1));
  clip(par, box((xmin,ymin), (xmax,ymax)));
  add(par);
  dot((x1, q(x1)), blue+linewidth(4));
  real top = max(f0, f(x1)) + 0.35;
  draw((x0, f0){up}..((x0+x1)/2, top)..{down}(x1, f(x1)), red+linewidth(1),
       Arrow(size=7), EndMargin);
  dot((x1, f(x1)), red+linewidth(5));
  label("$x_1$", (x1, f(x1)), S, red);
  start(x0);
}

real xa = 4.2;   // f''>0: Newton heads for the minimum
real xb = 5.5;   // f''<0: Newton heads for the maximum

add(background()); start(xa); ship();
erase(); add(background()); jump(xa); ship();
erase(); add(background()); start(xb); ship();
erase(); add(background()); jump(xb); ship();
