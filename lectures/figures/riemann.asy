import myutil;
import graph;
size(300,0);

real func(real x) {
  return 0.8 + 0.2*x*(x-1)*(x-2.8);
}

real intFunc(real x) {
  return 0.8*x+0.2*x*x*x*x/4 - 0.2*3.8*x*x*x/3+0.2*2.8*x*x/2;
}

filldraw((0.5,0)--(0.5, func(0.5))--graph(func,0.5, 2)--(2,0)--cycle, paleblue, blue);

draw(graph(func, 0, 2.5), blue);
label("$f(x)$", (2.5, func(2.5)), E, blue);

draw((0,1.2)--(0,0)--(2.5,0), Arrows);
label("$x$", (2.5,0), E);
draw((0.5,0)--(0.5,-0.05));
draw((2,0)--(2,-0.05));
label("$a$", (0.5,-0.05), S);
label("$b$", (2,-0.05), S);
picture bg = new picture;
add(bg, currentpicture);

label("$\displaystyle \int_a^b f(x)\, \mathrm{d}x$", (0.8, 1), E);

ship();
erase();
label(bg, "$\displaystyle \int_a^b f(x)\, \mathrm{d}x = \lim\limits_{\delta x_i\rightarrow 0} \sum_{i=0}^{n-1} (x_{i+1} - x_i) \, f(x_i)$", (0.8, 1), E);
add(bg);


for(int j=0; j<5; ++j) {
  erase();
  add(bg);
  int n = 2**(j+2);
  real delta = 1.5/(n);
  real sum = 0.0;
  for(int i=0; i<n; ++i) {
    real x = 0.5 + delta*i;
    sum += delta*func(x);
    draw((x,0)--(x,func(x))--(x+delta, func(x))--(x+delta,0), red);
    if (i>0 && j<2) {
      draw((x,0)--(x,0.02), red);
      label("$x_{" + string(i) + "}$", (x,-0.02), S, red);
    }
  }
  if (j==0) {
    label("$=x_0$", (0.5,-0.05), 1.3SE, red);
    label("$=x_n$", (2,-0.05), 1.7SE, red);
  }
  label("$\approx" +string(sum,4)+ "$", (1.8, 0.73), red);
  ship();
}
real ans = intFunc(2)-intFunc(0.5);
write(ans);
erase();
