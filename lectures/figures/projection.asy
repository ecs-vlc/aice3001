import myutil;
size(200,0);

draw(box((-0.02,-0.03), (2.0,1)), white);

pair a = (0.2, 0.9);
pair b = (1.2, 0.8);

draw((0,0)--a, blue, Arrow);
label("$\bm{a}\;$", 1.05*a,  blue);
ship();


draw((0,0)--b, red, Arrow);
label("$\bm{b}$", 1.04*b, red);
ship();

real ab = dot(a,b);
real al = sqrt(dot(a,a));
real bs = dot(b,b);

pair proj = (ab/bs)*b;

draw(proj--a, heavygreen+dotted);
draw((0,0)--proj, heavygreen, Arrow);
label("$\mathrm{proj}_{\bm{b}}(\bm{a})$", proj, conj(proj), heavygreen);

real theta1 = aTan(a.y / a.x);
real theta2 = aTan(b.y / b.x);
draw(arc((0,0), 0.1, theta1, theta2), heavygreen);
real theta = 0.5*(theta1 + theta2);
label("$\theta$", 0.17*(Cos(theta), Sin(theta)), heavygreen);

ship();

label("$= \| \bm{a} \| \cos(\theta) \, \frac{\bm{b}}{\|\bm{b}\|}$", (1., 0.3), E, heavygreen);

ship();

label("$= \frac{\langle \bm{a}, \bm{b} \rangle}{\langle \bm{b}, \bm{b} \rangle} \bm{b}$", (1., 0.10), E, heavygreen);

ship();
