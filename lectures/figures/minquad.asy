import graph;

size(450,0);

void boundary(picture pic=currentpicture)
{
  draw(pic, (-0.62,-0.14)--(0.62,-0.14)--(0.62,0.55)--(-0.62,0.55)--cycle, white);
}

boundary();

xaxis("$x$",-0.6,0.6,Arrow);
yaxis(0,0.35,Arrow);
label("$f(x)=x^2$", (0,0.35),N);
label("$x\leftarrow x - r\,f'(x)$", (-0.6,0.45),E);

real f(real x) {return x*x;}

pair F(real x) {return (x, f(x));}

draw(graph(f,-0.6,0.6,operator..));


shipout("minquad-bg");

int piccnt = 0;

void update(real r, pen col, real xpos)
{
  real x = 0.4;
  picture pic;
  size(pic,450,0);
  boundary(pic);
  dot(pic, F(x),red+linewidth(3));
  label(pic, "r = " + string(r), (xpos,-0.05), E, col);
  string fn = "minquad-" + string(piccnt);
  shipout(fn, pic);
  piccnt += 1;
  
  for(int i=0; i<6; i+=1) {
    real y = x - 2*r*x;
    picture pic;
    size(pic,450,0);
    boundary(pic);
    dot(pic, F(y),col+linewidth(3));
    draw(pic, F(x)--F(y), col+linewidth(1));
    string fn = "minquad-" + string(piccnt);
    shipout(fn, pic);
    piccnt += 1;
    x = y;
  }
}

update(0.05, red, -0.6);
update(0.2, blue, -0.4);
update(0.9, deepgreen, -0.2);
update(1.02, cyan, 0);
