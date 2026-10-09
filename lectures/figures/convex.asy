settings.outformat="pdf";
import graph;
import myutil;
size(300,0);

real f(real x) {
  return 0.1*x*x;
}

draw(box((-0.7, -0.45), (5.5, 2.5)), white); 
draw(graph(f,0,5,operator..));
draw((0,0)--(5,0), Arrow);
draw((0,0)--(0,2.5), Arrow);
yaxis();

ship();

real x = 2;
real y = 4.5;

draw((x,0)--(x,-0.1));
label("$x$", (x,-0.1), S);
draw((0,f(x))--(-0.1,f(x)));
label("$f(x)$", (-0.1,f(x)), W);
draw((x,f(x)), linewidth(4));
ship();


draw((y,0)--(y,-0.1));
label("$y$", (y,-0.1), S);
draw((0,f(y))--(-0.1,f(y)));
label("$f(y)$", (-0.1,f(y)), W);
draw((y,f(y)), linewidth(4));
ship();



real a= 0.4;
real z = a*x+(1-a)*y;
draw((z,f(z)), linewidth(4));
draw((z,0)--(z,-0.1));
label("$a\,x+(1-a)\,y$", (z,-0.1), S);
label("$f(a\,x+(1-a)\,y)$", (z,f(z)), SE);
ship();

draw((z,a*f(x)+(1-a)*f(y)), linewidth(4)+red);
label("$a\,f(x)+(1-a)\,f(y)$", (z,a*f(x)+(1-a)*f(y)), NW, red);

draw((x,f(x))--(y,f(y)), red+dashed);
ship();
