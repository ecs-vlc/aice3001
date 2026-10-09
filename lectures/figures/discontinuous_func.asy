import myutil;
import graph;
size(400,0);

real func1(real x) {
  return (exp(x) - 0.5)/(exp(2.0) - 0.5);
}

real func2(real x) {
  if (x<1.0)
    return (exp(x) - 0.5)/(exp(2.0) - 0.5);
  else
    return sqrt(x)/sqrt(2);
}

void test_Lipschitz(real f(real)) {
  erase();
  draw(box((-0.2,-0.12), (2.2, 1.12)), white);
  draw((0,1)--(0,0)--(2,0), linewidth(1), Arrows);
  label("$x$", (2,0), E);
  label("$f(x)$", (0,1), N);
  draw(graph(f, 0, 0.99999), blue+linewidth(1));
  draw(graph(f, 1, 2), blue+linewidth(1));
  picture bg = new picture;
  bg.add(currentpicture);
  ship();

  for(real eps = 0.2; eps>0.01; eps*=0.5) {
    erase();
    add(bg);
    real x = 1.0-eps;
    draw((x, f(x))--(x, 0), dashed);
    draw((x, -0.03)--(x, 0));
    label("$x$", (x, -0.03), S);
    real y = 1.0+eps;
    draw((y, f(y))--(y, 0), dashed);
    draw((y, -0.03)--(y, 0));
    label("$y$", (y, -0.03), S);
    draw((x,0.2)--(y, 0.2), Arrows);
    if (eps>0.09)
      label("$d(x,y)$", (1,0.2), S);
    ship();
    draw((x, f(x))--(0, f(x)), dashed);
    draw((0, f(x))--(-0.03, f(x)));
    label("$f(x)$", (-0.03, f(x)), W);
    draw((y, f(y))--(0, f(y)), dashed);
    draw((0, f(y))--(-0.03, f(y)));
    label("$f(y)$", (-0.03, f(y)), W);
    draw((0.1,f(x))--(0.1, f(y)), Arrows);
    if (f(y)-f(x)>0.09)
      label("$d(f(x),f(y))$", (0.1, 0.5*(f(x)+f(y))), E);

    label("$\frac{\displaystyle d(f(x),f(y))}{\displaystyle d(x,y)} = " +string((f(y)-f(x))/(y-x), 2) + "$", (1.25, 0.3), E);
    ship();
  }
}

test_Lipschitz(func1);
test_Lipschitz(func2);
