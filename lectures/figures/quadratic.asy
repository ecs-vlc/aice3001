size(200,0);

import graph;

draw((0,0.5)--(0,0)--(1,0), Arrows);

real a = 0.1;
real b = 2.8;
real x0 = 0.5;
real f(real x) {
  return a + 0.5*b*(x-x0)^2;
}

draw(graph(f, 0, 1), blue);
draw((0,a)--(-0.02,a));
label("$a$", (-0.02,a),W);
draw((x0,0)--(x0,-0.02));
label("$x^*$", (x0,-0.02), S);
label("$x$", (1,0), E);
