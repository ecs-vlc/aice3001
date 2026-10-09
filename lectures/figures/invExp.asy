import myutil;
import graph;
size(400,0);

draw((-3,0)--(3,0), Arrow);
draw((0,-2)--(0,2), Arrow);
label("$x$", (3,0), E);
label("$y$", (0,2), N);

draw(graph(exp, -3, log(2)), red);
label("$f(x) = \mathrm{e}^{x}$", (log(2), 2), E, red);

ship();
draw((-2,-2)--(2,2), heavygreen+dashed);
label("$y=x$", (1.5,1.5), heavygreen, UnFill);
ship();

draw(graph(log, exp(-2), 3), red);
label("$f^{-1}(x) = \ln(x)$", (0.8, log(0.8)), SE, red);
ship();

draw(graph(pow10, -3, log10(2)), blue);
label("$f(x) = 10^{x}$", (log10(1.5), 1.5), W, blue, UnFill);

ship();

draw(graph(log10, pow10(-2), 3), blue);
label("$f^{-1}(x) = \log_{10}(x)$", (0.3, log10(0.3)), NW, blue, UnFill);
ship();

real log2(real x) {static real log2=log(2); return log(x)/log2;}
real pow2(real x) {return 2^x;}

draw(graph(pow2, -3, log2(2)), deepcyan);
label("$f(x) = 2^{x}$", (log2(1.2), 1.2), SE, deepcyan);

ship();

draw(graph(log2, pow2(-2), 3), deepcyan);
label("$f^{-1}(x) = \log_{2}(x)$", (0.3, log2(0.3)), SE, deepcyan);
ship();

