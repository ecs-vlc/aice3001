import settings;
//settings.outformat="pdf";
//settings.prc=true;
render=0;
import three;
import graph3;
import myutil;


size(200,0);

axes3("$x_1$", "$x_2$", "$x_3$", (0,0,0), (1,1,1));

triple a = 1.5*(0.1, 0.5, 0.5);

triple b = 1.5*(0.8, 0.2, 0.5);

draw((0,0,0)--a, blue, Arrow3);
draw((0,0,0)--b, blue, Arrow3);

label("$\bm{a}$", 1.1*a);
label("$\bm{b}$", 1.1*b);

triple au = 0.5*unit(a);
triple bu = 0.5*unit(b);

guide3 g = au;
for(real x=0.1; x<1.0001; x+=0.1) {
  triple p = x*bu + (1-x)*au;
  g = g--0.5*unit(p);
  if (abs(x-0.5)<0.001)
    label("$\theta$", 0.6*unit(p));
}
draw (g);

label("$\langle \bm{a}, \bm{b} \rangle = \|\bm{a}\| \, \| \bm{b}\| \, \cos(\theta)$", (0,0,-0.4));

