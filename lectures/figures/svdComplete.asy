// Matrix completion by iterated truncated SVD (frames for \multipdf).
// The numbers are real: run  python svdComplete.py  first, which writes
// svdComplete_data.asy (true matrix T, mask W, each iterate, RMS error on
// the hidden entries).  Replaces an older version whose "iterations" were
// random noise.
settings.outformat = "pdf";
import myutil;
usepackage("xcolor");
include "svdComplete_data.asy";

unitsize(1cm);
int m = T.length, n = T[0].length;

// observed entries black; hidden ones blue (or red for the true values);
// greyObserved marks entries the next step will overwrite with the data
string showMatrix(real[][] M, bool question, bool greyObserved, string hidden) {
  string cols = "";
  for (int j = 0; j < n; ++j) cols += "r";
  string s = "$\left(\begin{array}{" + cols + "}";
  for (int i = 0; i < m; ++i) {
    for (int j = 0; j < n; ++j) {
      string v = format("%#.1f", M[i][j]);
      if (!W[i][j])
        s += "\textcolor{" + hidden + "}{" + (question ? "?" : v) + "}";
      else
        s += greyObserved ? "\textcolor{gray}{" + v + "}" : v;
      if (j < n-1) s += " & ";
    }
    if (i < m-1) s += "\\";
  }
  return s + "\end{array}\right)$";
}

void frame(string title, string matrix, string note) {
  erase();
  draw(box((-5.2,-2.4), (5.2,2.6)), invisible);    // same size every frame
  label(title, (0,2.1));
  label(matrix, (0,0));
  label(note, (0,-2.0));
}

string rms(real e) { return "RMS error on hidden entries: " + format("%.2f", e); }

frame("$\mat{X}$: observed ratings, ? = missing", showMatrix(T, true, false, "blue"), "");
ship();
frame("$\mat{X}(0) = \mat{W}\odot\mat{X} + \overline{\mat{W}}\odot(\bm{\mu}\,\bm{1}^\tr)$ (user means)",
      showMatrix(F[0], false, false, "blue"), rms(err[0]));
ship();
for (int k = 1; k < F.length; ++k) {
  int t = (k-1) # 2;
  if (kind[k] == "lowrank")
    frame("$\mat{L}(" + string(t) + ")$: best rank-2 approximation of $\mat{X}(" + string(t) + ")$",
          showMatrix(F[k], false, true, "blue"), "");
  else
    frame("$\mat{X}(" + string(t+1) + ") = \mat{W}\odot\mat{X} + \overline{\mat{W}}\odot\mat{L}(" + string(t) + ")$",
          showMatrix(F[k], false, false, "blue"), rms(err[k]));
  ship();
}
frame("True values of the hidden entries", showMatrix(T, false, false, "red"),
      "final RMS error " + format("%.2f", err[err.length-1]) + " (from " + format("%.2f", err[0]) + " with means)");
ship();
