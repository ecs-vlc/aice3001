import myutil;
size(350,0);

draw(box((-1.22,-0.03), (2.2,1)), white);

pair a = (0.2, 0.9);
pair b = (1.2, 0.8);

draw((0,0)--b, red, Arrow);
label("$\bm{a}_1$", 1.04*b, red);
ship();

draw((0,0)--a, blue, Arrow);
label("$\bm{a_2}\;$", 1.05*a,  blue);
ship();



real ab = dot(a,b);
real al = sqrt(dot(a,a));
real bs = dot(b,b);

pair proj = (ab/bs)*b;

draw(proj--a, heavygreen+dotted);
draw((0,0)--proj, heavygreen, Arrow);
label("$\mathrm{proj}_{\bm{a_1}}(\bm{a_2})$", proj, conj(proj), heavygreen);

real theta1 = aTan(a.y / a.x);
real theta2 = aTan(b.y / b.x);
draw(arc((0,0), 0.1, theta1, theta2), heavygreen);
real theta = 0.5*(theta1 + theta2);
label("$\theta$", 0.17*(Cos(theta), Sin(theta)), heavygreen);


label("$= \| \bm{a}_2 \| \cos(\theta) \, \frac{\bm{a}_1}{\|\bm{a}_1\|}$", (1.2, 0.3), E, heavygreen);


label("$= \frac{\langle \bm{a}_2, \bm{a}_1 \rangle}{\langle \bm{a}_1, \bm{a}_1 \rangle} \bm{a}_1$", (1.2, 0.10), E, heavygreen);

ship();

pair ap = a - proj;

draw(a--ap, dotted+blue);
draw((0,0)--ap, blue+linewidth(1), Arrow(10));

label("$\bm{a}_2 - \mathrm{proj}_{\bm{a}_1}(\bm{a}_2)$", ap, NW, blue);

ship();

