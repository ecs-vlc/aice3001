import myutil;
size(300,0);

pair w = unit((2,1));

void example(pair x, real bs=-0.05) {
  draw(box((-0.5,-0.55), (1,0.65)), white);
  draw((0,0)--w, Arrow);
  label("$\bm{w}$", 1.05*w);
  draw((0,0)--x, Arrow);
  pair ux = unit(x);
  label("$\bm{x}$", x+0.05*ux);
  draw(0.2*w..0.11*(w+ux)..0.2*ux);
  label("$\theta$", 0.14*(w+ux));
  real dp = dot(x,w);
  draw(brace((0,0), dp*w, bs), red);
  draw((0,0)--dp*w, dotted+red+linewidth(1));
  Label l = Label("$\bm{w}^\tr\bm{x} = \|\bm{x}\| \, \cos(\theta)$");
  label(rotate(-60)*l, 0.5*dp*w+(0.03,-0.16), E, red);
  draw(x--dp*w, dotted+red+linewidth(1));
  ship();
  erase();
}

example((0.6, 0.6));
example((0.3, 0.3));
example((-0.4, 0.2), 0.03);

for(real d=-0.3; d<0.4; d+=0.15) {
  pair x = 0.7*w + d*(w.y,-w.x);
  example(x);
}
