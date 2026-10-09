import myutil;
import graph;
import stats;
size(400,0);
srand(8);

real gauss(real x) {
  return exp(-0.5*x*x);
}

draw(box((-3.3,-0.4),(3.3,1.4)), white);
draw(graph(gauss, -3,3), blue);

draw((-3,1)--(-3,0)--(3,0), Arrows);

draw("$f_X(x)$", (-3,1), N);

draw("$x$", (3,0), E);

ship();

draw((0,0)--(0,-0.05));
draw("$\mu$", (0,-0.05), S);
label("$\mu = \mathbb{E}[X]$", (1.6,1), E);
ship();

real u = 0.6;
draw((-0.5,u)--(0.5,u), Arrows);
draw((-0.5,0)--(-0.5, gauss(-0.5)), dotted);
draw((0.5,0)--(0.5, gauss(0.5)), dotted);

label("$\sigma$", (0, u), UnFill);

label("$\sigma^2 = \mathbb{E}[(X-\mu)^2]$", (1.6,0.6), E);
ship();

picture bg = new picture;

add(bg,currentpicture);
erase();
for (int iter=0; iter<2; ++iter) {
  add(bg);
  real mean = 0;
  for(int i=0; i<5; ++i) {
    real X = Gaussrand();
    mean += X;
    draw("$\bm{\times}$", (X,0), red);
    label("$X_{" + string(i+1) + "}$", (X,0), N, red);
    ship();
  }
  mean /= 5;
  
  draw((mean,-0.1)--(mean, gauss(mean)), dotted+red);
  label("$\hat{\mu}$", (mean,-0.1), S, red);
  ship();
  erase();
}
