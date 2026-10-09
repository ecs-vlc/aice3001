size(150,0);
import graph;

int n = 1;
real cosn(real theta) { return cos(n*theta); }
real sinn(real theta) { return sin(n*theta); }

real y = 0;
for(n=1; n<4; ++n) {
  draw((0,y)--(2pi,y));
  draw(shift(0,y)*graph(cosn, 0, 2pi, operator..));
  label("$b_{"+string(2n-1)+"}(x)$", (0,y), W);
  y -= 2.5;
  draw((0,y)--(2pi,y));
  draw(shift(0,y)*graph(sinn, 0, 2pi, operator..));
  label("$b_{"+string(2n)+"}(x)$", (0,y), W);
  y -= 2.5;
}
