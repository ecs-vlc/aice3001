import myutil;
import graph;
size(500,0);

void axis(real x, string s) {
  draw((x,1)--(x,0)--(x+3.1,0));
  label("$\frac{\|\bm{x} - \bm{y}\|}{\ell}$", (x+3.1,0), E);
  label("$K_{" + s + "}(\bm{x},\bm{y})$", (x,1), N);
  for(int i=0; i<=3; ++i) {
    draw((x+i,0)--(x+i,-0.05));
    label(string(i), (x+i,-0.05), S);
  }
  for(int i=0; i<=1; ++i) {
    draw((x,i)--(x-0.05, i));
    label(string(i), (x-0.05, i), W);
  }
}

axis(0,"SE");

real se(real d) {
  return exp(-0.5*d*d);
}

draw(graph(se, 0, 3), red);

axis(5,"OU");

real ou(real d) {
  return exp(-d);
}

draw(shift(5,0)*graph(ou, 0, 3), red);
