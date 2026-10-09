settings.outformat="pdf";
size(400,150,IgnoreAspect);

import graph;
import myutil;

real lambda = 1.0;

real f(real x)
{
  return lambda*exp(-lambda*x);
}

real F(real x)
{
  return 1-exp(-lambda*x);
}

real Finv(real U) {
  return -log(1-U);
}

draw(graph(f,0, 5,operator..),red);

xaxis(0,5,LeftTicks);
yaxis(0,1,RightTicks);
label("$\mathrm{Exp}(x|1)= \mathrm{e}^{-x}$", (0,1.05), N);
label("$x$", (5,0), E);

draw(shift(7,0)*graph(F,0, 5,operator..),red);

picture pic;
xaxis(pic,0,5,LeftTicks(5,2));
yaxis(pic,0,1,RightTicks);
add(shift(7,0)*pic);
label("$F(x|1)= \int\limits_{0}^x \mathrm{Exp}(y|1) \mathrm{d} y = 1- \mathrm{e}^{-x}$", (7,0.98), N);
label("$x$", (12, 0), E);

ship();

picture bg = new picture;

add(bg, currentpicture);

int n = 50;

real[] samples = new real[n];

for(int i=0; i<n; ++i) {
  real u = rand()/randMax;
  samples[i] = Finv(u);
  if (i<5) {
    erase();
    add(bg);
    draw((7,u)--(7+Finv(u), u)--(7+Finv(u), 0), blue, Arrow);
    for(int j=0; j<=i; ++j) {
      label("$\times$", (samples[j], 0), blue);
    }
    ship();
  }
}

erase();
add(bg);
for(int j=0; j<n; ++j) {
  label("$\times$", (samples[j], 0), blue);
}
ship();
import stats;
erase();
histogram(samples,0,5,10,normalize=true,low=0,lightred,black,bars=false);
add(bg);
ship();

for(int i=0; i<250; ++i) {
  real u = rand()/randMax;
  samples.push(Finv(u));
}

erase();
histogram(samples,0,5,10,normalize=true,low=0,lightred,black,bars=false);
add(bg);
ship();

for(int i=0; i<700; ++i) {
  real u = rand()/randMax;
  samples.push(Finv(u));
}

erase();
histogram(samples,0,5,20,normalize=true,low=0,lightred,black,bars=false);
add(bg);
ship();
