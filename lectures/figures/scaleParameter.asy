size(400,0);

import graph;
import myutil;

draw(box((-0.2,-0.7),(10.3, 3.1)), white);

draw((0,3)--(0,0)--(10,0), Arrows);

label("$\mu$", (10,0), E);

void drawInterval(real A, real B, string sA, string sB) {
  draw((A,-0.1)--(A,0)--(B,0)--(B,-0.1), blue);
  draw((A,0)--(B,0), blue+linewidth(2));
  label(sA, (A,-0.1), S);
  label(sB, (B,-0.1), S);    
}

real A = 7;
real B = 9;
real c = 4;

drawInterval(A, B,"$A$", "$B$");

ship();

drawInterval(A/c,B/c,"$\frac{A}{c}$", "$\frac{B}{c}$");

ship();

real f(real x) {return 1/x;}

draw(graph(f, 0.4, 10, operator..), red);
label("$p(\mu)$", (0.4,f(0.4)), E, red);
ship();
void drawArea(real A, real B) {
  filldraw((A,0)--(A,f(A))..graph(f, A, B, operator..)--(B,0)--cycle, paleblue, blue);
}

drawArea(A,B);
drawArea(A/c, B/c);

label("$\mathbb{P}\!\left(\frac{A}{c} \leq \mu \leq \frac{B}{C}\right)
= \mathbb{P}\!\left(A \leq \mu \leq B\right)$", (0.5*(A+B/c), 1));
ship();

