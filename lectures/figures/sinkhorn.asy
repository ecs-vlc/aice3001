// The Sinkhorn algorithm on a 10x10 transport problem, laid out like
// transportationCost.asy: p(x) on the left (rows), q(y) on top (columns),
// the plan gamma as grey cells.  Colour code: rows / p / u in blue,
// columns / q / v in green.  The numbers are computed here (deterministic).
// Frames: 0 cost d, 1 kernel K, 2 start (gamma proportional to K),
// 3-6 two iterations (v-step, u-step), 7 after 10 iterations.
settings.outformat = "pdf";
import myutil;
import palette;
usepackage("xcolor");
texpreamble("\definecolor{heavygreen}{rgb}{0,0.5,0}");   // as in Asymptote
unitsize(0.5cm);

int n = 10;
real eps = 0.5;
real s = 5;                                   // bar length per unit probability
pen rowpen = blue+linewidth(1.2), colpen = heavygreen+linewidth(1.2);
pen[] col = Rainbow(n);

real[] gauss(real m, real sd) {
  real[] w = new real[n]; real t = 0;
  for (int i = 0; i < n; ++i) { w[i] = exp(-(i-m)^2/(2*sd^2)); t += w[i]; }
  for (int i = 0; i < n; ++i) w[i] /= t;
  return w;
}
real[] p = gauss(3, 1.4);
real[] q1 = gauss(5.5, 1.0), q2 = gauss(8, 0.8), q = new real[n];
for (int i = 0; i < n; ++i) q[i] = 0.6*q1[i] + 0.4*q2[i];

real[][] D = new real[n][n], K = new real[n][n];
real Ksum = 0;
for (int r = 0; r < n; ++r)
  for (int c = 0; c < n; ++c) {
    D[r][c] = abs(r-c); K[r][c] = exp(-D[r][c]/eps); Ksum += K[r][c];
  }
real[] u = array(n, 1/Ksum), v = array(n, 1.0);

real[][] plan() {
  real[][] g = new real[n][n];
  for (int r = 0; r < n; ++r) for (int c = 0; c < n; ++c) g[r][c] = u[r]*K[r][c]*v[c];
  return g;
}
void vstep() {
  for (int c = 0; c < n; ++c) { real t = 0; for (int r = 0; r < n; ++r) t += K[r][c]*u[r]; v[c] = q[c]/t; }
}
void ustep() {
  for (int r = 0; r < n; ++r) { real t = 0; for (int c = 0; c < n; ++c) t += K[r][c]*v[c]; u[r] = p[r]/t; }
}
real cost(real[][] g) { real t = 0; for (int r = 0; r < n; ++r) for (int c = 0; c < n; ++c) t += g[r][c]*D[r][c]; return t; }

// exact W1 in one dimension: sum of |F_p - F_q| (unit spacing)
real W1 = 0, Fp = 0, Fq = 0;
for (int i = 0; i < n; ++i) { Fp += p[i]; Fq += q[i]; W1 += abs(Fp-Fq); }

// grey scale for the plan: common to every frame
real gmax = 0;
{ real[] u0 = copy(u), v0 = copy(v);
  for (int k = 0; k < 10; ++k) { vstep(); ustep(); }
  real[][] g = plan();
  for (int r = 0; r < n; ++r) for (int c = 0; c < n; ++c) gmax = max(gmax, g[r][c]);
  u = u0; v = v0; }

void frame(string title, string upd, string note) {
  erase();
  draw(box((-4.5,-6.2), (n+4.5, n+5)), invisible);   // same size every frame
  for (int i = 0; i < n; ++i) {
    filldraw(box((-1, i), (-1-s*p[i], i+1)), col[i]);
    filldraw(box((i, n+1), (i+1, n+1+s*q[i])), gray(0.8));
  }
  label("$q(y)$", (0.5, n+3.5), heavygreen);
  label("$y$", (n, n+1), E);
  label(rotate(90)*Label("$p(x)$"), (-3, 1.5), blue);
  label(rotate(90)*Label("$x$"), (-1, n), N);
  label(title, (n/2, -1.3));
  label(upd, (n/2, -2.9));
  label(note, (n/2, -4.7));
}
void grid() { for (int r = 0; r < n; ++r) for (int c = 0; c < n; ++c) draw(box((c,r),(c+1,r+1)), gray(0.6)); }
void shade(real[][] M, real top, pen hi) {
  for (int r = 0; r < n; ++r) for (int c = 0; c < n; ++c) {
    real t = min(1, M[r][c]/top);
    filldraw(box((c,r),(c+1,r+1)), t*hi + (1-t)*white, gray(0.6));
  }
}
// current row and column sums drawn over p and q
void marginals(real[][] g) {
  for (int i = 0; i < n; ++i) {
    real rs = 0, cs = 0;
    for (int j = 0; j < n; ++j) { rs += g[i][j]; cs += g[j][i]; }
    draw(box((-1, i+0.1), (-1-s*rs, i+0.9)), rowpen);
    draw(box((i+0.1, n+1), (i+0.9, n+1+s*cs)), colpen);
  }
}
string gform = "$\gamma = \mathrm{diag}(\textcolor{blue}{\bm{u}})\,\mat{K}\,\mathrm{diag}(\textcolor{heavygreen}{\bm{v}})$";
string vupd = "$\textcolor{heavygreen}{\bm{v}} \leftarrow \textcolor{heavygreen}{\bm{q}}\oslash(\mat{K}^{\mathsf{T}}\textcolor{blue}{\bm{u}})$";
string uupd = "$\textcolor{blue}{\bm{u}} \leftarrow \textcolor{blue}{\bm{p}}\oslash(\mat{K}\textcolor{heavygreen}{\bm{v}})$";

// 0: the cost
frame("cost $d_{ij} = |x_i - y_j|$", "", "");
shade(D, n-1, red);
ship();
// 1: the kernel
frame("kernel $K_{ij} = \mathrm{e}^{-d_{ij}/\epsilon}$, $\epsilon = " + string(eps) + "$", "", gform);
shade(K, 1, black);
ship();
// 2: start
frame("start: $\gamma\propto\mat{K}$", "$\textcolor{blue}{\bm{u}} = \bm{1}/\sum_{ij}K_{ij}$, $\textcolor{heavygreen}{\bm{v}} = \bm{1}$", gform);
shade(plan(), gmax, black); marginals(plan());
ship();
// 3-6: two iterations, one half-step per frame
for (int it = 1; it <= 2; ++it) {
  vstep();
  frame("iteration " + string(it) + ": columns now sum to $\textcolor{heavygreen}{\bm{q}}$", vupd, gform);
  shade(plan(), gmax, black); marginals(plan());
  ship();
  ustep();
  frame("iteration " + string(it) + ": rows now sum to $\textcolor{blue}{\bm{p}}$", uupd, gform);
  shade(plan(), gmax, black); marginals(plan());
  ship();
}
// 7: converged
for (int it = 3; it <= 10; ++it) { vstep(); ustep(); }
frame("after 10 iterations: cost $= " + format("%#.3f", cost(plan())) + "$",
      "exact Wasserstein distance $= " + format("%#.3f", W1) + "$", gform);
shade(plan(), gmax, black); marginals(plan());
ship();

// without this, asy ships the last picture again as sinkhorn.pdf at exit
erase();
