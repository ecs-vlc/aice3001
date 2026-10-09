settings.outformat="pdf";
import myutil;
size(300,0);

int n = 20;

real[] f = new real[n];
real[] g = new real[n];
real[] h = new real[n];

real fn = 0.0;
real gn = 0.0;
real hn = 0.0;
for(int i=0; i<n; ++i) {
  real x = 0.5*(i-n/2);
  f[i] = exp(-0.5*x*x);
  fn += f[i];
  g[i] = 0.7*exp(-0.7*(x-1)*(x-1)) + 0.3*exp(-0.9*(x+1.5)*(x+1.5));
  gn += g[i];
  h[i] = 0.61*exp(-0.5*(x)*(x)) + 0.39*exp(-0.9*(x+1.5)*(x+1.5));
  hn += h[i];
}
for(int i=0; i<n; ++i) {
  f[i] /= fn;
  g[i] /= gn;
  h[i] /= hn;
}

void fig(real[] g) {
  real s = 5.0;
  real gy = -2;
  real dx = 0.3;
  real kl = 0;
  for(int i=0; i<n; ++i) {
    real x = dx*(i-n/2);
    filldraw((x,0)--(x,s*f[i])--(x+dx,s*f[i])--(x+dx,0)--cycle, lightblue);
    filldraw((x,gy)--(x,s*g[i]+gy)--(x+dx,s*g[i]+gy)--(x+dx,gy)--cycle, lightred);
    draw((x,0)--(x,-0.05));
    draw((x,gy)--(x,gy-0.05));
    kl += f[i]*log(f[i]/g[i]);
  }

  draw((-n*dx/2,1)--(-n*dx/2,0)--(n*dx/2,0), Arrows);
  draw((-n*dx/2,1+gy)--(-n*dx/2,gy)--(n*dx/2,gy), Arrows);

  int i = floor(2*n/3);
  real x = dx*(i-n/2);
  label("$i$", (x+0.5*dx,0), S);
  label("$f_i$", (x+dx,s*f[i]), E);
  label("$i$", (x+0.5*dx,gy), S);
  label("$g_i$", (x+dx,s*g[i]+gy), E);

  label("$\displaystyle \mathrm{KL}(\bm{f}\|\bm{g}) = -\sum_{i=1}^n f_i \, \log\!\left( \frac{g_i}{f_i} \right) = " + string(kl,3) + "$", (0,gy-1));
}

fig(g);
ship();
erase();
fig(h);
ship();
