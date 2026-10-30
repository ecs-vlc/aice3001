// Shrinkage in the hierarchical ratings model (frames for \multipdf).
// The numbers are real: run  python ratingsShrink.py  first, which writes
// ratingsShrink_data.asy.  Frame 0: fraction of positive reviews k/n
// against the number of reviews n; frame 1 adds the empirical-Bayes
// posterior means and the prior mean.
import myutil;
include "ratingsShrink_data.asy";

real xu = 2.6cm, yu = 7cm;
real ymin = 0.4, ymax = 1.05, xmax = 3.5;
pair P(real logn, real r) { return (logn*xu, (r - ymin)*yu); }
real L(int m) { return log10(m); }

pen rawpen = red + linewidth(1.3);
pen postpen = blue + linewidth(1.3);
real prior = a/(a + b);

void axes() {
  draw(P(0, ymin)--P(xmax, ymin));
  draw(P(0, ymin)--P(0, ymax));
  for (int d = 0; d <= 3; ++d) {
    draw(P(d, ymin)--P(d, ymin) - (0, 4));
    label("$" + string(10^d) + "$", P(d, ymin) - (0, 4), S, fontsize(9pt));
    for (int s = 2; s <= 9 && d < 3; ++s)
      draw(P(d + log10(s), ymin)--P(d + log10(s), ymin) - (0, 2));
  }
  for (real r = 0.4; r <= 1.001; r += 0.2) {
    draw(P(0, r)--P(0, r) - (4, 0));
    label(format("$%#.1f$", r), P(0, r) - (4, 0), W, fontsize(9pt));
  }
  label("reviews $n_j$", P(xmax/2, ymin) - (0, 18), fontsize(10pt));
  label(rotate(90)*Label("positive fraction", fontsize(10pt)),
        P(0, (ymin + ymax)/2) - (32, 0));
  // invisible box so both frames are the same size
  draw(box(P(0, ymin) - (45, 28), P(xmax, ymax) + (5, 5)), invisible);
}

void raw() {
  for (int j = 0; j < n.length; ++j)
    dot(P(L(n[j]), k[j]/n[j]), rawpen);
  int A = n.length - 2, B = n.length - 1;
  label("$A$", P(L(n[A]), k[A]/n[A]), N, red + fontsize(9pt));
  label("$B$", P(L(n[B]), k[B]/n[B]), N, red + fontsize(9pt));
}

void key(bool both) {
  pair o = P(2.25, 0.63);
  dot(o, rawpen);
  label("$k_j/n_j$", o + (6, 0), E, fontsize(9pt));
  if (both) {
    dot(o - (0, 12), postpen);
    label("posterior mean", o - (0, 12) + (6, 0), E, fontsize(9pt));
    draw(o - (0, 24) - (3, 0)--o - (0, 24) + (3, 0), black + dashed);
    label("prior mean", o - (0, 24) + (6, 0), E, fontsize(9pt));
  }
}

axes(); raw(); key(false);
ship();

erase();
axes();
draw(P(0, prior)--P(xmax, prior), black + dashed);
for (int j = 0; j < n.length; ++j) {
  pair r = P(L(n[j]), k[j]/n[j]), q = P(L(n[j]), post[j]);
  if (abs(r - q) > 3) draw(r--q, gray(0.5), Arrow(4));
}
raw();
for (int j = 0; j < n.length; ++j) dot(P(L(n[j]), post[j]), postpen);
key(true);
ship();
erase();
