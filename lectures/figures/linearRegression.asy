import myutil;

import three;
import graph3;
import myutil;
currentprojection=perspective(5,4,2);

size(200,0);

xaxis3(Label("$x_1$",EndPoint),0,1.5, Arrow3);
yaxis3(Label("$x_2$",EndPoint),0,1.5, Arrow3);
zaxis3(Label("$x_3$",EndPoint),0,1.3, Arrow3);

transform3 rot = rotate(60, (0.3,.8,.7));
triple w = rot*(0,0,1);
triple o = (0,0,0);

path3 plane = rot*((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle);

draw(o--w, Arrow3);
label("$\bm{w}$", 1.1*w);
draw(plane, white+opacity(0));

ship();
draw(plane);
draw(surface(plane), paleblue+opacity(0.3));
//draw(surface(plane, yellow+opacity(0.3));

ship();


void drawPoint(triple x) {
  triple y = x-dot(x,w)*w;
  draw(O--x, Arrow3);
  dot(x, red+linewidth(5));
  ship();
  draw(x--y, dashed);
  dot(x, red+linewidth(5));
  dot(y, linewidth(2));
  label(string(dot(x,w),2), 1.15*x, blue);
  ship();
}

drawPoint(0.5*(1,1,1.3));
drawPoint(0.5*(1,-1.1,0.5));
drawPoint(0.5*(0.2,0.6,-1.2));
