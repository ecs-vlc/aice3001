// p-value of a two-sample t-test against n (samples per group) when two
// means with equal standard errors Delta are a fixed gap apart.  Left: the
// one-standard-error bars just touch (gap 2 Delta), p -> 0.16.  Right: the
// gap needed for p = 0.05, 1.96 sqrt(2) Delta = 2.77 Delta.  The standard
// error of the difference is sqrt(2) Delta, not Delta: the original version
// of this figure used Delta and so understated the p-values.
// Numbers from errorbarsT.py (writes errorbarsT_data.asy).
settings.outformat = "pdf";
import myutil;
include "errorbarsT_data.asy";
unitsize(1cm);

real xs = 0.85, ysc = 13;                     // cm per decade, cm per unit p
real pmax = 0.3;

void panel(pair o, int k, string gaplabel) {
  // axes
  draw(shift(o)*((0,0)--(6*xs+0.3,0)), Arrow(5));
  draw(shift(o)*((0,0)--(0,pmax*ysc+0.3)), Arrow(5));
  for (int d = 0; d <= 6; ++d) {
    draw(shift(o)*((d*xs,0)--(d*xs,-0.08)));
    label((d == 0 ? "$1$" : (d == 1 ? "$10$" : "$10^{" + string(d) + "}$")),
          o+(d*xs,-0.08), S, fontsize(8pt));
  }
  for (int j = 0; j <= 6; ++j) {
    real p = 0.05*j;
    draw(shift(o)*((0,p*ysc)--(-0.08,p*ysc)));
    label(format("%#.2f", p), o+(-0.08,p*ysc), W, fontsize(8pt));
  }
  label("$n$", o+(3*xs,-0.6), S, fontsize(9pt));
  label(rotate(90)*Label("$p$-value", fontsize(9pt)), o+(-1.2, pmax*ysc/2));
  draw(shift(o)*((0,0.05*ysc)--(6*xs,0.05*ysc)), gray(0.5)+dashed);
  // the p-value curve
  guide g;
  for (int i = 0; i < ns.length; ++i) g = g--(o+(log10(ns[i])*xs, pv[k][i]*ysc));
  draw(g, black+linewidth(0.9));
  // inset: two means with +/- Delta bars, gaps[k]*Delta apart
  real D = 0.25, x = 4.0*xs, y0 = 2.75;
  real yb = y0, yr = y0 + gaps[k]*D;
  draw(shift(o)*((x,yb-D)--(x,yb+D)), blue+linewidth(1), Bars(4));
  dot(o+(x,yb), blue+linewidth(4));
  draw(shift(o)*((x,yr-D)--(x,yr+D)), red+linewidth(1), Bars(4));
  dot(o+(x,yr), red+linewidth(4));
  draw(shift(o)*((x+0.55,yb)--(x+0.55,yr)), Arrows(4));
  label(gaplabel, o+(x+0.55,(yb+yr)/2), E, fontsize(9pt));
  label("$p\to" + format("%#.2f", pv[k][ns.length-1]) + "$", o+(5.2*xs, pv[k][ns.length-1]*ysc), S, fontsize(8pt));
}

panel((0,0), 0, "$2\,\Delta$");
panel((7.4,0), 1, "$2.77\,\Delta$");
shipout("errorbarsT");
erase();
