size(250,150,IgnoreAspect);

import stats;
import graph;
import myutil;

real f(real x) {
  return (2*exp(-x^2/2) + 3*exp(-9*(x-4)^2/2))/sqrt(18*pi);
}

srand(1231);

int nopic = 0;
int steps = 100;
int burn_in = 1000;
for(nopic=0; nopic<6; ++nopic, steps*=10) {
  //  filldraw(box((-5,-0.01),(7,1.1)), gray(0.99), white);
  int cnt=0;
  draw(graph(f,-5, 7, operator..,n=500), blue);
  xaxis();
  yaxis(ymax= 1.1*f(4));
  real x = -5;
  real[] data;
  for(int t=0; t<steps+burn_in;) {
    real xnew = x + 0.2*Gaussrand();
    bool accept = true;
    if (f(xnew)<f(x)) {
      if ((f(x)*rand())>(f(xnew)*randMax))
	accept=false;
    }
    if (t>burn_in)
      ++cnt;
    if (accept) {
      ++t;
      x = xnew;
      //    label("$\times$", (x,0));
    }
    if (t>burn_in) {
      data.push(x);
    }
  }
  int nobins = 100; //bins(data);
  if (steps<10001)
    nobins = bins(data);
  if (nobins<8)
    nobins = 8;
  histogram(data, -5, 7, nobins, true);
  string str = "$T = " + string(steps) + "$, acceptence rate =" + string(steps/cnt,3);
  label(str, (1, 1.7*f(0) ),N);
  ship();
  erase();
}
