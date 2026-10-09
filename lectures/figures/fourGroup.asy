import myutil;
size(200,0);

picture rect = new picture;

draw(rect, box((0,0), (2,1)));
label(rect, "A", (-0.1,1.1));
label(rect, "B", (2.1,1.1));
label(rect, "C", (2.1,-0.1));
label(rect, "D", (-0.1,-0.1));

draw(box((-0.5,-0.5), (2.5,1.5)), white);
add(rect);

ship();

erase();
draw(box((-0.5,-0.5), (2.5,1.5)), white);
draw((1,-0.5)--(1,1.5), dashed);
add(reflect((1,-0.5), (1,1.5))*rect);
label("$v$", (1, 1.25), E);
ship();


erase();
draw(box((-0.5,-0.5), (2.5,1.5)), white);
draw((-0.5,0.5)--(2.5,0.5), dashed);
add(reflect((-0.5,0.5), (2.5,0.5))*rect);
label("$h$", (2.25, 0.5), N);
ship();


erase();
draw(box((-0.5,-0.5), (2.5,1.5)), white);
add(rotate(180, (1, 0.5))*rect);
draw(arc((1,0.5), 0.3, 90, 270), Arrow);
label("$r$", (1, 1.25), E);
ship();
