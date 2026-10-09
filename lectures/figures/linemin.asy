import palette;
import graph;

real f(pair p)
{
  return 0.2*p.x*p.x+3.2*p.y*p.y;
}

real g(real x, real y)
{
  return 1-f((x,y));
}

path p = (-2,-0.8)--(2,-0.8)--(2,0.8)--(-2,0.8)--cycle;

picture pic;

image(pic,g,(-3,-1.5),(3,1.5),BWRainbow());

real value;
real radius;

real x(real t) {return 4*radius*sin(2*pi*t);}
real y(real t) {return radius*cos(2*pi*t);}

for (value = 0.04; value<1.51; value+=0.04) {
  radius = sqrt(value);
  draw(pic, graph(x,y,0,1,operator--));
}

pair pos = (-1.91,0.1);
dot(pic,pos,linewidth(6));
picture pic1;
size(pic1, 400,0);
add(pic1,rotate(10)*pic);
clip(pic1,p);
draw(pic1,p,white);

shipout("min2d-bg.eps", pic1);

erase(pic);


int piccnt = 0;
for (int i=0; i<10; i+=1) {
     pair grad = (0.4*pos.x,6.4*pos.y);
     real eta = -0.5*(0.04*pos.x*pos.x+10.24*pos.y*pos.y)/
       (0.008*pos.x*pos.x+32.768*pos.y*pos.y);
     pair newpos = pos + eta*grad;
     erase(pic);
     dot(pic,newpos,linewidth(6));
     draw(pic, pos--newpos, linewidth(2));
     string fn = "linemin-" + string(piccnt) + ".eps";
     erase(pic1);
     add(pic1, rotate(10)*pic);
     draw(pic1,p,white);
     clip(pic1,p);
     shipout(fn, pic1);
     piccnt += 1;
     pos = newpos;
}

add(rotate(10)*pic);
clip(p);
