import myutil;
import graph;
size(300,0);

real a = 1.5;
real func(real x) {
  return 0.5*x*x;
}

real afunc(real x) {
  return a*0.5*x*x;
}

draw((0,1.2*afunc(0.81))--(0,0)--(0.81,0), Arrows);
label("$x$", (0.81, 0), E);
real x0 = 0.5;
draw((x0,0)--(x0,-0.01));
label("$x_0$", (x0,-0.01), S);

draw(graph(func,0,0.8), blue);
label("$f(x)$", (0.8, func(0.8)), E, blue);
ship();
pair p = (x0, func(x0));
dot(p, red);
draw(p-(0.2,0.2*x0)--p+(0.2,0.2*x0), red+dashed);
label("$f'(x_0)$", p, SE, red);
ship();
draw(graph(afunc,0,0.8), heavygreen);
label("$g(x)=a\,f(x)$", (0.8, afunc(0.8)), W, heavygreen);
ship();
pair p = (x0, afunc(x0));
dot(p, red);
draw(p-(0.2,0.2*a*x0)--p+(0.2,0.2*a*x0), red+dashed);
label("$g'(x)=a\,f'(x_0)$", p, NW, red);
ship();

erase();


draw((0,1.2*afunc(0.81))--(0,0)--(0.81,0), Arrows);
label("$x$", (0.81, 0), E);
real x0 = 0.5;
draw((x0,0)--(x0,-0.01));
label("$x_0$", (x0,-0.01), S);

draw(graph(func,0,0.8), blue);
label("$f(x)$", (0.8, func(0.8)), E, blue);
pair p = (x0, func(x0));
dot(p, red);
draw(p-(0.2,0.2*x0)--p+(0.2,0.2*x0), red+dashed);
label("$f'(x_0)$", p, SE, red);
ship();

real g(real x) {
  return 0.25*sqrt(x);
}
draw(graph(g,0,0.8), heavygreen);
label("$g(x)$", (0.8, g(0.8)), E, heavygreen);
ship();
pair pg = (x0, g(x0));
dot(pg, red);
real gg = 0.125/sqrt(x0);
draw(pg-(0.2,0.2gg)--pg+(0.2,0.2gg), red+dashed);
label("$g'(x_0)$", pg, SE, red);
ship();

real h(real x) {
  return func(x) + g(x);
}

draw(graph(h,0,0.8), heavygreen);
label("$h(x)=f(x)+ g(x)$", (0.8, h(0.8)), W, heavygreen);
ship();
pair ph = (x0, h(x0));
dot(ph, red);
real gh = gg + x0;
draw(ph-(0.2,0.2gh)--ph+(0.2,0.2gh), red+dashed);
label("$h'(x_0)=f'(x_0)+ g'(x_0)$", ph, NW, red);
ship();
