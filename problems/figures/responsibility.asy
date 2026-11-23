// Problem sheet probabilisticInference, 1(c): the mixture density
//   f(x) = N(x|0,1)/2 + N(x|4,1)/2   (left axis)
// and the responsibility gamma(x) = 1/(1 + exp(4x - 8))   (right axis).
// f peaks near 0.2 and gamma runs from 1 to 0, so f is drawn 5 times
// larger and each axis is labelled in its own colour.
settings.outformat="pdf";

real xu = 0.9cm, yu = 3.5cm;       // one unit of x; gamma = 1
real fscale = 5;                    // f = 0.2 sits at the top
real x0 = -3, x1 = 7;
pair P(real x, real y) { return (xu*x, yu*y); }

pen pf = blue + linewidth(1), pg = red + linewidth(1);

real normal(real x, real mu) { return exp(-(x - mu)^2/2)/sqrt(2pi); }
real f(real x) { return (normal(x, 0) + normal(x, 4))/2; }
real gam(real x) { return 1/(1 + exp(4x - 8)); }

guide curve(real g(real), real scale) {
  guide c;
  for (int i = 0; i <= 400; ++i) {
    real x = x0 + (x1 - x0)*i/400;
    c = c--P(x, scale*g(x));
  }
  return c;
}

draw(P(x0, 0)--P(x1, 0));
draw(P(x0, 0)--P(x0, 1.05), pf);
draw(P(x1, 0)--P(x1, 1.05), pg);
for (int x = -2; x <= 6; x += 2) {
  draw(P(x, 0)--P(x, 0) - (0, 3));
  label("$" + string(x) + "$", P(x, 0) - (0, 3), S, fontsize(9pt));
}
label("$x$", P(x1, 0) + (4, -14), fontsize(10pt));
for (int k = 0; k <= 2; ++k) {
  real v = 0.1*k;
  draw(P(x0, fscale*v)--P(x0, fscale*v) - (3, 0), pf);
  label(format("$%#.1f$", v), P(x0, fscale*v) - (3, 0), W, blue + fontsize(9pt));
  real g = 0.5*k;
  draw(P(x1, g)--P(x1, g) + (3, 0), pg);
  label(format("$%#.1f$", g), P(x1, g) + (3, 0), E, red + fontsize(9pt));
}
label(rotate(90)*Label("$f(x)$", blue + fontsize(10pt)), P(x0, 0.5) - (30, 0));
label(rotate(90)*Label("$\gamma(x)$", red + fontsize(10pt)), P(x1, 0.5) + (30, 0));

// gamma(2) = 1/2: the decision boundary halfway between the means
draw(P(2, 0)--P(2, 1), gray(0.6) + dashed);
draw(P(2, 0.5)--P(x1, 0.5), gray(0.6) + dashed);

draw(curve(f, fscale), pf);
draw(curve(gam, 1), pg);
