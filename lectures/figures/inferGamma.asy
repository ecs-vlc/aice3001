size(400,0);
import graph;
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
  return 4*exp(a*log(b) + (a-1)*log(x) -b*x -lgamma[a]);
}

picture bgpic;


draw(bgpic, box((-2,-2),(23,10)), white);

draw(bgpic, (0,6)--(0,0)--(21,0), Arrows);
for(int x=0; x<=20; x+=5) {
  draw(bgpic, (x,0)--(x,-0.2));
  label(bgpic, string(x), (x,-0.2),S);
}
label(bgpic, "$\mu$", (21,0), E);

void show() {
  add(bgpic);
  label("$p(\mu|" + string(a) + "," + string(b) + ") = \frac{ "
	+ string(b) + "^{" + string(a) +" } \, \mu^{" + string(a-1)
	+ "} \, \mathrm{e}^{" + string(-b) + "\,\mu}}{\Gamma("
	+ string(a) + ")}$", (-1,6), NE);
  label("$a= " + string(a) + ",\,\,b= " + string(b) + "$", (10,6.3), NE);
  ship();
  erase();
}

real prior(real x) {return 2/x;}

draw(graph(prior, 0.32, 20, operator..), red+dashed);

show();
bool bd=true;
for(real y=0; y<=1; y+=0.5) {
  if (bd) {
    draw(bgpic, (0,4*y)--(-0.2,4*y));
    label(bgpic, string(y), (-0.2,4*y),W);
  } else
    draw(bgpic, (0,4*y)--(-0.1,4*y));
  bd = !bd;
}

int r = pois();
string str = "$\mathcal{D} = \{ " + string(r);


for(int i=0; i<20; ++i) {
  a += r;
  ++b;
  draw(graph(Gamma, 0.001, 20, operator--,n=200), red);
  label(str+"\}$", (0,8), NE);
  show();
  r = pois();
  str += ", " + string(r);
}
