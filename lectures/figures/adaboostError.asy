size(200,0);
import myutil;
import graph;

real f(real x) {return exp(-x);}

draw((-1,0)--(2.2,0), Arrow);
draw((0,0)--(0,3), Arrow);
draw(graph(f,-1,0), red);
draw(graph(f,0,2), blue);

label("$y^\mu\,C_n(\bm{x}^\mu)$", (2.2,0), E);
label("$\mathrm{e}^{-y^\mu\,C_n(\bm{x}^\mu)}$", (0,3), E, red);
label(rotate(90)*Label("Misclassified"), (-0.2, 1.5), W, red);
label("Correct", (0, 1.5), E, blue);
