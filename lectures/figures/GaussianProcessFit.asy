size(200,0);

import cholesky;
import stats;
import graph;
import myutil;

int n = 6;

pair[] p;
real[] y;
real sigma = 0.05;
real l=1;
real g = 1.0;


for(int i=0; i<n; ++i) {
  y.push(cos(g*i)+sigma*Gaussrand());
  p.push((g*i, y[i]));
}

real[][] A = new real[n][n];

{
for(int i=0; i<n ;++i) {
  for(int j=0; j<n; ++j) {
    A[i][j] = exp(-0.5*(p[i].x-p[j].x)^2/(l*l));
  }
  A[i][i] += sigma*sigma;
}

real[][] L = cholesky(A);
real[] alpha = CholFullSolve(L, y);

real[] k = new real[n];
guide g0, g1, g2;
guide gtrue;
for (real x=-0.4; x<g*n-0.1; x+=0.1) {
  for (int i=0; i<n; ++i) {
    k[i] = exp(-0.5*(p[i].x-x)^2/(l*l));
  }
  real f = dot(k,alpha);
  real[] v = CholSolve(L, k);
  real sd = sqrt(1-dot(v,v));
  g0 = g0..(x, f);
  g1 = g1..(x, f+sd);
  g2 = g2..(x, f-sd);
  gtrue = gtrue..(x, cos(x));
}

draw((-0.5,0)--(g*n+0.1,0), Arrow);
draw((0,-1.4)--(0, 1.5), Arrow);
label("$y$", (0, 1.5), N);
label("$x$", (g*n+0.1,0), E);
draw(gtrue, blue+dashed);

ship();
     
for(int i=0; i<n; ++i) {
  label("\large $\bm{\times}$", p[i], red);
}

ship();

label("$\ell =1$", (0.5*(g*n+0.1),1.3));
draw(g0, linewidth(2));

ship();

fill(g1--reverse(g2)--cycle, gray(0.7));
draw(gtrue, blue+dashed);
draw(g0, linewidth(2));
for(int i=0; i<n; ++i) {
  label("\large $\bm{\times}$", p[i], red);
}

ship();
}
erase();
l=0.5;

{
for(int i=0; i<n ;++i) {
  for(int j=0; j<n; ++j) {
    A[i][j] = exp(-0.5*(p[i].x-p[j].x)^2/(l*l));
  }
  A[i][i] += sigma*sigma;
}

real[][] L = cholesky(A);
real[] alpha = CholFullSolve(L, y);

real[] k = new real[n];
guide g0, g1, g2;
guide gtrue;
for (real x=-0.4; x<g*n-0.1; x+=0.1) {
  for (int i=0; i<n; ++i) {
    k[i] = exp(-0.5*(p[i].x-x)^2/(l*l));
  }
  real f = dot(k,alpha);
  real[] v = CholSolve(L, k);
  real sd = sqrt(1-dot(v,v));
  g0 = g0..(x, f);
  g1 = g1..(x, f+sd);
  g2 = g2..(x, f-sd);
  gtrue = gtrue..(x, cos(x));
}

draw((-0.5,0)--(g*n+0.1,0), Arrow);
draw((0,-1.4)--(0, 1.5), Arrow);
label("$y$", (0, 1.5), N);
label("$x$", (g*n+0.1,0), E);
draw(gtrue, blue+dashed);

     
for(int i=0; i<n; ++i) {
  label("\large $\bm{\times}$", p[i], red);
}

ship();

label("$\ell = \tfrac{1}{2}$", (0.5*(g*n+0.1),1.3));
draw(g0, linewidth(2));

ship();

fill(g1--reverse(g2)--cycle, gray(0.7));
draw(gtrue, blue+dashed);
draw(g0, linewidth(2));
for(int i=0; i<n; ++i) {
  label("\large $\bm{\times}$", p[i], red);
}

ship();
}
