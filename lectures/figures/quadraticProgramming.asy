size(250,0);
import settings;
render = 0;
import graph;
import contour;
import myutil;
import patterns;

pair a=(-1,-1);
pair b =(1.1,1.1);

defaultpen(1bp);
pen Tickpen=black;
pen tickpen=grey+0.5*linewidth(currentpen);

real f(real x, real y) {return x*x + y*y;}


int Divs=10;
int divs=2;


real[] Cvals=uniform(0,1.9,Divs);
draw(contour(f,a,b,Cvals,200,operator --),dashed+linewidth(0.5)+grey);
draw((-1,0)--(1,0), Arrow);
draw((0,-1)--(0,1), Arrow);
label("$\hat{w}_2$", (0,1), N, UnFill);
label("$\hat{w}_1$", (1,0), E, UnFill);
ship();
picture bg = new picture;
add(bg,currentpicture);
erase();
add("hatch",hatch(lightred));
add("hatchback",hatch(W,lightred));
add("hatchvert",hatch(N,lightred));
filldraw((-0.2,-1)--(0.6,1.1)--(-1,1.1)--a--cycle, pattern("hatch"), white);
draw((-0.2,-1)--(0.6,1.1), red);
add(bg);
ship();
erase();
filldraw((-0.2,-1)--(0.6,1.1)--(-1,1.1)--a--cycle, pattern("hatch"),white);
filldraw((1.1,0.4)--(-0.4,1.1)--(-1,1.1)--a--(1.1,-1)--cycle, pattern("hatchback"),white);
draw((-0.2,-1)--(0.6,1.1), red);
draw((1.1,0.4)--(-0.4,1.1), red);
add(bg);
ship();

filldraw((-0.5,1.1)--(0.3,-1)--a--(-1,1.1)--cycle, pattern("hatchvert"),white);
draw((-0.5,1.1)--(0.3,-1), red);
ship();

draw("\huge$\bm{\times}$", (0.447,0.7), blue);
ship();
