import myutil;
size(60,0);


filldraw(circle((0,0), 1), lightblue, dashed);
draw((-1,0)--(0,0), Arrows);
label("$\epsilon$", (-0.5,0), S);
dot((0,0));
label("$\bm{x}$", (0,0), E);
label("$\mathcal{B}(\bm{x}, \epsilon)$", (0,0), 2N);
