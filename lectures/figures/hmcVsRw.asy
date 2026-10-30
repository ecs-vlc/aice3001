// Random-walk Metropolis against HMC on a correlated 2-D Gaussian
// (frames for \multipdf).  The numbers are real: run  python hmcVsRw.py
// first, which writes hmcVsRw_data.asy.  Frame 0: the target; frame 1:
// random walk; frame 2: HMC trajectories (grey) and samples (blue).
import myutil;
include "hmcVsRw_data.asy";

unitsize(0.8cm);
real R = 3.3;                         // half-width of each panel
pair off = (2*R + 1.2, 0);            // offset of the right-hand panel

// contours of the target at 1, 2 and 3 standard deviations
path contour(real r) {
  pair u = (1, 1)/sqrt(2), v = (1, -1)/sqrt(2);
  real a = r*sqrt(1 + rho), b = r*sqrt(1 - rho);
  guide g;
  for (int i = 0; i < 100; ++i) {
    real t = 2pi*i/100;
    g = g..(a*cos(t)*u + b*sin(t)*v);
  }
  return g..cycle;
}

void panel(pair o, string title) {
  draw(shift(o)*box((-R, -R), (R, R)), gray(0.6));
  for (int r = 1; r <= 3; ++r) draw(shift(o)*contour(r), gray(0.75));
  label(title, o + (0, R), N, fontsize(10pt));
  dot(o + rw[0], black + linewidth(3));
}

void frame0() {
  // invisible box so every frame is the same size
  draw(box((-R - 0.2, -R - 0.9), off + (R + 0.2, R + 0.9)), invisible);
  panel((0, 0), "random walk: " + string(nRW) + " steps");
  panel(off, "HMC: " + string(nHMC) + " trajectories of 20 steps");
}

frame0();
ship();

draw(operator--(... rw), red + linewidth(0.5));
for (pair z : rw) dot(z, red + linewidth(1.5));
label(string(accRW) + " of " + string(nRW) + " accepted",
      (0, -R), S, fontsize(9pt));
ship();

for (int i = 0; i < paths.length; ++i)
  draw(shift(off)*(operator--(... paths[i])), gray(0.6) + linewidth(0.4));
for (pair z : hmc) dot(off + z, blue + linewidth(2.5));
label(string(accHMC) + " of " + string(nHMC) + " accepted",
      off + (0, -R), S, fontsize(9pt));
ship();
erase();
