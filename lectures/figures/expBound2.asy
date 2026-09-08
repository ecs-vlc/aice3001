size(100,0);
import graph;
usepackage("amsmath");
real a = -1.3;
real b = 1.1;
pen lw = linewidth(1.5);
draw(graph(exp,a,b,operator..), blue+lw);

real f(real x) {return 1 + x + 0.5x*x;}
draw(graph(f,a,b,operator..), red+lw+linetype(new real[] {3,3}));

draw((a,1+a)--(b,1+b), deepgreen+lw+linetype(new real[] {6,3}));
draw((0,0)--(0,exp(b)), Arrow);
draw((a,0)--(b+0.1,0), Arrow);
label("$x$", (b+0.1,0), S);
draw((0,0)--(0,-0.1));
label("$0$", (0,-0.1), S);

label("$\mathrm{e}^{x}$", (-1,0),N, blue);
label(rotate(45)*Label("\small $1+x+\tfrac{x^2}{2}$"), (a,f(a)), NE, red);
label(rotate(45)*Label("$1+x$"), (0.8,1.8), S, deepgreen);
