settings.outformat="pdf";
size(600,0);
import myutil;
import graph;

void axis(real xmin, real xmax, real ymin, real ymax, pair offset, string f) {
  draw(offset+(xmin,0)--offset+(xmax,0), Arrow);
  draw(offset+(0,ymin)--offset+(0,ymax), Arrow);
  pair o = (ymax>ymin)? N:S;
  label("$" + f + "$", offset+(0,ymax), o);
  label("$x$", offset+(xmax,0), E);
}

draw(box((-2.1,-6.5), (17.4, 5.6)),white);

label("\Large Convex-Up Functions", (7.5,5), N);

/* sqr */

pair offset = (0,0);

axis(-2,2,0,4,offset, "x^2");

real sqr(real x) {return x*x;}

draw(shift(offset)*graph(sqr,-2,2), blue);

ship();

/* rsqr */

pair offset = (3,0);

axis(0,4,0,4,offset, "x^{-2}");

real rsqr(real x) {return 1.0/(x*x);}

draw(shift(offset)*graph(rsqr,0.5,4), blue);

ship();


/* quad */

pair offset = (10,0);

axis(-2,2,0,4,offset, "x^4");

real quad(real x) {return x*x*x*x;}

draw(shift(offset)*graph(quad,-sqrt(2),sqrt(2)), blue);

ship();


/* exp */

pair offset = (15,0);

axis(-2,2,0,4,offset, "\exp(x)");

draw(shift(offset)*graph(exp,-2, log(4)), blue);

ship();

label("\Large Convex-Down Functions", (7.5,-1), N);


/* nsqr */

pair offset = (0,-2);

axis(-2,2,0,-4,offset, "-x^2");

real nsqr(real x) {return -x*x;}

draw(shift(offset)*graph(nsqr,-2,2), blue);

ship();

/* sqrt */

pair offset = (3,-6);

axis(0,4,0,4,offset, "\sqrt{x}");

draw(shift(offset)*graph(sqrt,0,4), blue);

ship();



/* nquad */

pair offset = (10,-2);

axis(-2,2,0,-4,offset, "-x^4");

real nquad(real x) {return -x*x*x*x;}

draw(shift(offset)*graph(nquad,-sqrt(2),sqrt(2)), blue);

ship();


/* log */

pair offset = (13,-3);

axis(0,4,-3,1,offset, "\log(x)");

draw(shift(offset)*graph(log,exp(-3), 4), blue);

ship();
