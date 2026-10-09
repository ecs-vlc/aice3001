import myutil;
import graph;
size(150,0);

real f(real x) {return 0.03*(x*x*x*x+3*x*x*x-2*x*x-4*x+20);}
real grad(real x) {return 0.03*(4*x*x*x+9*x*x-4*x-4);}
pair F(real x) {return (x,f(x));}

real roots[] = cubicroots(4,9,-4,-4);
dot((0,grad(-3.3)), white);

xaxis("$x$");
yaxis();

label("$f(x)$",(-2.3,0.8),blue);
draw(graph(f,-3.5,2.3,operator ..),blue);	
ship();

draw(graph(grad,-3.3,2.1,operator ..),red);	
label("$f'(x)$",(-2.3,-0.8),red);
ship();
for (int i; i<3; i+=1) {
     dot(F(roots[i]),darkgreen);
}
ship();
