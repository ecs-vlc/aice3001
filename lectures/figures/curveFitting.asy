size(600,300,IgnoreAspect);

import graph;
import stats;
import myutil;

picture background = new picture;

void out() {
  add(background);
  ship();
  erase();
}

draw(graph(tanh,-3,3, operator..), red+dashed);

pair[] data;
for(real x=-2.5; x<2.6; x+=0.5) {
  pair p = (x, tanh(x)+0.1*Gaussrand());
  data.push(p);
  dot(p, blue+linewidth(5));
  draw(p+(0,0.1)--p-(0,0.1), blue);
  draw(p+(-0.02,0.1)--p+(0.02,0.1), blue);
  draw(p-(-0.02,0.1)--p-(0.02,0.1), blue);
}

xaxis("$x$");
yaxis("$y$",-1.5,1.5);

add(background, currentpicture);

erase();
out();

guide fit(pair[] data, int K, real xmin, real xmax) {
  ++K;
  real[][] X = new real[data.length][K];
  real[] y = new real[data.length];
  for(int i=0; i<data.length; ++i) {
    X[i][0] = 1;
    real x = data[i].x;
    y[i] = data[i].y;
    for (int k=1; k<K; ++k) {
      X[i][k] = x*X[i][k-1];
    }
  }
  real[][] Xt = transpose(X);
  real[][] C = Xt*X;
  real[] xy = Xt*y;
  real[] w = solve(C,xy);
  guide g;
  real dx = (xmax-xmin)/100.0;
  real maxy = 1.0;
  for (real x = xmin; x<=xmax; x+=dx) {
    real y = 0;
    real xn = 1;
    for(int k=0; k<K; ++k) {
      y += w[k]*xn;
      xn *= x;
    }
    maxy = max(y,maxy);
    g = g--(x,y);
  }
  string fitlabel = "$y=" + string(w[0],2);
  for(int k=1; k<K; ++k) {
    if (w[k]>0)
      fitlabel += "+";
    fitlabel += string(w[k],2) + "\;x^{" + string(k) + "}";
  }
  fitlabel += "$";
  label(fitlabel, (-3, 0.75*maxy), E, darkgreen);
  return g;
}

draw(fit(data, 1, -2.75, 2.75), darkgreen+linewidth(2));
out();
draw(fit(data, 4, -2.75, 2.75), darkgreen+linewidth(2));
out();
draw(fit(data, 10, -2.52, 2.52), darkgreen+linewidth(2));
out();
