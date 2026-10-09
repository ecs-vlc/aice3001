import myutil;

size(200,0);

draw(box((-0.1,-0.1),(10.5,4.1)),white);

pair o = (0,0);
pair a = (5,2);

draw(o--a, Arrow);
label("$\bm{a}$", 0.8*a, S);
ship();

draw(o--2a, blue, Arrow);
label("$2\bm{a}$", 1.8a, N, blue);
ship();


