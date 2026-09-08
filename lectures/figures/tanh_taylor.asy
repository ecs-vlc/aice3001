import myutil;
import graph;
size(400,0);

real x0 = 0;
real xmax = 7;
real xmin = -7;
path bb = box((xmin,-4), (xmax+0.6,4));

string coeffient[] = {"", "", "", "-\frac{1}{3}", "", "\frac{2}{15}", "", "-\frac{17}{315}", "", "\frac{62}{720}"};

real coeff[] = {0.0, 1.0, 0.0, -1.0/3.0, 0.0, 2.0/15.0, 0.0, -17.0/315.0, 0.0, 62.0/720.0};

real fi(real x, int i) {
  if (i%2==0)
    return 0.0;
  return coeff[i]*(x**i);
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
label("$\tanh(x)$", (0,4.0), N);

draw(graph(tanh, xmin, xmax));
draw((x0,0)--(x0,-0.05));
label("$0$", (x0,-0.05), S);
draw((pi/2,0)--(pi/2,-0.05));
label("$\frac{\pi}{2}$", (pi/2,-0.05), S);
draw((-pi/2,0)--(-pi/2,-0.05));
label("$-\frac{\pi}{2}$", (-pi/2,-0.05), S);
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
  if (i>1) {
    xmin = -3.1+0.15*i;
    xmax = 3.1-0.15*i;
  }
  draw(graph(poly(i), xmin, xmax), red);
  real x = 1.85 - 0.05*i;
  align d = (coeff[i]>0)? E: W;
  if (i==1)
    label("$x$", (-pi, -pi), NW, red);
  else
    label("$"+coeffient[i]+"\,x^{"+string(i)+"}$", (x, fi(x,i)), d, red);
  draw(graph(apoly(i), xmin-0.3, xmax+0.3), blue);
  clip(bb);
  draw(bg, graph(poly(i), xmin, xmax), green+dashed);
  clip(bg,bb);
  ship();
}

erase();

filldraw(box((-pi/2,-4), (pi/2,4)), paleblue, white);
add(bg);
draw(graph(apoly(9), xmin-0.3, xmax+0.3), blue);
clip(bb);
ship();
