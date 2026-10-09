import contour;
import stats;
size(400);
real f(real x, real y) {return x^2+2y^2-x*y;}
real g(real x, real y) {return x-3y-2;}


real[] con = {0.25,0.5,0.75,1};
Label[] Labels=sequence(new Label(int i) {
return Label(con[i] != 0 ? (string) con[i] : "",Relative(-unitrand()),(0,0),
UnFill(1bp));
},con.length);
guide[][] contours = contour(f,(-1.2,-1.0),(1.2,1.0), con);
draw(Labels, contours, lightred);
real[] con2 = {-1,0,1};
Label[] Labels2=sequence(new Label(int i) {
return Label((string) con2[i],Relative(unitrand()),(0,0),
UnFill(1bp));
},con2.length);
draw(Labels2, contour(g,(-1.2,-1.0),(1.2,1.0), con2), lightblue);
draw(new Label[]{Labels2[1]}, contour(g,(-1.2,-1.0),(1.2,1.0), new real[]{0}), blue);

label("$g(\mathbf{x})=0$", (0.9, (0.9-2)/3), SE, blue);
label("$f(\mathbf{x})$",(0,0), red);

int piccnt = 0;
void out() {
  string fn = "constrainedopt"+string(piccnt)+".eps";
  ++piccnt;
  shipout(fn);
}

out();
picture contour;
add(contour,currentpicture);

for(real x=-0.5; x<0.8; x+=0.3) {
  real y = (x-2)/3.0;
  pair d = 0.05*(1,-3);
  draw((x,y)--(x,y)+d, blue, Arrow);
}

for(int i=0; i<con.length; ++i) {
  real len = length(contours[i][0]);
  for(real t=0; t<len; t+=0.1*len) {
    pair pos = point(contours[i][0],t);
    pair d = 0.05*(2pos.x-pos.y,4pos.y-pos.x);
    draw(pos--pos+d, lightred, Arrow);
  }
}

out();
erase();
add(contour);
draw(contour(f,(-1.2,-1.0),(1.2,1.0), new real[]{7/8}), red);
pair maxi = (1/8,-5/8);
pair d = 0.05*(2maxi.x-maxi.y,4maxi.y-maxi.x);
draw(maxi--maxi+d, red, Arrow);
label("$\nabla f(\mathbf{x})$", maxi+1.5d, red);
real s = length(d);
d = s*unit(0.05*(1,-3));
draw(maxi--maxi-d, blue, Arrow);
label("$-\alpha \nabla g(\mathbf{x})$", maxi-1.5d, blue);
dot(maxi);



out();
