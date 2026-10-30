// Graphical models for ProbabilisticInference.tex, in the style of
// LDAGM.asy.  Parameters are filled dark, observed variables shaded,
// latent variables white; a plate (box) means "repeat for each ...".
//   gmModels-0.pdf  hierarchical ratings model (beta-binomial)
//   gmModels-1.pdf  mixture of two Gaussians
import myutil;
unitsize(1cm);

path node(string str, pair pos, pen col=white, real mar=1.5) {
  frame f = newframe;
  pen penCol = (col == gray(0.4)) ? white : black;
  path p = ellipse(f, Label(str, penCol), Fill(col), xmargin=mar);
  draw(f, p);
  add(f, pos);
  return shift(pos)*scale(1/cm)*p;   // frame units are bp; unitsize is 1cm
}

void connect(path p1, path p2) {
  pair a = (min(p1) + max(p1))/2, b = (min(p2) + max(p2))/2;
  path line = a--b;
  real s = intersect(line, p1)[0], t = intersect(line, p2)[0];
  draw(subpath(line, s, t), Arrow(6));
}

void plate(pair ll, pair ur, string lab) {
  draw(box(ll, ur));
  label(lab, (ur.x, ll.y), NW, fontsize(10pt));
}

pen param = gray(0.4), observed = gray(0.8);

// ---- ratings: (a,b) -> theta_j -> k_j <- n_j
path ab = node("$a,\,b$", (0, 0), param);
path th = node("$\theta_j$", (2.6, 0));
path kj = node("$k_j$", (5.0, 0), observed);
path nj = node("$n_j$", (5.0, 1.5), param);
connect(ab, th);
connect(th, kj);
connect(nj, kj);
plate((1.7, -1.0), (5.9, 2.2), "$j = 1,\ldots,J$");
ship();

// ---- mixture: p -> Z_i -> X_i <- mu, sigma^2
erase();
path pp = node("$p$", (0, 0), param);
path zi = node("$Z_i$", (2.6, 0));
path xi = node("$X_i$", (5.0, 0), observed);
path ms = node("$\mu_A,\sigma_A^2,\mu_B,\sigma_B^2$", (5.0, 2.2), param, 1);
connect(pp, zi);
connect(zi, xi);
connect(ms, xi);
plate((1.7, -1.0), (5.9, 0.9), "$i = 1,\ldots,m$");
ship();
erase();
