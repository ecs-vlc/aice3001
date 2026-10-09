// Linear, super-linear and quadratic convergence on a log scale.
// Errors follow the textbook recursions, not a real optimiser:
//   linear (gradient descent)   e_{t+1} = 0.8 e_t
//   super-linear (quasi-Newton) e_{t+1} = e_t^{1.3}      (ratio e_{t+1}/e_t -> 0)
//   quadratic (Newton)          e_{t+1} = e_t^2
settings.outformat="pdf";
import graph;
import myutil;

size(11cm, 5cm, IgnoreAspect);   // small, so the fonts are large on the slide

int T = 30;
real e0 = 0.5;
real floor = -16;          // double precision: nothing below about 1e-16

guide curve(real next(real)) {
  guide g;
  real e = e0;
  for (int t = 0; t <= T; ++t) {
    real l = log10(e);
    if (l < floor) { g = g--(t, floor); break; }
    g = g--(t, l);
    e = next(e);
  }
  return g;
}

real lin(real e) { return 0.8*e; }
real sup(real e) { return e^1.3; }
real quad(real e) { return e^2; }

draw((0,floor)--(T,floor), gray+dashed);
label("rounding error", (T,floor), NW, gray);

draw(curve(lin), blue+linewidth(1.2));
draw(curve(sup), heavygreen+linewidth(1.2));
draw(curve(quad), red+linewidth(1.2));

// legend in the empty lower right, so no label sits on a curve
void key(real y, string name, pen p) {
  draw((13.5,y)--(16,y), p+linewidth(1.2));
  label(name, (16.5,y), E, p);
}
key(-4.5, "linear (GD)", blue);
key(-7, "super-linear (BFGS)", heavygreen);
key(-9.5, "quadratic (Newton)", red);

xaxis("iteration", BottomTop, 0, T, LeftTicks(Step=5));
yaxis("$\log_{10}$ error", LeftRight, floor-0.5, 0.5, RightTicks(Step=4));
