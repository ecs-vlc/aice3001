import myutil;
size(200,0);

draw((0,0)--(0,0.7), Arrow);
draw((0,0)--(1,0), Arrow);
real theta = 35;

pair pnt(real theta) {
  real theta = pi*theta/180.0;
  return (cos(theta), sin(theta));
}

pair p = pnt(theta);

picture bg = new picture;
dot(p, blue);
dot((0,-0.1), white);

add(bg, currentpicture);
draw((p.x,0)--(p.x,-0.02));
label("$x$", (p.x,-0.02), S);
draw((0,p.y)--(0.02, p.y));
label("$y$", (0.02, p.y), E);
label("$\bm{x} = (x, y)$", p, SW);
ship();

filldraw(box(p, p+(0.05, 0.05)), green, heavygreen);
label("$\mathrm{d} x$", p, SE);
label("$\mathrm{d} y$", p, NW);
label("$\mathrm{d} A = \mathrm{d}x \,\mathrm{d} y$", (p.x, 0.4), heavygreen);
ship();
erase();


real theta1 = theta + 3;

draw((0,0)--p, red);
dot(p, blue);
draw(arc((0,0), 0.4, 0.0, theta), red);
label("$\theta= \arctan\!\left(\frac{y}{x}\right)$", 0.42*pnt(0.5*theta), E, red);
label("$r= \sqrt{x^2+y^2}$", 0.5*p, E+0.1S, red);
draw((p.x,0)--(p.x,-0.02));
label("$x=r \cos(\theta)$", (p.x,-0.02), S);
draw((0,p.y)--(0.02, p.y));
label("$y=r\sin(\theta)$", (0.02, p.y), E);

add(bg);
ship();
real thetaMid = 0.5*(theta+theta1);

draw((0,0)--pnt(theta1), green+dashed);
draw(arc((0,0), 0.4, theta, theta1), green);
label(rotate(thetaMid)*Label("$\mathrm{d}\theta$"), 0.45*pnt(thetaMid), heavygreen);
filldraw(1.05p--arc((0,0), 1.05, theta, theta1)--pnt(theta1)--arc((0,0), 1, theta1, theta)--cycle, green, heavygreen);
label("$\mathrm{d} r$", p, SE);
label(rotate(thetaMid)*Label("$r\,\mathrm{d} \theta$"), 0.94*pnt(thetaMid));
label("$\mathrm{d} A = r\, \mathrm{d}r\,\mathrm{d} \theta$", (p.x, 0.4),  heavygreen);

ship();
