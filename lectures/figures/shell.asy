// A thin spherical shell of radius r and thickness dr: its volume is the
// surface area of the ball times dr, proportional to r^(n-1) dr in n
// dimensions.  Drawn in 2-D (no 3-D opacity, which renders badly on the
// Mac): two circles with a shaded gap, and dashed/solid equators.
import myutil;
unitsize(1.4cm);

real r = 1, dr = 0.18;
fill(circle((0, 0), r + dr), paleblue);
fill(circle((0, 0), r), white);
draw(circle((0, 0), r + dr), blue);
draw(circle((0, 0), r), blue);
// equator of the inner sphere: back half dashed, front half solid
path eq = xscale(r)*yscale(0.3r)*unitcircle;
draw(subpath(eq, 0, 2), gray(0.5) + dashed);
draw(subpath(eq, 2, 4), gray(0.5));
dot((0, 0));
draw((0, 0)--dir(30)*r, Arrow(5));
label("$r$", dir(30)*r/2, NW, fontsize(10pt));
draw(dir(-35)*r--dir(-35)*(r + dr), black, Arrows(3));
label("$\mathrm{d}r$", dir(-35)*(r + dr), SE, fontsize(10pt));
ship();
erase();
