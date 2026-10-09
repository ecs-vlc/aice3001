size(300,0);
import myutil;

pair A1 = (3, 5);
pair A2 = (5, 2);


void axis() {
  dot((-0.325,-0.325), white);
  draw((0,2.25)--(0,0)--(2.25,0), Arrows);
  for(int i=0; i<=2; ++i) {
    draw((i,0)--(i,-0.1));
    label(string(i), (i,-0.1), S);
    draw((0,i)--(-0.1,i));
    label(string(i), (-0.1,i), W);
  }

  label("$A$", (2.25,0), E);
  label("$C$", (0,2.25), N);
}

axis();

ship();
filldraw((0,-0.3)--(0,2)--(-0.3,2)--(-0.3,-0.3)--cycle, gray, gray);
label(rotate(90)*Label("$A\geq0$"), (0, 1), E);
axis();

ship();
filldraw((-0.3,0)--(2,0)--(2,-0.3)--(-0.3,-0.3)--cycle, gray, gray);
label("$C\geq0$", (1,0), N);
axis();
ship();

filldraw((2,0)--(5/3,0)--(0,1)--(0,2)--(2,2)--cycle, gray, gray);
label(rotate(90)*Label("$A\geq0$"), (0, 1), E);
label("$C\geq0$", (1,0), N);
draw((0,2.25)--(0,0)--(2.25,0), Arrows);
draw((5/3,0)--(0,1));
label(rotate(-180*atan(3/5)/(pi))*Label("$3A + 5C \leq 5$"), (0.6,0.5));
ship();



filldraw((4/5,0)--(0,2)--(2,2)--(2,0)--cycle, gray, gray);
label(rotate(90)*Label("$A\geq0$"), (0, 1), E);
label("$C\geq0$", (1,0), N);
draw((0,2.25)--(0,0)--(2.25,0), Arrows);
draw((5/3,0)--(0,1));
draw((4/5,0)--(0,2));
label(rotate(-180*atan(3/5)/(pi))*Label("$3A + 5C \leq 5$"), (0.6,0.5));
label(rotate(-180*atan(5/2)/(pi))*Label("$5A + 2C \leq 4$"), (0.2,1.2));
ship();

draw((0,0)--(2,40/24), red, MidArrow);
label(rotate(180*atan(20/24)/(pi))*Label("price, $20\,A + 24\,C$"), (1.3,1.2), red);
ship();

real C= 13/19;
real A = (5-5*C)/3;
dot((A, C), blue+linewidth(10));
label("Price = " + string(20*A+24*C,3), (A,C), 2*E, blue);
ship();
