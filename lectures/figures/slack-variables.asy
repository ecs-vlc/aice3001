size(300,0);

pair u = unit((20,35));


void datum(pair p, bool type)
{
  if (type)
    fill(shift(p-(0.5,0.5))*unitsquare,red);
  else
    fill(circle(p,0.5),heavygreen);
}

pair sv(real a, int class) {return a*(0,20)+(1-a)*(35,0)+class*5u;}

datum(sv(0.7,1), true);
datum(sv(0.25,1), true);
datum(sv(0.4,-1), false);
for(int i=0; i<6; ++i) {
  pair p = (15+20.0*rand()/randMax,25-14.0*rand()/randMax);
  datum(p,true);
  pair p = (20.0*rand()/randMax,11-10.0*rand()/randMax);
  datum(p,false);
}

draw(box((0,0),(35,23)),white);
//clip(box((0,0),(35,25)));


draw((0,20)--(35,0));
draw(shift(5*u)*((0,20)--(35,0)),dashed);
draw(shift(-5*u)*((0,20)--(35,0)),dashed);
pair m = (17.5,10);

//draw(m--m+5*u,Arrows);
//draw(m--m-5*u,Arrows);
//label("$m$",m+2.5*u,SE);
//label("$m$",m-2.5*u,SE);
pair d1 = sv(0.8,-1)+3unit((20,35));
pair d2 = sv(0.7,-1)+3unit((20,35));
datum(d1, false);
label("$\mathbf{x}_k$", d1, N);
draw(d1--d2, dashed);
draw(sv(0.7,-1)--d2, Arrows);
draw("$\xi_k$", sv(0.7,-1)+1.5*unit((20,35)),NW);

clip(box((0,0),(35,23)));
