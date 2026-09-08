import myutil;
size(150,0);

draw((-1,0)--(1,0));
draw((0,-1)--(0,1));
label("$x$", (1,0), E);
label("$\mathrm{i}\,y$", (0,1), N);

draw((0.7, 0.4)--(0.65, 0.3), green);

dot((0.7, 0.4), blue);
label("$z = x+\mathrm{i}\,y$", (0.7, 0.4), N, blue);

dot((0.65, 0.3), red);
label("$z + \epsilon$", (0.65, 0.3), SW, red);

label("$\epsilon$", (0.695, 0.35), 0.5SE, green);
