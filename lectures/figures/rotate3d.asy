import graph3;

size(450,0);
currentprojection=perspective(5,4,2);

real drand() {
  return rand()/randMax*2-1;
}

triple randtriple(real a) {
  real x = drand();
  real y = drand();
  return (x, y, a*x+(1-a)*y);
}

triple[] data;

for (int i=0; i<100; i+=1) {
  dot(randtriple(0.7), red);
}

xaxis3(Label("$x_1$",EndPoint));
yaxis3(Label("$x_2$",EndPoint));
zaxis3(Label("$x_3$",EndPoint));



