import myutil;
size(200,0);
import stats;
import graph;
srand(4);

draw(box((-0.2, -1), (0.9, 1.2)), white);

pair grand() {
  return (Gaussrand(), Gaussrand());
}

pair optimise(pair start) {
  pair x = start;
  draw((0,0)--start, Arrow);
  label("$\bm{w}(0)$", 1.05*x);
  ship();
  for (int i=0; i<100; ++i) {
    pair y = 0.997*x + 0.02*grand();
    draw(x--y, red);
    if (i%10==9)
      ship();
    x= y;
  }
  draw((0,0)--x, Arrow);
  label("$\bm{w}(T)$", 1.05*x, UnFill);
  ship();
  real theta1 = 180/pi*atan2(start.y, start.x);
  real theta2 = 180/pi*atan2(x.y, x.x);
  draw(arc((0,0), 0.35, theta1, theta2));
  real theta3 = 0.5*(theta1+theta2);
  label("$\theta$", 0.4*(Cos(theta3), Sin(theta3)));
  ship();
  return x;
}

pair x0 = optimise((0.0,1.0));

pair x1 = optimise((Cos(40), -Sin(40)));

draw(x0..(0.5*(x0+x1)+(0.1,0))..x1, blue, MidArrow);

ship();
