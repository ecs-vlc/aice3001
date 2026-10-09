import graph3;
import contour;
size(400,0);

currentprojection=perspective(5,5,20);
real f(pair z) {
  real x = z.x;
  real y = -9/8.0;
  real alpha = z.y;
  return ((x^2+2*y^2-x*y)-alpha*(x-2*y-3));
}
picture surface=surface(f,nsub=4,(-1,0.5),(2.5,5),nx=10);



bbox3 b=limits(O,(3.7,6.7,5.7));
xaxis(Label("$x$",1),b,red,Arrow);
yaxis(Label("$\alpha$",1),b,red,Arrow);
zaxis(Label("$\mathcal{L}$",1),b,red,Arrow);
add(surface);
xaxis(Label("$x$",1),b,red+dashed,RightTicks,Arrow);
yaxis(Label("$\alpha$",1),b,red+dashed,RightTicks,Arrow);
zaxis(Label("$\mathcal{L}$",1),b,red+dashed,RightTicks,Arrow);


triple opt = (3/4,21/8,63/15);

dot(opt, blue+linewidth(5));

//real[] con = {0.5,0.6,0.7,0.8,0.9,1.1,1.2,1.3,1.4,1.5,1.6,1.7};
real[] con = sequence(1,12);

guide[][] contours = contour(f,(-1,0.5),(2.5,5), con);

for (int i=0; i<con.length; ++i) {
  for (int j=0; j<contours[i].length; ++j) {
    guide3 g;
    for (int k=0; k<length(contours[i][j]); ++k) {
      pair p = point(contours[i][j],k);
      g = g--(p.x,p.y,con[i]);
    }
    draw(g);
  }
}

// picture contourpic;
// draw(contourpic, contours);
// draw(contourpic,(-1,0)--(3,0), red, Arrow);
// draw(contourpic,(0,0)--(0,5), red, Arrow);
// label(contourpic,"$x$", (3,0), E, red);
// label(contourpic,"$\alpha$", (0,5), N, red);
// dot(contourpic, (3/4,21/8));
// add(shift(10,-1.4)*scale(1.5)*contourpic);
