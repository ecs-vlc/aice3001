size(420,0);

import myutil;

picture bgpic;

draw(bgpic, box((-0.35,-0.6),(10.1,6)), white);
draw(bgpic, (0,5)--(0,0)--(10,0)--(10,5), Arrows);
label(bgpic, "$p$", (5,-0.5));
for(real x=0; x<1.001; x+=0.1) {
  draw(bgpic, (10*x,0)--(10*x,-0.05));
  label(bgpic, string(x,2),(10*x,-0.05),S);
}
for(int y=0; y<=4; ++y) {
  draw(bgpic, (0,y)--(-0.05,y));
  label(bgpic, string(y),(-0.05,y), W);
}



real[] logfac = new real[100];
logfac[0] = 0;
for(int i=1; i<100; ++i) {
  logfac[i] = logfac[i-1] + log(i);
}

real logibeta(int a, int b) {
  return logfac[a+b-1] - logfac[a-1] - logfac[b-1];
}


int a = 1;
int b = 1;
real lognorm = 1;

real beta(real x) {
  real p = x/10;
  return exp(lognorm+(a-1)*log(p)+(b-1)*log(1-p));
}

import graph;

void show() {
  add(bgpic);
  lognorm = logibeta(a,b);
  draw(graph(beta, 0.0001, 9.999, operator..), red);
  label("\large $f(p|\mathcal{D})=\frac{p^{" + string(a-1)
	+ "}\, (1-p)^{" + string(b-1) + "}}{B(" + string(a)
	+ "," + string(b) + ")}$", (0,5), 2E);
  label("$a = " + string(a) + ",\,\,b = " + string(b) + "$", (5, 5), NE);
  ship();
  erase();
}

show();

string history = "$\mathcal{D}= \{$";

srand(123);

for(int i=0; i<30; ++i) {
  int r = (rand() > 0.3*randMax)? 1:0;
  history = history + ((r==1)? "H":"T");
  if (r==1)
    ++a;
  else
    ++b;
  if (i<29)
    history += ",";
  else
    history += "$\}$";
  label(history, (0,5.6), NE);
  show();
}

write(a,b);
