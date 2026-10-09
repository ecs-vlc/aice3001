size(340,0);
import contour;
import stats;
import myutil;

draw((-2.7,0)--(2.7,0), Arrow);
draw((0,-2.7)--(0,2.7), Arrow);
label("$z_1$", (2.7,0), E);
label("$z_2$", (0,2.7), N);
dot((3.8,0), white);
dot((-3.8,0), white);

ship();

pair mu = (0,0);
pair sigma = (1,1);

real f(real x, real y) {
  return exp(-0.5*((x-mu.x)/sigma.x)^2-0.5*((y-mu.y)/sigma.y)^2)/(2*pi*sqrt(sigma.x*sigma.y));
}

real[] level = new real[20];
for(int i=0; i<20; ++i) {
  level[i] = 0.01*i+0.01;
}

draw(contour(f,(-3,-3),(3,3), level), blue);
label("$p_{\bm{z}}(\bm{z})$", (2.3,-1.8), W, blue);
ship();
label("$= \mathcal{N}(\bm{z}|\bm{0}, \mat{I})$",  (2.3,-1.8), E, blue);
ship();

for(int i=0; i<20; ++i) {
  level[i] = 0.5*i+0.5;
}

for(int s=0; s<50; ++s) {
  mu = (Gaussrand(), Gaussrand());
  sigma = 0.08*(0.5+rand()/randMax, 0.5+rand()/randMax);
  draw(contour(f,mu+(-1,-1),mu+(1,1), level), red);
}

mu = (-1.,2.1);
sigma=(0.06, 0.08);
draw(contour(f,mu+(-1,-1),mu+(1,1), level), red);
label("$q(\bm{z}| \bm{\mu}(\bm{x}), \bm{\sigma}(\bm{x}))$", mu, 2NW, red);
ship();
