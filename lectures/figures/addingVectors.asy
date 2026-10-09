import myutil;

size(200,0);

draw(box((-0.1,-0.1),(6.5,4.1)),white);

pair o = (0,0);
pair a = (5,1);
pair b = (1,3);

draw(o--a, Arrow);
label("$\bm{a}$", 0.5*a, S);
ship();

draw(o--b, Arrow);
label("$\bm{b}$", 0.5*b, W);
ship();

draw(a--a+b, dotted);
draw(b--a+b, dotted);
draw(o--a+b, Arrow);
label("$\bm{c}=\bm{a}+\bm{b}$", 0.5*(a+b), E);
ship();
