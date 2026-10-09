size(250,150,IgnoreAspect);

import stats;
import graph;
import myutil;
import gsl;

real f(real x) {
  return 0.6*exp(-x^2/8)/sqrt(8*pi) + 0.4*exp(-3*(x-4)^2)/sqrt(pi/3);
}

write(simpson(f, -15, 15));
//exit();

srand(1231);


real[] data = array(100000, 0.0);

for(int t=0; t<=2000; ++t) {
  if (t<6 || (t<50 && t%10==0) || (t<500 && t%50==0) || (t%100==0)) {
    int nobins = 50;
    filldraw(box((-5,-0.01),(7,1.1)), gray(0.99), white);
    draw((-5,0)--(7,0));
    draw(graph(f,-5, 7, operator..,n=500), blue);
    xaxis();
    yaxis(ymax= 1.1*f(4));
    histogram(data, -5, 7, nobins, true);
    string str = "$T = " + string(t) + "$";
    label(str, (1, 1.7*f(0) ),N);
    clip(box((-5,-0.01),(7,1.1)));
    ship();
    erase();
  }
  for (int i=0; i<data.length; ++i) {
    real x = data[i];
    real xnew = x + 0.2*Gaussrand();
    bool accept = true;
    if (f(xnew)<f(x)) {
      if ((f(x)*rand())>(f(xnew)*randMax))
	accept=false;
    }
    if (accept) {
      data[i] = xnew;
    //    label("$\times$", (x,0));
    }
  }
}
