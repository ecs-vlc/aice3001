import myutil;
import graph;
size(200,0);

real rbf(real d) {
  return exp(-d*d);
}

real xmax = 2.5;

draw((0,1.15)--(0,0)--(xmax+.15,0), Arrows);

draw(graph(rbf, 0.0, xmax), blue+linewidth(1));

draw((1,0)--(1,-0.05));
label("$\gamma$", (1,-0.05), S);

label("$\| \bm{x} - \bm{y} \|$", (xmax+.15,0), E);
