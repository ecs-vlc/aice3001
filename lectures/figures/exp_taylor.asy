import myutil;
import graph;
size(400,0);

real x0 = 0.75;
real xmax = 3;
real xmin = -0.5;

real f(real x) {
  return 0.7*exp(-x);
}

real fi(real x, int i) {
  if (i==0)
    return f(x0);
  else
    return -(x-x0)*fi(x,i-1)/i;
}

real approx(real x, int i) {
  real result = 0;
  for(int j=0; j<=i; ++j) {
    result += fi(x, j);
  }
  return result;
}


draw((xmin,0)--(xmax+0.2,0), Arrow);
draw((0,-0.8)--(0,1.0), Arrow);
label("$x$", (xmax+0.2,0), E);
label("$f(x)$", (0,1.0), N);

draw(graph(f, xmin, xmax));
draw((x0,0)--(x0,-0.05));
label("$x^*$", (x0,-0.05), S);
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

for(int i=0; i<5; ++i) {
  erase();
  add(bg);
  draw(graph(poly(i), xmin, xmax), red);
  draw(graph(apoly(i), xmin, xmax), blue);
  draw(bg, graph(poly(i), xmin, xmax), green+dashed);
  align dir = (i%2==0)? SW: NW;
  if (i==0) {
    label("$f(x^*)$", (0, fi(xmax,i)), E, red, UnFill);
    label(bg, "$f(x^*)$", (0, fi(xmax,i)), E, green, UnFill);
  } else if (i==1) {
    label("$(x-x^*)\,f'(x^*)$", (xmax, fi(xmax,i)), dir, red, UnFill);
    label(bg, "$(x-x^*)\,f'(x^*)$", (xmax, fi(xmax,i)), dir, green, UnFill);
  } else {
    label("$\tfrac{1}{n!}(x-x^*)^"+string(i)+"\,f^{("+string(i)+")}(x^*)$", (xmax, fi(xmax,i)), dir, red, UnFill);
    label(bg, "$\tfrac{1}{n!}(x-x^*)^"+string(i)+"\,f^{("+string(i)+")}(x^*)$", (xmax, fi(xmax,i)), dir, green, UnFill);
  }
  ship();
}
