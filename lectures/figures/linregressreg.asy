import myutil;
import graph;
size(250,0);

real eta = 0.1;

real f(real is) {
  if (is == 0.0)
    return 0.0;
  real s = 1.0/is;
  return s/(s*s+eta);
}

draw((0,2.5)--(0,0)--(7.1,0), Arrows);
label("$\frac{s_i}{s_i^2+\eta}$", (6, f(6)), N, red);
label("$\frac{1}{s_i}$", (7.1,0), E);
real ms = sqrt(eta);
draw((1.0/ms, 0)--(1.0/ms,-0.1));
label("\tiny $s_i\!=\!\sqrt{\eta}$", (1.0/ms,-0.1), S);
draw((0, 0.5/ms)--(-0.1, 0.5/ms));
label("$\frac{1}{2\,\sqrt{\eta}}$", (-0.1, 0.5/ms),W);
draw((0,0)--(2.4,2.4), heavygreen+dashed);
label("$\frac{1}{s_i}$", (2.4,2.4), E, heavygreen);

draw(graph(f,0,7), red);
