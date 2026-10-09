import settings;
render=0;

import three;
import graph3;
import myutil;
currentprojection=perspective(5,1,2);

size(300,0);

xaxis3(Label("$x_1$",EndPoint),0,2, red, Arrow3);
yaxis3(Label("$x_2$",EndPoint),0,2, red, Arrow3);
zaxis3(Label("$x_3$",EndPoint),0,2, red, Arrow3);
label("$\mathbb{R}^3$", (0,1,2));
triple s = (0,4,0);
dot(s+(0,2.5,2.5), white);
dot(s+(0,-1,2.5), white);
dot(s+(0,2.5,-1), white);
ship();

triple o = (0,0,0);

real[][] M = {{0,0,0},{1.1,0.7,0.3},{0.1,0.9,0.7}};

draw(surface(shift(s)*((0,-1,-1)--(0,2.5,-1)--(0,2.5,2.5)--(0,-1,2.5)--cycle)), yellow, nolight);
label("$\mathbb{R}^2$", s+(0,1,2));
real drand() {return 3*rand()/randMax-1;}
triple toTriple(real[] x) {return (x[0],x[1],x[2]);}
draw(s--s+(0,2,0), red, Arrow3);
draw(s--s+(0,0,2), red, Arrow3);
label("$y_1$",s+(0,2.2,0), red);
label("$y_2$",s+(0,0,2.2), red);

ship();
for(int i=0; i<4; ++i) {
  real[] x = {drand(), abs(drand()), drand()};
  draw(o--toTriple(x), Arrow3);
  ship();
  real[] y = M*x;
  draw(s--s+toTriple(y), Arrow3);
  draw(toTriple(x)..0.6(toTriple(x)+s+toTriple(y))..s+toTriple(y), dashed+green, Arrow3);
  ship();
}
