import myutil;
import graph;
size(280,0);

real innerangle = radians(60);
real outerangle = radians(70);
real midangle = radians(0);
private real defaultratio = .14;
path brace(pair a, pair b, real amplitude = defaultratio*length(b-a)) {
  transform t = identity();
  real length = length(b-a);
  real sign = (amplitude < 0 ? -1 : 1);
  path brace;
  if (abs(amplitude) < defaultratio*length) {
    real slope = 2*defaultratio;
    real controldist = (abs(amplitude)/2) / slope;
    brace = (0,0){expi(sign*outerangle)} :: {expi(sign*midangle)}(controldist, amplitude/2) :: {expi(sign*midangle)} (length/2 - controldist,amplitude/2) :: {expi(sign*innerangle)} (length/2, amplitude) {expi(-sign*innerangle)} :: {expi(-sign*midangle)} (length/2 + controldist, amplitude/2) :: {expi(-sign*midangle)} (length-controldist, amplitude/2) :: {expi(-sign*outerangle)} (length,0);
  } else {
    brace = (0,0){expi(sign*outerangle)} ::
    {expi(sign*midangle)}(length/4, amplitude/2)
               :: {expi(sign*innerangle)} (length/2, amplitude)
                            {expi(-sign*innerangle)}
    :: {expi(-sign*midangle)}(3*length/4, amplitude/2) ::
    {expi(-sign*outerangle)} (length,0);
  }
  real angle = degrees(atan2((b-a).y, (b-a).x));
  t = rotate(angle)*t;
  t = shift(a) * t;
  return t * brace;
}

pair plane(real x) {
  return (x, -3*x/4+2.5);
}

draw((-2,0)--(6,0), Arrow);
label("$x_1$", (6,0), E);
draw((0,-2)--(0,4), Arrow);
label("$x_2$", (0,4), N);

draw((6,-2)--(-2,4), linewidth(2));
ship();

draw((0,0)--(3,4), blue, Arrow);
label("$\bm{w}$", 1.05*(3,4), blue);
real b = 2;
pair w = (3,4)/5;
pair wperp = (4,-3)/5;
draw(2.3*w--2.3*w+0.3wperp--2*w+0.3wperp, blue);
ship();

draw(-wperp--wperp, dashed);
draw(0.9*wperp--2*w+0.9wperp, heavygreen, Arrows);
label("$b$", w+1.19wperp, heavygreen, UnFill);
picture bg = new picture;
add(bg, currentpicture);
ship();

pair x = 2*w-2.5*wperp;
dot(x, linewidth(5)+purple);
label("$\bm{x}$", x, NE, purple);
ship();

draw((0,0)--x, purple, Arrow);
real theta = 180*atan2(4.0,3.0)/pi;
real theta_x = 180*atan2(x.y, x.x)/pi;
draw(arc((0,0), 1, theta, theta_x), purple);
label("$\theta$", 1.25*(Cos(0.5*theta+0.5*theta_x), Sin(0.5*theta+0.5*theta_x)), purple);
ship();

draw(brace(2w+0.05wperp, 0.05wperp), purple);
draw((2.4,1.5)-- w+0.4wperp, purple, Arrow);
label("$\|\bm{x}\|\cos(\theta)$", (2.4,1.5), E, purple);
label("$= \displaystyle \frac{\langle \bm{x}, \bm{w}\rangle}{\|\bm{w}\|}$", (4.3,1.5),E, purple);
ship();
erase();
add(bg);
label("$\left\{ \bm{x} \Big| \frac{\langle \bm{x}, \bm{w}\rangle}{\|\bm{w}\|} = b\right\}$", (4,-1.5), W);
draw((4,-1.5)--(4.8,-1.2), Arrow);
ship();

x = 4*w+1.2wperp;
dot(x, red+linewidth(5));
label("$\bm{x}_k$", x, E, red);
ship();

draw(4w-wperp--4w+2wperp, dashed);
draw(-0.9wperp--4w-0.9wperp, purple, Arrows);
label("$\displaystyle \frac{\langle \bm{x}_k, \bm{w}\rangle}{\|\bm{w}\|}$", 3.1w-1.5wperp, purple);
ship();

draw(2w+1.6wperp--4w+1.6wperp, purple, Arrows);
label("$s_k = y_k\,\left(\frac{\langle \bm{x}_k, \bm{w}\rangle}{\|\bm{w}\|} -b \right)$", 3w+1.7wperp, E, purple);
ship();
