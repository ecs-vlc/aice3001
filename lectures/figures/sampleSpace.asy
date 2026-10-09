size(100,0);
import graph;
import palette;
import contour;
import myutil;

pair a=(0,-0.2);
pair b =(2,1.1);

defaultpen(1bp);
pen Tickpen=black;
pen tickpen=gray+0.5*linewidth(currentpen);

real f(real x, real y) {return 1-exp(4*(-(x-0.8)^2 -2*(y-0.4)^2 - 0.3*x*y));}

pen[] Palette=Grayscale();

int N=200;
int Divs=5;
int divs=2;

bounds range=image(f,Automatic,a,b,N,Palette);

real[] Cvals=uniform(range.min,range.max,Divs);
draw(contour(f,a,b,Cvals,200,operator --),dashed+linewidth(0.5));
label("$p(\bm{x})$", (0.8,0.4), yellow);

draw(box(a,b));
label("$\mathcal{X}$", b, SW);
