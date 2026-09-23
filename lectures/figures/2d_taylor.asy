import myutil;
import three;
import graph3;
size(400,0);

// Look roughly down the surface normal at p, so the approximating patch is
// seen face on rather than edge on. The default view puts the hill between
// the camera and p, and foreshortens the patch to a sliver.
currentprojection = perspective(10, -3, 4.5);

real f(pair xy) {
real x = xy.x; real y = xy.y;
return 2*exp(-0.5*x*x - y*y)  + exp(-0.5*(x-1)*(x-1) - (y-2)*(y-2));
}

// The point we expand about, the radius of the patch the approximation is
// drawn over, and how see-through that patch is (1 = solid).
pair p = (1.7,1.1);
real patchRadius = 0.8;
real patchOpacity = 1;
// The function is drawn see-through so the whole patch stays visible: the
// approximation touches f at p and so is half buried if f is solid.
real surfaceOpacity = 0.8;

pair bbmin = (-3, -3);
pair bbmax = (5,4);
surface s = surface(f, bbmin, bbmax, Spline);
draw(s, surfacepen=paleblue+opacity(surfaceOpacity));


draw(-3X--5.2X, Arrow3);
draw(-3Y--4.2Y, Arrow3);
draw(O--2.4Z, Arrow3);
label("$x_1$", 5.4X);
label("$x_2$", 4.4Y);
label("$f(\bm{x})$", 2.6Z);

ship();

triple p3 = (p.x, p.y, f(p));

dot(p3, red);

ship();

// Derivatives by central differences, so that changing f above is enough:
// nothing below needs to know what f is.
real h = 1e-3;
real fx(pair q)  { return (f(q+(h,0)) - f(q-(h,0)))/(2*h); }
real fy(pair q)  { return (f(q+(0,h)) - f(q-(0,h)))/(2*h); }
real fxx(pair q) { return (f(q+(h,0)) - 2*f(q) + f(q-(h,0)))/(h*h); }
real fyy(pair q) { return (f(q+(0,h)) - 2*f(q) + f(q-(0,h)))/(h*h); }
real fxy(pair q) {
  return (f(q+(h,h)) - f(q+(h,-h)) - f(q+(-h,h)) + f(q+(-h,-h)))/(4*h*h);
}

real f0 = f(p);
real gx = fx(p),   gy = fy(p);
real hxx = fxx(p), hyy = fyy(p), hxy = fxy(p);

// Taylor expansion about p, truncated after the given order.
real taylor(real x, real y, int order) {
  real dx = x - p.x, dy = y - p.y;
  real v = f0;
  if (order >= 1) v += gx*dx + gy*dy;
  if (order >= 2) v += 0.5*(hxx*dx*dx + 2*hxy*dx*dy + hyy*dy*dy);
  return v;
}

// The approximation over a disc around p, so that it reads as a local fit.
// The disc is parameterised by (radius, angle) rather than drawn over a
// square, which would suggest the approximation holds in a wider region.
surface patch(int order) {
  triple g(pair ra) {
    real r = ra.x, th = ra.y;
    real x = p.x + r*cos(th), y = p.y + r*sin(th);
    return (x, y, taylor(x, y, order));
  }
  return surface(g, (0,0), (patchRadius, 2*pi), 12, 48);
}

pen[] patchPen = {yellow, orange, red};
string[] caption = {
  "$f(\bm{p})$",
  "$f(\bm{p}) + (\bm{x}-\bm{p})^\tr \nabla f(\bm{p})$",
  "$\cdots + \tfrac{1}{2}\,(\bm{x}-\bm{p})^\tr \mat{H} \,(\bm{x}-\bm{p})$"
};

picture bg = new picture;
bg.add(currentpicture);

for (int order = 0; order <= 2; ++order) {
  erase();
  add(bg);
  draw(patch(order), surfacepen=patchPen[order]+opacity(patchOpacity));
  dot(p3, red);                  // redrawn so the point stays visible
  label(caption[order], (0, 0.5, 2.1), NE, patchPen[order]);
  ship();
}
