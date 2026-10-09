settings.outformat="png";

import graph3;
import stats;
size(600,0);
currentprojection=perspective(1,2,1.1);

real r[] = new real[4];
pair c[] = new pair[4];
pair v[] = new pair[4];
for(int i=0; i<c.length; ++i) {
  r[i] = 0.2+0.3*rand()/randMax;
  c[i] = (2*Gaussrand(), Gaussrand());
  v[i] = (rand(), rand())/randMax;
  v[i] *= 2;
}

real f(pair z) {
  real loss= 1;
  for(int i=0; i<c.length; ++i) {
    pair d = z-c[i];
    loss -= r[i]*exp(-v[i].x*d.x*d.x-v[i].y*d.y*d.y);
  }
  return loss;
}


surface s=surface(f,(-4,-2),(4,2),nx=10,Spline);

draw(s,lightgray,meshpen=black+thick(),nolight,render(merge=true));

xaxis3(Label("$w_1$"),red,Arrow3);
yaxis3(Label("$w_2$"),red,Arrow3);
zaxis3(Label("$
L(\mathbf{w})$"),0,1,red,Arrow3);
