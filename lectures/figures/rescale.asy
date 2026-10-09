size(0,100);
import myutil;

pair[] p = {(1.2,1), (3,1.5), (2,2)};

label("$\bm{\times}$", p[0], blue);
dot(p[1], red+linewidth(5));
dot(p[2], red+linewidth(5));
for(int i=0; i<3; ++i) {
  draw((0,0)--p[i], dotted);
}
draw((0,2.3)--(0,0)--(3.1,0), Arrows);
draw((0,2)--(-0.05,2));
label("1", (-0.05,2), W);
draw((2,0)--(2,-0.05));
label("1", (2,-0.05), S);

ship();

draw(p[0]--p[2],Arrows);
ship();

erase();
for(int i=0; i<3; ++i) {
  p[i]=xscale(0.5)*p[i];;
}

label("$\bm{\times}$", p[0], blue);
dot(p[1], red+linewidth(5));
dot(p[2], red+linewidth(5));
for(int i=0; i<3; ++i) {
  draw((0,0)--p[i], dotted);
}
draw((0,2.3)--(0,0)--(3.1,0), Arrows);
draw((0,2)--(-0.05,2));
label("1", (-0.05,2), W);
draw((1,0)--(1,-0.05));
label("1", (1,-0.05), S);

ship();

draw(p[0]--p[1],Arrows);
ship();
