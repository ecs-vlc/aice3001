import myutil;
import graph3;
size(200,0);

currentprojection=perspective(10,8,4);

real f(pair z) {return 0.25+0.5*abs(z)^2;}

draw((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle);
surface s=surface(f,(-1,-1),(1,1),nx=5,Spline);
xaxis3(Label("$u_1$"),red,Arrow3);
yaxis3(Label("$u_2$"),red,Arrow3);
zaxis3(XYZero(extend=true),red,Arrow3);
draw(s,lightgray,meshpen=black+thick(),nolight,render(merge=true));
label("$\bm{x}^*$",O,-Z+Y,red);

picture minimum = new picture;
size(minimum, 200,0);
minimum.add(currentpicture);

erase();

real f(pair z) {return -0.25-0.5*abs(z)^2;}

draw((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle);
surface s=surface(f,(-1,-1),(1,1),nx=5,Spline);
xaxis3(Label("$u_1$"),red,Arrow3);
yaxis3(Label("$u_2$"),red,Arrow3);
zaxis3(XYZero(extend=true),red,Arrow3);
draw(s,lightgray,meshpen=black+thick(),nolight,render(merge=true));
label("$\bm{x}^*$",O,-Z+Y,red);

picture maximum = new picture;
size(maximum, 200,0);
maximum.add(currentpicture);

erase();

real f(pair z) {return 0.15+0.5*(z.x**2-z.y**2+z.x*z.y);}

draw((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle);
surface s=surface(f,(-1,-1),(1,1),nx=5,Spline);
xaxis3(Label("$u_1$"),red,Arrow3);
yaxis3(Label("$u_2$"),red,Arrow3);
zaxis3(XYZero(extend=true),red,Arrow3);
draw(s,lightgray,meshpen=black+thick(),nolight,render(merge=true));
label("$\bm{x}^*$",O,-Z+Y,red);

picture saddlePoint = new picture;
size(saddlePoint, 200,0);
saddlePoint.add(currentpicture);

erase();
size(600,0);
add(minimum.fit(150.0,0.0), (-90,0));
add(maximum.fit(150.0,0.0), (0,0));
add(saddlePoint.fit(150.0,0.0), (90,0));
