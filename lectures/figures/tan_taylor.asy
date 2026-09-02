import myutil;
import graph;
size(400,0);

real x0 = 0;
real xmax = 7;
real xmin = -7;
path bb = box((xmin,-4), (xmax+0.6,4));

real f(real x) {
  real ans = tan(x);
  if (ans>5.0)
    return 5.1;
  if (ans<-5.0)
    return -5.1;
  return ans;
}

real coeff[] = {0.0, 1.0, 0.0, 1.0/3.0, 0.0, 2.0/15.0, 0.0, 17.0/315.0, 0.0, 62.0/720.0};

real fi(real x, int i) {
  if (i%2==0)
    return 0.0;
  real ans = coeff[i]*(x**i);
  if (ans>5.0)
    return 5.1;
  if (ans<-5.0)
    return -5.1;
  return ans;
}

real approx(real x, int i) {
  real result = 0;
  for(int j=0; j<=i; ++j) {
    result += fi(x, j);
  }
  return result;
}


draw((xmin,0)--(xmax+0.2,0), Arrow);
draw((0,-4)--(0,4.0), Arrow);
label("$x$", (xmax+0.2,0), E);
label("$\tan(x)$", (0,4.0), N);

draw(graph(f, xmin, -3pi+0.0001));
draw(graph(f, -3pi+0.0001, -pi-0.0001));
draw(graph(f, -pi+0.0001, pi-0.0001));
draw(graph(f, pi+0.0001, 3pi-0.0001));
draw(graph(f, 3pi+0.0001, xmax));
draw((x0,0)--(x0,-0.05));
label("$x_0$", (x0,-0.05), S);
clip(bb);
ship();

using frr = real(real);

frr poly(int i){
  return new real(real x) {return fi(x, i);};
}

frr apoly(int i){
  return new real(real x) {return approx(x, i);};
}

picture bg = new picture;
bg.add(currentpicture);

for(int i=1; i<=9; i+=2) {
  erase();
  add(bg);
  if (i>0) {
    xmin = -5;
    xmax = 5;
  }
  draw(graph(poly(i), xmin, xmax), red);
  draw(graph(apoly(i), xmin, xmax), blue);
  clip(bb);
  draw(bg, graph(poly(i), xmin, xmax), green+dashed);
  clip(bg,bb);
  ship();
}
