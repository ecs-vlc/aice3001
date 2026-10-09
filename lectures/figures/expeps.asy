import myutil;
import graph;
size(100,0);

draw(graph(exp, -1, 0.5), blue);
draw((-1,0)--(0.7,0), Arrow);
label("$x$", (0.7,0), E);
draw((0,-0.04)--(0,exp(0.5)), Arrow);
draw((-0.5,0.5)--(0.5, 1.5), red);
label("$0$", (0,-0.04), S);
draw((0,1)--(-0.04, 1));
label("$1$", (-0.04, 1), W);
label("$\mathrm{e}^{x}$", (-0.3, exp(-0.3)), NW, blue);
