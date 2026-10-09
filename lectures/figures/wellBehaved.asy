size(500,0);

import graph;
import myutil;
real u = 3;

real gauss(real x) {
  return u*exp(-0.5*(x-1)*(x-1)/0.25)/sqrt(2*pi*0.5);
}


draw(graph(gauss,-2,4), red);
draw((-2,0)--(4.2,0), Arrow);
draw((0,0)--(0,0.8u), Arrow);
label("$\theta$", (4.2,0), E);
label("$f(\theta|\mathcal{D})$", (0,0.8u), E);

pair s = (6,0);

real cauchy(real x) {
  return u*2.0/(pi*(1+x*x));
}

draw(shift(s)*graph(cauchy,0,6), red);
draw(s+(0,0)--s+(6.2,0), Arrow);
draw(s+(0,0)--s+(0,0.8u), Arrow);
label("$\theta$", s+(6.2,0), E);
label("$f(\theta|\mathcal{D})$", s+(0,0.8u), E);

ship();

label("Well behaved", (2,0.5*u), E,  blue);

ship();

label("Thick tailed", s+(2, 0.35*u), NE, blue);
label("Poorly behaved", s+(2, 0.35*u), SE, blue);

ship();
