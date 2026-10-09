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



real eta = 0.32;
pair v = (0,0);
real a = 0.1;
for (int i=0; i<30; i+=1) {
  pair grad = gradient(pos);
  v = (1-a)*v - a*grad;
  pair newpos = pos + v;
  clip(bb);
  picture bg = new picture;
  add(bg,currentpicture);
  draw(pos--pos-0.2*grad, linewidth(1)+blue, Arrow);
  label("$-\bm{\nabla} f(\bm{x})$",  pos-0.25*grad, blue);
  ship();
  erase();
  add(bg);
  dot(newpos,linewidth(6));
  draw(pos--newpos, linewidth(2));
  ship();
  pos = newpos;
}

