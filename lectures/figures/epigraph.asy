settings.outformat="pdf";
size(400,0);
import myutil;
import graph;

draw((-2,0)--(2,0), Arrow);
draw((0,0)--(0,4), Arrow);
label("$f(x) = x^2$", (0,4), N);
label("$x$", (2,0), E);

real sqr(real x) {return x*x;}

draw(graph(sqr,-2,2), blue);

pair offset = (3.5,1);

draw(offset+(0,0)--offset+(4,0), Arrow);
draw(offset+(0,-1)--offset+(0,3), Arrow);
label("$f(x) = -\log(x)$", offset+(0,3), N);
label("$x$", offset+(4,0), E);

real neglog(real x) {return -log(x);}

draw(shift(offset)*graph(neglog,exp(-3),4), blue);

ship();

filldraw(graph(sqr,-2,2)--cycle, pink, pink);
draw(graph(sqr,-2,2), blue);
draw((0,0)--(0,4), Arrow);
label("epigraph", (0,2), red);

filldraw(shift(offset)*(graph(neglog,exp(-3),4)--(4,3)--cycle), pink, pink);
draw(shift(offset)*graph(neglog,exp(-3),4), blue);
draw(offset+(0,0)--offset+(4,0), Arrow);
label("epigraph", offset+(2,1), red);




ship();
