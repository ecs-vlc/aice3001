// Four common learning-rate schedules, r(t) against training time.
settings.outformat="pdf";
import graph;
import myutil;

real T = 100;         // training time (e.g. epochs)
real rmax = 1;

real flat(real t) { return rmax; }
real step(real t) { return t < 40 ? rmax : (t < 70 ? 0.1*rmax : 0.01*rmax); }
real cosine(real t) {           // linear warm-up, then cosine decay
  real w = 10;
  return t < w ? rmax*t/w : 0.5*rmax*(1+cos(pi*(t-w)/(T-w)));
}
real cyclic(real t) {           // triangular cycles between 0.1 and 1
  real p = 25, f = (t % p)/p;
  return 0.1*rmax + 0.9*rmax*(f < 0.5 ? 2f : 2-2f);
}

picture panel(real f(real), string name, pen p) {
  picture pic;
  size(pic, 3.6cm, 2.2cm, IgnoreAspect);   // small, so the fonts are large on the slide
  draw(pic, graph(f, 0, T, n=400, join=operator --), p+linewidth(1.2));
  limits(pic, (0,0), (T,1.3*rmax), Crop);    // a flat curve has no height of its own
  xaxis(pic, "time", BottomTop, 0, T, NoTicks);
  yaxis(pic, "$r$", LeftRight, 0, 1.3*rmax, NoTicks);
  label(pic, name, (T/2, 1.3*rmax), N);
  return pic;
}

add(panel(flat, "constant", blue).fit(), (0,0), W);
add(panel(step, "step decay", red).fit(), (5.2cm,0), W);
add(panel(cosine, "warm-up + cosine", heavygreen).fit(), (0,-2.6cm), W);
add(panel(cyclic, "cyclical", magenta).fit(), (5.2cm,-2.6cm), W);
