// Gaussian-process forecast of CO2 at Mauna Loa (frames for \multipdf).
// The numbers are real: run  python co2GP.py  first, which writes
// co2GP_data.asy.  Frame 0: the training data (1958-2004); frame 1: model A
// (constant mean) with its 2-sd band and what was measured from 2005;
// frame 2 adds model B (with a quadratic trend).
import myutil;
include "co2GP_data.asy";

real t0 = 1958, t1 = 2030, c0 = 300, c1 = 440;
real xu = 0.18cm, yu = 0.032cm;
pair P(real t, real c) { return (xu*(t - t0), yu*(c - c0)); }

pen ptrain = black + linewidth(0.5), ptest = red + linewidth(0.5);
pen pA = blue + linewidth(0.8), bandA = paleblue;
pen pB = heavygreen + linewidth(0.8), bandB = palegreen;

void axes() {
  // invisible box so every frame is the same size
  draw(box(P(t0, c0) - (32, 20), P(t1, c1) + (5, 5)), invisible);
  draw(box(P(t0, c0), P(t1, c1)));
  for (int y = 1960; y <= 2030; y += 10) {
    draw(P(y, c0)--P(y, c0) + (0, 3));
    label(string(y), P(y, c0), S, fontsize(9pt));
  }
  for (int c = 300; c <= 440; c += 20) {
    draw(P(t0, c)--P(t0, c) + (3, 0));
    label(string(c), P(t0, c), W, fontsize(9pt));
  }
  label(rotate(90)*Label("CO$_2$ (ppm)", fontsize(10pt)), P(t0, 370) - (28, 0));
  draw(P(tSplit, c0)--P(tSplit, c1), gray(0.6) + dashed);
}

guide line(real[] x, real[] y) {
  guide g;
  for (int i = 0; i < x.length; ++i) g = g--P(x[i], y[i]);
  return g;
}

void band(real[] mu, real[] sd, pen fillpen) {
  guide up, down;
  for (int i = 0; i < ts.length; ++i) {
    up = up--P(ts[i], min(mu[i] + 2*sd[i], c1));
    down = down--P(ts[i], max(mu[i] - 2*sd[i], c0));
  }
  fill(up--reverse(down)--cycle, fillpen);
}

// legend entries, one row each, so frames only ever add to each other
pair key0 = P(1961, 432);
void key(int row, pen p, string s) {
  pair o = key0 - (0, 12*row);
  draw(o--o + (16, 0), p);
  label(s, o + (20, 0), E, fontsize(9pt));
}

// Frames are cumulative (each adds to the last) so that the printable
// PDF, which overlays all frames, shows no clashing labels.
void frame(int k) {
  axes();
  if (k >= 1) band(muA, sdA, bandA);
  if (k >= 2) band(muB, sdB, bandB);
  if (k >= 1) draw(line(ts, muA), pA);
  if (k >= 2) draw(line(ts, muB), pB);
  draw(line(tTrain, yTrain), ptrain);
  key(0, ptrain, "training data 1958--2004");
  if (k >= 1) {
    draw(line(tTest, yTest), ptest);
    key(1, ptest, "measured after 2004");
    key(2, pA, "A: constant prior mean, $\pm2$ s.d.");
  }
  if (k >= 2) key(3, pB, "B: quadratic trend in the kernel, $\pm2$ s.d.");
  ship();
  erase();
}

for (int k = 0; k < 3; ++k) frame(k);
