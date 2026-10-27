// Box plot of a standard normal, built up frame by frame; replaces the
// copyrighted boxPlot.png.  Quartiles, fences and areas are computed here.
// Frames: 0 density, 1 median, 2 IQR (box, 50%), 3 whiskers (24.65% each),
// 4 outliers (0.35% each), 5 comment (on the right) that box plots show
// no error bars.
settings.outformat = "pdf";
import myutil;
import graph;
unitsize(1cm);

real ys = 9;                                  // density scale: 0.4 -> 3.6cm
real f(real x) { return exp(-x^2/2)/sqrt(2pi); }
real Phi(real x) { return 0.5*(1+erf(x/sqrt(2))); }
real quantile(real pr) {                      // bisection on Phi
  real a = -8, b = 8;
  for (int i = 0; i < 100; ++i) { real c = (a+b)/2; if (Phi(c) < pr) a = c; else b = c; }
  return (a+b)/2;
}
real q1 = quantile(0.25), q3 = quantile(0.75), iqr = q3-q1;
real lo = q1-1.5*iqr, hi = q3+1.5*iqr;
real pmid = Phi(q1) - Phi(lo), ptail = Phi(lo);
string pc(real p) { return format("%#.2f", 100*p) + "\%"; }
string sg(real x) { return "$" + format("%#.2f", x) + "\sigma$"; }

pen curvepen = rgb(0.85,0,0.3)+linewidth(1.2);
pen orange = rgb(0.9,0.45,0), purple = rgb(0.75,0.4,0.95), green = rgb(0.3,0.85,0.2);
pen boxfill = rgb(0.95,0.7,0.7), medpen = rgb(0.85,0,0.3)+linewidth(1.2);
real by = ys*0.42+2.2, bh = 0.7;                      // box plot centre line and half height

path region(real a, real b) {
  guide g = (a,0);
  for (int i = 0; i <= 60; ++i) { real x = a+(b-a)*i/60; g = g--(x, ys*f(x)); }
  return g--(b,0)--cycle;
}
void pct(real a, real b, string s) { label(s, ((a+b)/2, 0.3), fontsize(9pt)); }

void drawAxes() {
  draw(box((-5.8,-1.4), (11.3, by+2.1)), invisible);   // same size every frame
  draw((-4,0)--(4,0)); draw((-4,0)--(-4,ys*0.42));
  for (int k = -4; k <= 4; ++k) {
    draw((k,0)--(k,-0.08));
    label((k==0 ? "$0$" : "$" + string(k) + "\sigma$"), (k,-0.08), S, fontsize(8pt));
  }
  for (int k = 0; k <= 4; ++k) {
    draw((-4,ys*0.1*k)--(-4.08,ys*0.1*k));
    label(format("%#.1f", 0.1*k), (-4.08,ys*0.1*k), W, fontsize(8pt));
  }
  label(rotate(90)*Label("probability density", fontsize(9pt)), (-5.1, ys*0.2));
  draw((-4,by-1.1)--(4,by-1.1), gray(0.6));            // box plot axis
  for (int k = -4; k <= 4; ++k) draw((k,by-1.1)--(k,by-1.18), gray(0.6));
}
real fs(real x) { return ys*f(x); }
void curve() { draw(graph(fs, -4, 4, n=200), curvepen); }
void vguide(real x) { draw((x,0)--(x,by-1.1), gray(0.7)+dashed); }

void median() {
  draw((0,by-bh)--(0,by+bh), medpen);
  label("median", (0,by-bh), S, fontsize(8pt));
}
void iqrpart() {
  fill(region(q1,q3), orange); pct(q1, q3, "50\%");
  filldraw(box((q1,by-bh),(q3,by+bh)), boxfill, black);
  vguide(q1); vguide(q3);
  label("$Q_1$", (q1,by+bh), NW, fontsize(9pt)); label("$Q_3$", (q3,by+bh), NE, fontsize(9pt));
  draw((q1,by+bh+0.45)--(q3,by+bh+0.45), Bars); label("IQR", (0,by+bh+0.45), N, fontsize(9pt));
  label(sg(q1), (q1,ys*0.42), NW, fontsize(7pt)); label(sg(q3), (q3,ys*0.42), NE, fontsize(7pt));
}
void whiskers() {
  fill(region(lo,q1), purple); fill(region(q3,hi), purple);
  // nudged towards the centre so the labels clear the curve
  pct(lo+0.4, q1, pc(pmid)); pct(q3, hi-0.4, pc(pmid));
  draw((lo,by)--(q1,by)); draw((q3,by)--(hi,by));
  draw((lo,by-0.35)--(lo,by+0.35)); draw((hi,by-0.35)--(hi,by+0.35));
  vguide(lo); vguide(hi);
  label("$Q_1-1.5\times$IQR", (lo,by+0.35), N, fontsize(9pt));
  label("$Q_3+1.5\times$IQR", (hi,by+0.35), N, fontsize(9pt));
  label(sg(lo), (lo,ys*0.42), N, fontsize(7pt)); label(sg(hi), (hi,ys*0.42), N, fontsize(7pt));
}
void outliers() {
  fill(region(-4,lo), green); fill(region(hi,4), green);
  label(pc(ptail), ((-4+lo)/2, 0.6), fontsize(9pt)); label(pc(ptail), ((hi+4)/2, 0.6), fontsize(9pt));
  for (real x : new real[] {-3.3, -3.05, 3.05, 3.3}) dot((x,by), purple+linewidth(4));
  label("outliers", (-3.4,by), S, fontsize(8pt)); label("outliers", (3.4,by), S, fontsize(8pt));
}
void base() { erase(); drawAxes(); }

base(); curve(); ship();
base(); curve(); median(); ship();
base(); iqrpart(); curve(); median(); ship();
base(); iqrpart(); whiskers(); curve(); median(); ship();
base(); iqrpart(); whiskers(); outliers(); curve(); median(); ship();
base(); iqrpart(); whiskers(); outliers(); curve(); median();
label(minipage("\raggedright Box plots summarise the \emph{spread} of the data.\\[1ex]"
      + "They show no error bars on the median, so you cannot tell from them "
      + "whether two results are statistically significantly different.", 5.5cm),
      (8.3, ys*0.25));
ship();

// without this, asy ships the last picture again as boxPlotNormal.pdf at exit
erase();
