settings.outformat="pdf";
import myutil;
import palette;
import graph;
import contour;
import stats;

size(400,0);

real f(pair p)
{
  return 1.2*p.x*p.x+2.2*p.y*p.y - 1.3*p.x*p.y;
}

pair gradient(pair p) {
  return (2.4*p.x-1.3*p.y, 4.4*p.y-1.3*p.x);
}

real g(real x, real y)
{
  return 1-f((x,y));
}

pair noise() {return (Gaussrand(), Gaussrand());}

pair ll = (-2.2,-1);
pair ur = (2.2,1);
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

clip(bb);
draw(bb,white);
picture bg = new picture;
add(bg, currentpicture);


ship();


pair x = pos;

real[] etaList = new real[] {0.3, 0.03};
for (int i=0; i<etaList.length; ++i) {
  erase();
  add(bg);
  dot(x,linewidth(6));
  real eta = etaList[i];
  label("$\bm{w}(t+1) = \bm{w}(t) - " + string(eta,3)
	+ "\bm{\nabla} L_{\mathcal{B}}(\bm{w}(t))$", (-0.5, 0.8), E, UnFill); 
  for (int i=0; i<15; i+=1) {
    pair newx = x - eta*(gradient(x) + noise());
    dot(newx,linewidth(6));
    draw(x--newx, linewidth(2));
    clip(bb);
    ship();
    draw(x--newx, gray+linewidth(2));
    dot(x,gray+linewidth(6));
    x = newx;
  }
}


