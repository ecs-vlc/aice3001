size(120,0);

import graph;

real f(real x) {
  return log(x);
}


draw(graph(f,0.05,4,operator..), red);
xaxis(Label("$x$",0.5), 0, 4, RightTicks(beginlabel=false));
yaxis("", -3, 2, RightTicks);
label("$\log(x)$", (2,f(2)), SE, red);
draw((0,-1)--(3,2), blue);
label("$x-1$", (2,1), NW, blue);
