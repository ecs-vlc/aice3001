size(100,0);
import graph;

real f(real x) {
  return x*x*(2-x)*(2-x) + 0.2x;
}

draw(graph(f,-0.5,2.5,operator..));

draw((0,0)--(2,f(2)), red);

dot((0,0), red);
dot((2,f(2)), red);
