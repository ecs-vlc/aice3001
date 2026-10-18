// Problem sheet optimisation, 2(a): rectangle with sides x and y
settings.outformat="pdf";
unitsize(1cm);

real w = 3.2, h = 1.8;
filldraw(box((0,0), (w,h)), paleblue, black+linewidth(1));
label("$x$", (w/2,h), N);
label("$x$", (w/2,0), S);
label("$y$", (0,h/2), W);
label("$y$", (w,h/2), E);
label("$A = x\,y$", (w/2,h/2));
label("$P = 2(x+y)$", (w+1.0,h/2), E);
