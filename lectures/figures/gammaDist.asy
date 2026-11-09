// Gamma distributions in the scaled variable z = b x:
//   Gamma(z|a,1) = z^(a-1) e^(-z) / Gamma(a),
// so a single plot covers every b.  Frames add a = 1/2, 1, 2, 5 in turn.
// a = 1/2 diverges at z = 0, so curves are clipped at the top of the plot.
// Width is three times the height to suit the slides.
import myutil;

real xu = 1.2cm, yu = 3.3cm;
real zmax = 10, ymax = 1.2;
pair P(real z, real y) { return (xu*z, yu*y); }

real[] as = {0.5, 1, 2, 5};
string[] names = {"$a = \frac12$", "$a = 1$", "$a = 2$", "$a = 5$"};
pen[] pens = {red, blue, heavygreen, magenta};

real f(real z, real a) { return exp((a - 1)*log(z) - z - log(gamma(a))); }

void axes() {
  // invisible box so every frame is the same size
  draw(box(P(0, 0) - (30, 22), P(zmax, ymax) + (45, 5)), invisible);
  draw(P(0, 0)--P(zmax, 0));
  draw(P(0, 0)--P(0, ymax));
  for (int z = 0; z <= 10; z += 2) {
    draw(P(z, 0)--P(z, 0) - (0, 3));
    label("$" + string(z) + "$", P(z, 0) - (0, 3), S, fontsize(9pt));
  }
  for (real y = 0; y <= 1.0001; y += 0.5) {
    draw(P(0, y)--P(0, y) - (3, 0));
    label(format("$%#.1f$", y), P(0, y) - (3, 0), W, fontsize(9pt));
  }
  label("$x = b\,z$", P(zmax, 0) + (6, 0), E, fontsize(10pt));
}

guide curve(real a) {
  guide g;
  for (int i = 1; i <= 1000; ++i) {
    real z = zmax*i/1000, y = f(z, a);
    if (y <= ymax) g = g--P(z, y);
  }
  return g;
}

for (int k = 0; k < as.length; ++k) {
  axes();
  for (int j = 0; j <= k; ++j) {
    draw(curve(as[j]), pens[j] + linewidth(1.2));
    pair o = P(6.5, 1.05 - 0.15*j);
    draw(o--o + (18, 0), pens[j] + linewidth(1.2));
    label(names[j], o + (22, 0), E, fontsize(10pt));
  }
  label("$\frac1b\,\mathrm{Gamma}(z|a,b) = \dfrac{(b\,z)^{a-1}\,\mathrm{e}^{-b\,z}}{\Gamma(a)}$",
        P(3.2, 1.0), fontsize(10pt));
  ship();
  erase();
}
