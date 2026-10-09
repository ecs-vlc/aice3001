size(300,0);
import myutil;

pair A1 = (3, 5);
pair A2 = (5, 2);

dot((-0.65,-0.65), white);
draw((0,5.5)--(0,0)--(5.5,0), Arrows);
for(int i=0; i<=5; ++i) {
  draw((i,0)--(i,-0.2));
  label(string(i), (i,-0.2), S);
  draw((0,i)--(-0.2,i));
  label(string(i), (-0.2,i), W);
}

label("$P$", (5.5,0), E);
label("$R$", (0,5.5), N);
ship();
filldraw((0,-0.6)--(0,5)--(-0.6,5)--(-0.6,-0.6)--cycle, gray, gray);
label(rotate(90)*Label("$P\geq0$"), (0, 2.5), E);
draw((0,5.5)--(0,0)--(5.5,0), Arrows);
for(int i=0; i<=5; ++i) {
  draw((i,0)--(i,-0.2));
  label(string(i), (i,-0.2), S);
  draw((0,i)--(-0.2,i));
  label(string(i), (-0.2,i), W);
}
ship();
filldraw((-0.6,0)--(5,0)--(5,-0.6)--(-0.6,-0.6)--cycle, gray, gray);
label("$R\geq0$", (2.5,0), N);
draw((0,5.5)--(0,0)--(5.5,0), Arrows);
for(int i=0; i<=5; ++i) {
  draw((i,0)--(i,-0.2));
  label(string(i), (i,-0.2), S);
  draw((0,i)--(-0.2,i));
  label(string(i), (-0.2,i), W);
}
ship();

filldraw((5,0)--(5,1)--(0,4)--(0,0)--cycle, gray, white);
label(rotate(90)*Label("$P\geq0$"), (0, 2.5), E);
label("$R\geq0$", (2.5,0), N);
draw((0,5.5)--(0,0)--(5.5,0), Arrows);
draw((5,1)--(0,4));
label(rotate(-180*atan(3/5)/(pi))*Label("$3P + 5R \geq 20$"), (3,2.5));
ship();



filldraw((0,0)--(24/5,0)--(14/5,5)--(0,5)--cycle, gray, white);
label(rotate(90)*Label("$P\geq0$"), (0, 2.5), E);
label("$R\geq0$", (2.5,0), N);
draw((0,5.5)--(0,0)--(5.5,0), Arrows);
draw((24/5,0)--(14/5,5));
draw((5,1)--(0,4));
label(rotate(-180*atan(3/5)/(pi))*Label("$3P + 5R \geq 20$"), (3,2.5));
label(rotate(-180*atan(5/2)/(pi))*Label("$5P + 2R \geq 24$"), (3.5,3.7));
ship();

draw((0,0)--(5,4), red, MidArrow);
label(rotate(180*atan(4/5)/(pi))*Label("cost, $5\,P + 4\,R$"), (1,1), red);
ship();

real R = 28/19;
real P = (24-2*R)/5;
dot((P, R), blue+linewidth(10));
label("Cost = " + string(5*P+4*R,3), (P,R), 2*NE, blue);
ship();
