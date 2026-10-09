import myutil;
import graph3;
import solids;
size(200,0);

settings.render = 8;
import three;

currentprojection=perspective(10,8,4);
real f(pair z) {return 0.5+exp(-abs(z)^2);}
draw((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle);
revolution r=cylinder(O,0.6,f((0.6,0)),Z);
path3 mycircle =circle(c=O, r=0.6,normal=Z);
surface A=surface(mycircle);
draw(A, green);
surface s=surface(f,(-1,-1),(1,1),nx=5,Spline);
xaxis3(Label("$x$"),red,Arrow3);
yaxis3(Label("$y$"),red,Arrow3);
zaxis3(Label("$f(x,y)$"), XYZero(extend=true),red,Arrow3);
draw(s,lightgray,meshpen=black+thick(),nolight,render(merge=true));
draw(r,heavygreen+linewidth(1));
surface cyl = surface(r);
draw(cyl, yellow+opacity(0.2));
label("\huge $A$", 0.2*Z+0.4*X+0.4*Y);
