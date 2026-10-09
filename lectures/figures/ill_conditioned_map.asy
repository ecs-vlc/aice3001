import graph3;
import solids;


size(200,0);
real ax=-40;
real ay=10;

real udev()
{
  return rand()/(1.0+randMax);
}

void sphere1(triple pos, pen col)
{
  real u=0.03;
  triple npos=rotate(ax,X)*rotate(ay,Y)*pos;
  path3 p;
  p = (u,u,u)--(u,-u,u)--(-u,-u,u)--(-u,u,u)--cycle3;
  path3 np=shift(npos)*p;
  fill(np,0.5*col);
  p = (u,u,u)--(u,u,-u)--(-u,u,-u)--(-u,u,u)--cycle3;
  np=shift(npos)*p;
  fill(np,0.7*col);
  p = (u,u,u)--(u,u,-u)--(u,-u,-u)--(u,-u,u)--cycle3;
  np=shift(npos)*p;
  fill(np,0.9*col);
}


guide3 g=(1,0,0)..(0,1,0)..(-1,0,0)..(0,-1,0)..cycle3;
g=(1,1,0)--(-1,1,0)--(-1,-1,0)--(1,-1,0)--cycle3;
guide3 gr = rotate(ax,X)*rotate(ay,Y)*g;

filldraw(gr,palered,red);
path3 a=O--(0.9*Z);
path3 ar=rotate(ax,X)*rotate(ay,Y)*a;
draw(ar,red,BeginBar,Arrow);
a=(0.5,0.5,0)--(0.5,0.5,0.9);
ar=rotate(ax,X)*rotate(ay,Y)*a;
draw(ar,blue,BeginBar);
a=(0.5,0.5,0)--(0.5,0.5,-0.9);
ar=rotate(ax,X)*rotate(ay,Y)*a;
draw(ar,blue+dashed);
draw(rotate(ax,X)*rotate(ay,Y)*((0.5,0.5,0)--(0.4,-0.3,0)),green,MidArrow);
draw(rotate(ax,X)*rotate(ay,Y)*((0.5,0.5,0.6)..(0.45,0.2,0.45)..(0.4,-0.3,0.1)),green,MidArrow);
draw(rotate(ax,X)*rotate(ay,Y)*((0.5,0.5,-0.6)..(0.45,0.45,-0.67)..(0.4,-0.3,-0.1)),green,MidArrow);
sphere1((0.5,0.5,0),red);
sphere1((0.5,0.5,0.6),red);
sphere1((0.5,0.5,-0.6),red);
sphere1((0.4,-0.3,0.1),green);
sphere1((0.4,-0.3,0),green);
sphere1((0.4,-0.3,-0.1),green);


draw((0,0,0)--(1.3,0,0),Arrow);
draw((0,0,0)--(0,1.2,0),Arrow);
draw((0,0,0)--(0,0,1.2),Arrow);



