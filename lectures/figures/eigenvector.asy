import settings;
render=0;
import three;
import graph3;
import myutil;
size(150,0);

currentprojection = perspective(0.5,2,0.5);
// axes alone (frame 2, where the label would sit on the longer red arrow)
// and axes plus the labelled v (every other frame)
picture ax = new picture;
axes3(ax, "$x_1$", "$x_2$", "$x_3$", (0,0,0), (1,1,1), Arrow3);
picture bg = new picture;
add(bg, ax);

triple v = (0.6, 0.4, 0.5);

draw(bg, (0,0,0)--v, blue+linewidth(1), Arrow3);
label(bg, "$\bm{v}$", 1.05*v, blue);

add(bg);
ship();

draw((0,0,0)--(0.5*v), red+linewidth(1), Arrow3);
draw(v..(0.75*v+(0,0.1,0.1))..0.5*v, green+dashed, Arrow3);

label("$\mat{M}_1\,\bm{v}=\lambda\,\bm{v}$", 0.5*v+(0,-0.05,0.1), E, red);

ship();
erase();
add(ax);

draw((0,0,0)--1.4*v, red+linewidth(1), Arrow3);
draw(v..(1.2*v+(0,-0.05,0.1))..1.4*v, green+dashed, Arrow3);

label("$\mat{M}_2\,\bm{v}=\lambda\,\bm{v}$", 1.4*v+(0,0,0.1), E, red);
draw((0,0,0)--v, blue+linewidth(1), Arrow3);
ship();

erase();

add(bg);
draw((0,0,0)--(-0.5*v), red+linewidth(1), Arrow3);
draw(v..(0.25*v+(0,0.1,0.1))..-0.5*v, green+dashed, Arrow3);

label("$\mat{M}_3\,\bm{v}=\lambda\,\bm{v}$", 0.5*v+(0,-0.05,0.1), E, red);

ship();
