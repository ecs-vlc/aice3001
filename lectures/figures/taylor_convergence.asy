import myutil;
size(200,0);


pair z = (0.3, -0.2);
real r = 0.7;

pair sing = z + r*unit((1,3));
filldraw(circle(z, r), paleblue, blue);
dot(z);
label("$z = x+\mathrm{i}\,y$", z, S);

dot(sing, red);
label("Singularity", sing, N, red);

draw((-1,0)--(1,0));
draw((0,-1)--(0,1));
label("$x$", (1,0), E);
label("$\mathrm{i}\,y$", (0,1), N);
label("Guaranteed", (0.4, 0.25), yellow);
label("convergence", (0.4, 0.1), yellow);
