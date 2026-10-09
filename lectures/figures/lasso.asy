settings.outformat="pdf";
size(300,0);
import graph;
import myutil;

real xmax = 0.8;
real ymax = 0.7;
real offset = 0.2;
real factor = 0.5;

real error(real w) {return factor*(w-offset)^2 + 0.2;}
real nu = 0.2;
real regerror(real w) {return error(w) + nu*abs(w);}

real opt() {
  if (-offset*2*factor+nu>0)
    return 0;
  return offset - 0.5*nu/factor;
}


draw(graph(error, -0.3, xmax), red);
dot((0,-0.12), white);
draw((-0.3,0)--(xmax,0), Arrow);
draw((0,0)--(0,ymax), Arrow);
label("$w_s$", (xmax,0), E);
draw((0.2,0)--(0.2,-0.02));
label("$w_s^*$", (0.2,-0.02), S);
label("$\displaystyle \sum_{n=1}^N \left( \bm{w}^\tr \, \bm{x}_n - y_n \right)^2$", (xmax, error(xmax)), E, red);

ship();

draw((-0.3,0.3*nu)--(0,0)--(xmax,xmax*nu), blue);
label("$\nu\,|w_s|$", (xmax,xmax*nu), E, blue);
ship();

draw(graph(regerror, -0.3, xmax), heavygreen);
label("$E$", (xmax,regerror(xmax)), E, heavygreen);
ship();
draw((0,0)--(0,-0.02));
label("$w_s^{lasso}$", (0.0,-0.02), S);
label("\huge $*$", (0, regerror(0)), heavygreen);
ship();


/* Big gap */

erase();

offset = 0.4;

dot((0,-0.12), white);
draw(graph(error, -0.3, xmax), red);
draw((-0.3,0)--(xmax,0), Arrow);
draw((0,0)--(0,ymax), Arrow);
label("$w_s$", (xmax,0), E);
draw((offset,0)--(offset,-0.02));
label("$w_s^*$", (offset,-0.02), S);
label("$\displaystyle \sum_{n=1}^N \left( \bm{w}^\tr \, \bm{x}_n - y_n \right)^2$", (xmax, error(xmax)+0.05), E, red);

ship();

draw((-0.3,0.3*nu)--(0,0)--(xmax,xmax*nu), blue);
label("$\nu\,|w_s|$", (xmax,xmax*nu), E, blue);
ship();

real minw = opt();;

draw(graph(regerror, -0.28, xmax), heavygreen);
label("$E$", (xmax,regerror(xmax)), E, heavygreen);
ship();
draw((minw,0)--(minw,-0.02));
label("$w_s^{lasso}$", (minw,-0.02), S);
label("\huge $*$", (minw, regerror(minw)), heavygreen);
ship();

/* small gap high curvature */

erase();

offset = 0.2;
factor = 1.0;

dot((0,-0.12), white);
draw(graph(error, -0.3, xmax), red);
draw((-0.3,0)--(xmax,0), Arrow);
draw((0,0)--(0,ymax), Arrow);
label("$w_s$", (xmax,0), E);
draw((offset,0)--(offset,-0.02));
label("$w_s^*$", (offset,-0.02), S);
label("$\displaystyle \sum_{n=1}^N \left( \bm{w}^\tr \, \bm{x}_n - y_n \right)^2$", (xmax, error(xmax)+0.05), E, red);

ship();

draw((-0.3,0.3*nu)--(0,0)--(xmax,xmax*nu), blue);
label("$\nu\,|w_s|$", (xmax,xmax*nu), E, blue);
ship();

real minw = opt();

xmax = 0.7;
draw(graph(regerror, -0.28, xmax), heavygreen);
label("$E$", (xmax,regerror(xmax)), E, heavygreen);
ship();
draw((minw,0)--(minw,-0.02));
label("$w_s^{lasso}$", (minw,-0.02), S);
label("\huge $*$", (minw, regerror(minw)), heavygreen);
ship();
