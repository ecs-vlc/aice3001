// Double descent: test error of least squares (minimum norm when p > m)
// and of ridge regression against the number of features p.  The numbers
// are real: run  python doubleDescent.py  first, which writes
// doubleDescent_data.asy.  Log scale, clipped at 100.
import myutil;
include "doubleDescent_data.asy";

real xu = 0.09cm, yu = 1.6cm;
real y0 = log10(0.5), y1 = 2;
pair P(real p, real e) { return (xu*p, yu*(log10(min(e, 10^y1)) - y0)); }

guide curve(real[] e) {
  guide g;
  for (int i = 0; i < e.length; ++i) g = g--P(i + 1, e[i]);
  return g;
}

draw(box(P(0, 10^y0), P(100, 10^y1)));
for (int p = 0; p <= 100; p += 20) {
  draw(P(p, 10^y0)--P(p, 10^y0) + (0, 3));
  label(string(p), P(p, 10^y0), S, fontsize(9pt));
}
real[] ticks = {0.5, 1, 10, 100};
for (real t : ticks) {
  draw(P(0, t)--P(0, t) + (3, 0));
  label(string(t), P(0, t), W, fontsize(9pt));
}
label("number of features $p$", P(50, 10^y0) - (0, 18), fontsize(10pt));
label(rotate(90)*Label("test error", fontsize(10pt)), P(0, 3) - (28, 0));

draw(P(m, 10^y0)--P(m, 10^y1), gray(0.5) + dashed);
label("$p = m$", P(m, 10^y1), N, fontsize(9pt));

pen pm = black + linewidth(1.2), pr = blue + linewidth(1) + dashed;
draw(curve(errMN), pm);
draw(curve(errRidge), pr);

pair o = P(45, 45);
draw(o--o + (18, 0), pm);
label("least squares (minimum norm)", o + (22, 0), E, fontsize(9pt));
draw(o - (0, 12)--o - (0, 12) + (18, 0), pr);
label("ridge, $\eta = " + string(eta) + "$", o - (0, 12) + (22, 0), E,
      fontsize(9pt));
ship();
erase();
