import graph3;
size(300,0);
currentprojection=perspective(5,4,2);
real f(pair z) {return 0.1*(z.x^2+2*z.y^2-z.x*z.y);}
picture surface=surface(f,nsub=4,(-2,-2),(2,2),nx=10);



bbox3 b=limits(O,1.75(1,1,1));
xaxis(Label("$x$",2.5),b,red,Arrow);
yaxis(Label("$y$",2.5),b,red,Arrow);
zaxis(Label("$f(x,y)$",2.5),b,red,Arrow);
add(surface);
xaxis(Label("$x$",2),b,red+dashed,Arrow);
yaxis(Label("$y$",2),b,red+dashed,Arrow);
zaxis(Label("$f(x,y)$",2),b,red+dashed,Arrow);

real x(real t) {return t;}
real y(real t) {return 0.5*(t-3);}
real z(real t) {return 0.1*(t^2 + 2*y(t)^2 -t*y(t));}
real zero(real t) {return 0;}

draw(graph(x,y,z,-1,2,operator..), red+linewidth(2));
//draw(graph(x,y,zero,-1,2,operator..), red+dashed+linewidth(2));

triple opt = (3/4,-9/8, 6.3/16);

pair grad = 1*(2*opt.x-opt.y, 4*opt.y-opt.x);
triple grad3 = 0.1*(grad.x, grad.y, f(opt+grad)-f(opt));

draw(opt--opt+grad3, heavygreen+linewidth(2), Arrow(10));

dot(opt, blue+linewidth(5));

label("$\nabla f(\mathbf{x})$", opt+grad3, 4N, heavygreen);
