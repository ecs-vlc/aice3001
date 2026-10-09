import myutil;
import graph;
size(600,0);

void axis(pair x) {
  draw(x+(0,1)--x+(0,0)--x+(2,0), Arrows);
  label("$\epsilon$", x+(2,0), E);
  label("$\alpha(\bm{x}_0 + \epsilon\,\bm{u})$", x+(0,1), N);
}

real lip(real x) {
  if (x<1.2)
    return sin(x);
  else if (x<1.7)
    return sin(1.2)-x+1.2;
  else
    return sin(1.2)-1.7+1.2+0.5*(x-1.7);
}

void grad(pair p, real g, string s) {
  dot(p, blue+linewidth(2));
  draw(p-0.1*(1,g)--p+0.1*(1,g), blue);
  label("$\bm{u}^{\mathsf{T}}\bm{\nabla} \alpha(\bm{x})"+s+"$", p, NW, blue);
}


axis((0,0));
draw(graph(lip,0,2), red);
grad((0.8,lip(0.8)), cos(0.8), "\leq1");
label("Lipschitz-1", (1, 0.2), blue);

real nlip(real z) {
  real x = z-3;
  if (x<1)
    return 0.6*exp(x)-0.6;
  else if (x<1.4)
    return 0.6*exp(1)-0.6-sin(2x-2);
  else
    return 0.5-0.2*x;
}

axis((3,0));
draw(graph(nlip,3,4.3)--(4.3999,nlip(4.3999))--graph(nlip,4.4,5), red);
grad((3.8,nlip(3.8)), 0.6*exp(0.8), ">1");
label("Not Lipschitz-1", (4, 0.2), blue);
