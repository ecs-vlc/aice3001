// Under-constrained fitting: degree-5 polynomials (6 parameters) through 4
// data points.  Every solution is p0(x) + q(x)*prod_i (x - x_i), with p0 the
// cubic through the points and q(x) any linear function, so there is a
// two-parameter family of exact fits.  Frame 0 shows the data; each later
// frame adds one more member of the family.
import myutil;
import graph;
size(400,220,IgnoreAspect);

real[] xs = {1, 2, 3, 4};
real[] ys = {1, 0.4, 1.2, 0.6};

real xmin = 0.2;
real xmax = 4.8;
real ymin = -1.5;
real ymax = 3;

// cubic through the data (Lagrange form)
real p0(real x) {
  real s = 0;
  for (int i=0; i<xs.length; ++i) {
    real l = 1;
    for (int j=0; j<xs.length; ++j)
      if (j != i) l *= (x-xs[j])/(xs[i]-xs[j]);
    s += ys[i]*l;
  }
  return s;
}

// vanishes at every data point
real nullpoly(real x) {
  real s = 1;
  for (int i=0; i<xs.length; ++i) s *= x-xs[i];
  return s;
}

using frr = real(real);

// Pick q so the curve passes through (xmin,yl) and (xmax,yr): an easy way
// to steer where each member of the family ends up.
frr solution(real yl, real yr) {
  real ql = (yl - p0(xmin))/nullpoly(xmin);
  real qr = (yr - p0(xmax))/nullpoly(xmax);
  real a = (ql + qr)/2;
  real b = (qr - ql)/(xmax - xmin);
  real xm = (xmin + xmax)/2;
  return new real(real x) {return p0(x) + (a + b*(x-xm))*nullpoly(x);};
}

// end values (yl,yr) for each curve shown, in order of appearance
pair[] ends = {(0.8,0.7), (2.6,2.6), (-1.2,-1.2), (-1.2,2.6), (2.6,-1.2)};
pen[] cols = {blue, heavygreen, orange, magenta, heavycyan};

picture axes = new picture;
draw(axes, (xmin,0)--(xmax+0.2,0), Arrow);
draw(axes, (0,ymin)--(0,ymax+0.3), Arrow);
label(axes, "$x$", (xmax+0.2,0), E);
label(axes, "$y$", (0,ymax+0.3), N);

void drawdata() {
  for (int i=0; i<xs.length; ++i)
    dot((xs[i],ys[i]), red+linewidth(6));
}

picture bg = new picture;

for (int k=0; k<=ends.length; ++k) {
  erase();
  add(axes);
  add(bg);
  if (k > 0) {
    // clip to the plotting window: the curves blow up outside the data
    picture c = new picture;
    draw(c, graph(solution(ends[k-1].x, ends[k-1].y), xmin, xmax, n=400),
         cols[k-1]+linewidth(1.2));
    clip(c, box((xmin,ymin), (xmax,ymax)));
    add(bg, c);
    add(c);
  }
  drawdata();
  ship();
}
