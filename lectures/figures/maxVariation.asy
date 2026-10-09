import myutil;
size(200,0);

dot((0,0), linewidth(5));
label("$\mu$", (0,0), W);
draw((0,0)--(4,1), Arrow);
label("$\bm{v}$", 1.03*(4,1));
draw((0,0)--(3,-1), dashed);
dot((3,-1), red+linewidth(5));
label("$\bm{x}$", 1.05*(3,-1), red);
pair p = 11/17*(4,1);
draw(p--(3,-1), dotted);
label(rotate(180*atan(1/4)/pi)*Label("$\overbrace{\rule{4cm}{0pt}}{}$",(0.0)), (1.26,0.54));
label(rotate(180*atan(1/4)/pi)*Label("$\bm{v}^\tr(\bm{x}-\bm{\mu})$"), (1.25,0.9));
label("$\|\bm{v}\| = 1$", (3.7,0.4));
