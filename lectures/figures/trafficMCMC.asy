size(300,150,IgnoreAspect);
import graph;
import stats;
import myutil;

real mu = 5;
real g = exp(-mu);

int pois() {
  int pdev = -1;
  real t = 1.0;
  do {
    ++pdev;
    t *= (rand()/randMax);
  } while (t>g);
  return pdev;
}

real[] lgamma = new real[10000];
lgamma[0]=0;
lgamma[1]=0;
for(int i=2; i<10000; ++i) {
  lgamma[i] = lgamma[i-1]+log(i-1.0);
}


int a = 0;
real b = 0;

real Gamma(real x) {
  return exp(a*log(b) + (a-1)*log(x) -b*x -lgamma[a]);
}

real GammaDist(real x, real a, real b) {
  return exp(a*log(b) + (a-1)*log(x) -b*x -log(gamma(a)));
}

real udev() {return rand()/randMax;}

real GammaDev1(real alpha) {
  static real old_alpha=1.0;
  static real a, b, m, d, f;

  if (alpha<2.5) {
    if (alpha != old_alpha) {
      old_alpha = alpha;
      a = alpha - 1;
      b = (alpha+1.0/(6.0*alpha))/a;
      m = 2.0/a;
      d = m + 2;
    }
    while (true) {
      real X = udev();
      real V = b*udev()/X;
      if (m*X-d+V+1.0/V <= 0.0)
	return a*V;
      if (m*log(X)-log(V)+V-1.0 <= 0.0)
	return a*V;
    }
  }
  if (alpha != old_alpha) {
    old_alpha = alpha;
    a = alpha - 1;
    b = (alpha+1.0/(6.0*alpha))/a;
    m = 2.0/a;
    d = m + 2;
    f = sqrt(alpha);
  }
  while (true) {
    real X, Y;
    do {
      Y = udev();
      X = Y + (1.0-1.85776388496*udev())/f;
    } while (X<0.0||X>1.0);
    real V = b*Y/X;
    if (m*X-d+V+1.0/V <= 0.0)
      return a*V;
    if (m*log(X)-log(V)+V-1.0 <= 0.0)
      return a*V;
  }
  return 1.0;
}

real GammaDev(real a, real b) {
  return GammaDev1(a)/b;
}

draw((0,1.3)--(0,0)--(11,0), Arrows);
for(int x=0; x<=10; x+=5) {
  draw((x,0)--(x,-0.05));
  label(string(x), (x,-0.05),S);
}
label("$\mu$", (11,0), E);

real prior(real x) {return 2/x;}


bool bd=true;
for(real y=0; y<=1; y+=0.5) {
  if (bd) {
    draw((0,y)--(-0.2,y));
    label(string(y), (-0.2,y),W);
  } else
    draw((0,y)--(-0.1,y));
  bd = !bd;
}

string str = "$\mathcal{D} = \{ ";

int X[];
for(int i=0; i<20; ++i) {
  int r = pois();
  X.push(r);
  a += r;
  ++b;
  if (i>0)
    str += ", ";
  str += string(r);
}
write(a, b);
label(str+"\}$", (0,1.4), NE);
draw(graph(Gamma, 0.001, 10, operator--), blue);
ship();
picture bg = new picture;
add(bg, currentpicture);
picture samples = new picture;

int T = 40000;
real aa[];
real mu = 4;
int n = X.length;
for(int t=0; t<2*T; ++t) {
  real mup = GammaDev(mu*mu, mu);
  if (t<10) {
    add(samples);
    draw((mu,0)::(0.5*(mu+mup), 0.2)::(mup,0), Arrow);
    label("\large $\bm{\times}$", (mu, 0), blue);
    label("\large $\bm{\times}$", (mup, 0), red);
    ship();
    erase();
    add(bg);
  }
  real lr = log(mup/mu);
  real sum = 0;
  for(int i=0; i<X.length; ++i)
    sum += X[i]*lr;
  real r = GammaDist(mu,mup*mup,mup)*exp(-n*(mup-mu)+sum)*mu/(mup*GammaDist(mup,mu*mu,mu));
  if (r>1 || r>rand()/randMax) {
    if (t<10) {
      label(samples, "\small $\times$", (mu, 0), blue);
    }
    mu = mup;
  }
  if (t>T)
    aa.push(mu);
}
histogram(aa,0,max(aa),50, true, lightred);
draw(graph(Gamma, 0.001, 10, operator--), blue);
ship();
