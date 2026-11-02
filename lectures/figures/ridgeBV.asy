// Bias^2, variance and expected squared error of ridge regression against
// eta (log-log).  The numbers are real: run  python ridgeBV.py  first, which
// writes ridgeBV_data.asy.
import myutil;
include "ridgeBV_data.asy";

real xu = 2.0cm, yu = 1.3cm;
real x0 = -3, x1 = 2, y0 = -1, y1 = 2.5;         // log10 ranges
pair P(real e, real v) { return (xu*(log10(e) - x0), yu*(log10(v) - y0)); }

guide curve(real[] v) {
  guide g;
  for (int i = 0; i < eta.length; ++i)
    if (v[i] >= 10^y0 && v[i] <= 10^y1) g = g--P(eta[i], v[i]);
  return g;
}

draw(box(P(10^x0, 10^y0), P(10^x1, 10^y1)));
for (int d = -3; d <= 2; ++d) {
  draw(P(10.0^d, 10^y0)--P(10.0^d, 10^y0) + (0, 3));
  label("$10^{" + string(d) + "}$", P(10.0^d, 10^y0), S, fontsize(9pt));
}
for (int d = -1; d <= 2; ++d) {
  draw(P(10^x0, 10.0^d)--P(10^x0, 10.0^d) + (3, 0));
  label("$10^{" + string(d) + "}$", P(10^x0, 10.0^d), W, fontsize(9pt));
}
label("regularisation $\eta$", P(10^((x0 + x1)/2), 10^y0) - (0, 18),
      fontsize(10pt));

pen pb = red + linewidth(1), pv = blue + linewidth(1),
    ptot = black + linewidth(1.4);
draw(curve(bias2), pb);
draw(curve(var), pv);
draw(curve(total), ptot);
draw(P(etabest, 10^y0)--P(etabest, 10^y1), gray(0.5) + dashed);

// legend
pair o = P(10^(-2.8), 10^0.05);
void key(pair o, pen p, string s) {
  draw(o--o + (18, 0), p);
  label(s, o + (22, 0), E, fontsize(9pt));
}
key(o, ptot, "$\mathbb{E}\|\hat{\bm{w}} - \bm{w}^*\|^2$");
key(o - (0, 12), pb, "bias$^2$");
key(o - (0, 24), pv, "variance");
ship();
erase();
