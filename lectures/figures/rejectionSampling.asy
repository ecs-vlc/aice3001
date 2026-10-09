size(500,150,IgnoreAspect);
srand(6);

import graph;
import myutil;
import stats;

real normal(real x) {
  return exp(-0.5*x*x)/sqrt(2*pi);
}

real cauchy(real x) {
  return 1.53/(pi*(1+x*x));
}

picture bg = new picture;

draw(bg, graph(normal, -7, 7), blue);
xaxis(bg, -7,7, RightTicks);
yaxis(bg, 0, 0.5, RightTicks);
draw(bg, "$x$", (7,0), E);
label(bg, "$\mathcal{N}(x|0,1)$", (1.7,normal(1.7)), W, blue);
add(bg);
ship();

draw(bg, graph(cauchy, -7, 7), red);
label(bg, "$1.53\,\mathrm{Cau}(x)=\frac{1.53}{\pi\,(1+x^2)}$", (0.5,cauchy(0.5)), E, red);
erase();

add(bg);
ship();

real[] sample;

bool reject = false;
for(int i=0; i<70; ++i) {
  real Y = tan(pi*(rand()/randMax-0.5));
  if (abs(Y)>7) {
    --i;
    continue;
  }
  real u = cauchy(Y)*rand()/randMax;
  erase();
  add(bg);
  for(int i=0; i<sample.length; ++i) {
    label("\large$\times$", (sample[i],0), blue);
  }
  draw((Y,0)--(Y,normal(Y)), blue);
  draw((Y,normal(Y))--(Y,cauchy(Y)), red);
  ship();
  if (u<normal(Y)) {
    label("\large$\times$", (Y,u), blue);
    sample.push(Y);
  } else {
    label("\large$\times$", (Y,u), red);
    reject = true;
  }
  ship();
  if (reject && i>5) {
    break;
  }
}

while(sample.length<20) {
  real Y = tan(pi*(rand()/randMax-0.5));
  real u = cauchy(Y)*rand()/randMax;
  if (u<normal(Y)) {
    sample.push(Y);
  }
}

erase();
add(bg);
for(int i=0; i<sample.length; ++i) {
  label("\large$\times$", (sample[i],0), blue);
}
ship();

erase();
histogram(sample,-7,7,14,normalize=true,low=0,lightred,black,bars=false);
add(bg);
ship();

while(sample.length<300) {
  real Y = tan(pi*(rand()/randMax-0.5));
  real u = cauchy(Y)*rand()/randMax;
  if (u<normal(Y)) {
    sample.push(Y);
  }
}

erase();
histogram(sample,-7,7,14,normalize=true,low=0,lightred,black,bars=false);
add(bg);
ship();

while(sample.length<1000) {
  real Y = tan(pi*(rand()/randMax-0.5));
  real u = cauchy(Y)*rand()/randMax;
  if (u<normal(Y)) {
    sample.push(Y);
  }
}

erase();
histogram(sample,-7,7,28,normalize=true,low=0,lightred,black,bars=false);
add(bg);
ship();
