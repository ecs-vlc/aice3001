settings.outformat="pdf";
import graph;
import stats;
import myutil;

size(500,250,IgnoreAspect);

real p = 0.3;
real mu1 = 4.0;
real sigma1 = 0.8;
real mu2 = 8.0;
real sigma2 = 2;


int n = 1000;

real[] X = new real[1000];

for(int i=0; i<n; ++i) {
  if (rand()<p*randMax)
    X[i] = sigma1*Gaussrand() + mu1;
  else
    X[i] = sigma2*Gaussrand() + mu2;
  if (X[i]<0)
    X[i] = rand()/randMax;
}
histogram(X,0,15,40,normalize=true,low=0,lightred,black,bars=false);
dot((15,0),linewidth(0.01));
dot((0,0),linewidth(0.01));
yaxis("$f(x)$",LeftRight,0,0.25,RightTicks(trailingzero,5));
xaxis("$x$",BottomTop,0,15,LeftTicks(3));

shipout("mixtureOfGaussiansData");


struct Theta {
  real p1;
  real mu1;
  real var1;
  real sigma1;
  real p2;
  real mu2;
  real var2;
  real sigma2;
  static Theta Theta(real p1in, real mu1in, real var1in, real mu2in, real var2in) {
    Theta theta = new Theta;
    theta.p1 = p1in;
    theta.mu1 = mu1in;
    theta.var1 = var1in;
    theta.sigma1 = sqrt(var1in);
    theta.p2 = 1-p1in;
    theta.mu2 = mu2in;
    theta.var2 = var2in;
    theta.sigma2 = sqrt(var2in);
    return theta;
  }
  void write() {
    string s = "p=" + string(this.p1,3); 
    string s = s + ", mu1=" + string(this.mu1,3); 
    string s = s + ", var1=" + string(this.var1,3); 
    string s = s + ", mu2=" + string(this.mu2,3); 
    string s = s + ", var2=" + string(this.var2,3); 
    write(s);
  }
}

from Theta unravel Theta;

Theta theta0 = Theta(p, mu1, sigma1*sigma1, mu2, sigma2*sigma2);


real normal(real x, real mu, real var) {
  return exp(-0.5*(x-mu)*(x-mu)/var)/sqrt(2*pi*var);
}

Theta theta = Theta(0.5,3,1.5,9,0.8);

int T = 50;
real muMax = 13;
real sigmaMax = 3;
real pMax = 1.2;
pair dt = (0,0.002);
real height = 0.06;

pair mupos(real t, real mu) {
  return (17+6*t/T, height*mu/muMax-0.01);
}

draw(mupos(0,muMax)--mupos(0,0)--mupos(55,0), Arrows(4));
label("$\mu_i$", mupos(0,muMax), N);
label("$t$", mupos(55,0), E);
for(int t=0; t<=T; t+=10) {
  draw(mupos(t,0)--mupos(t,0)-dt);
  label(string(t), mupos(t,0)-dt, S);
}

for(int mu=0; mu<=10; mu+=5) {
  draw(mupos(0,mu)--mupos(-1,mu));
  label(string(mu), mupos(-1,mu), W);
}

pair sigmapos(real t, real sigma) {
  return (17+6*t/T, height*sigma/sigmaMax+1.6*height-0.01);
}

draw(sigmapos(0,sigmaMax)--sigmapos(0,0)--sigmapos(55,0), Arrows(4));
label("$\sigma_i$", sigmapos(0,sigmaMax), N);
label("$t$", sigmapos(55,0), E);
for(int t=0; t<=T; t+=10) {
  draw(sigmapos(t,0)--sigmapos(t,0)-dt);
  label(string(t), sigmapos(t,0)-dt, S);
}

for(int sigma=0; sigma<=2; sigma+=1) {
  draw(sigmapos(0,sigma)--sigmapos(-1,sigma));
  label(string(sigma), sigmapos(-1,sigma), W);
}


pair ppos(real t, real p) {
  return (17+6*t/T, height*p/pMax+3.2*height-0.01);
}

draw(ppos(0,pMax)--ppos(0,0)--ppos(55,0), Arrows(4));
label("$p$", ppos(0,pMax), N);
label("$t$", ppos(55,0), E);
for(int t=0; t<=T; t+=10) {
  draw(ppos(t,0)--ppos(t,0)-dt);
  label(string(t), ppos(t,0)-dt, S);
}

for(real p=0; p<=1; p+=0.5) {
  draw(ppos(0,p)--ppos(-1,p));
  label(string(p,1), ppos(-1,p), W);
}

void addLines(Theta theta) {
  draw(mupos(0, theta.mu1)--mupos(T, theta.mu1), red+dashed);
  draw(sigmapos(0, theta.sigma1)--sigmapos(T, theta.sigma1), red+dashed);
  draw(ppos(0, theta.p1)--ppos(T, theta.p1), red+dashed);
  draw(mupos(0, theta.mu2)--mupos(T, theta.mu2), blue+dashed);
  draw(sigmapos(0, theta.sigma2)--sigmapos(T, theta.sigma2), blue+dashed);
  draw(ppos(0, theta.p2)--ppos(T, theta.p2), blue+dashed);
}

addLines(theta0);


picture bg = new picture;
add(bg,currentpicture);

void addPoints(Theta theta, int t) {
  dot(bg, mupos(t, theta.mu1), red);
  dot(bg, sigmapos(t, theta.sigma1), red);
  dot(bg, ppos(t, theta.p1), red);
  dot(bg, mupos(t, theta.mu2), blue);
  dot(bg, sigmapos(t, theta.sigma2), blue);
  dot(bg, ppos(t, theta.p2), blue);
}




real mu = theta.mu1;
real var = theta.var1;
real p = theta.p1;

real Gaussian(real x) {return p*normal(x, mu, var);}


void drawCurves(Theta theta) {
  mu = theta.mu1;
  var = theta.var1;
  p = theta.p1;
  draw(graph(Gaussian,0,15), red+linewidth(2));
  mu = theta.mu2;
  var = theta.var2;
  p = theta.p2;
  draw(graph(Gaussian,0,15), blue+linewidth(2));
}

Theta update(Theta theta) {
  real s1 = 0;
  real sx1 = 0;
  real sxs1 = 0;
  real s2 = 0;
  real sx2 = 0;
  real sxs2 = 0;
  for(int i=0; i<X.length; ++i) {
    real p1 = normal(X[i], theta.mu1, theta.var1)*theta.p1;
    real p2 = normal(X[i], theta.mu2, theta.var2)*theta.p2;
    real p = p1/(p1+p2);
    real q = 1-p;
    s1 += p;
    sx1 += p*X[i];
    sxs1 += p*X[i]*X[i];
    s2 += q;
    sx2 += q*X[i];
    sxs2 += q*X[i]*X[i];
  }
  real mu1 = sx1/s1;
  real mu2 = sx2/s2;
  return Theta(s1/(s1+s2), mu1, (sxs1/s1)-mu1*mu1, mu2, (sxs2/s2)-mu2*mu2);
}

for(int t=0; t<=T; ++t) {
  erase();
  addPoints(theta,t);
  add(bg);
  drawCurves(theta);
  ship();
  theta = update(theta);
}
