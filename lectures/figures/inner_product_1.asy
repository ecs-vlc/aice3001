import myutil;
size(300,0);

pair o = (0,0);
pair a = (4,1);
pair b = (2,2);
draw(o--a, Arrow);
draw(o--b, Arrow);
draw(arc(o, 0.8, aTan(a.y/a.x), aTan(b.y/b.x)));
real ang = 0.5*(atan(a.y/a.x)+atan(b.y/b.x));
label("$\theta$", 1*(cos(ang),sin(ang)));
label("$\bm{x}$", a+0.2*unit(a));
label("$\bm{y}$", b+0.2*unit(b));
label("$\langle \bm{x}, \bm{y} \rangle = \bm{x}^\textsf{T} \bm{y} =
 \|\bm{x}\| \, \|\bm{y}\|\, \cos(\theta)$", (5,1), E);
