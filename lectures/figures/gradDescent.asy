settings.outformat="pdf";
import myutil;
import palette;
import graph;
import contour;

size(400,0);

real f(pair p)
{
  return 0.2*p.x*p.x+3.2*p.y*p.y - 1.3*p.x*p.y;
}

pair gradient(pair p) {
  return (0.4*p.x-1.3*p.y, 6.4*p.y-1.3p.x);
}

real g(real x, real y)
{
  return 1-f((x,y));
}

pair ll = (-2.2,-1.2);
pair ur = (2.2,1.2);
path bb = box(ll, ur);


image(g,ll, ur,BWRainbow());

real c[] = new real[12];
for(int i=0; i<c.length; ++i) {
  c[i] = 0.5*(1+i);
}

draw(contour(f, ll, ur, c));

real value;
real radius;


pair pos = (-1.91,0.1);
dot(pos,linewidth(6));

clip(bb);
draw(bb,white);

ship();

picture bg = new picture;
add(bg, currentpicture);

real[] etaList = new real[] {0.2, 0.3, 0.31};
for (int i=0; i<etaList.length; ++i) {
  erase();
  add(bg);
  pair x = pos;
  real eta = etaList[i];
  label("$\bm{x}(t+1) = \bm{x}(t) - " + string(eta,3)
	+ "\bm{\nabla} f(\bm{x}(t))$", (-0.5, 0.8), E, UnFill); 
  for (int i=0; i<15; i+=1) {
    pair newx = x - eta*gradient(x);
    dot(newx,linewidth(6));
    draw(x--newx, linewidth(2));
    clip(bb);
    ship();
    x = newx;
  }
}

