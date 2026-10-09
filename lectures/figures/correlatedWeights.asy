settings.outformat="pdf";
import myutil;
import palette;
import graph;
import contour;

size(400,0);

real f(pair p)
{
  return p.x*p.x+p.y*p.y - 1.8*p.x*p.y;
}


real g(real x, real y)
{
  return 1-f((x,y));
}

pair ll = (-2.2,-1.8);
pair ur = (2.2,1.8);
path bb = box(ll, ur);


image(g,ll, ur,BWRainbow());

real c[] = new real[100];
for(int i=0; i<c.length; ++i) {
  c[i] = 0.5*(1+i);
}

draw(contour(f, ll, ur, c));



