import myutil;
size(400,0);

pair x = (0,0);
pair A = (3,0);
pair B = (2,0);
pair C = (1,0);

draw(box((-0.2,-0.7), (3.6,0.7)), white);

path connect(pair x, pair y) {
  return (0.95x+0.05y)--(0.95y+0.05x);
}

path jump(pair x, pair y, real z) {
  return x+(0.05,0.05*z)..(0.5*(x+y)+(0,0.5*z))..y+(-0.05,0.05*z);
}

dot(x);
label("$\bm{x}$", x, S);
ship();

dot(C);
label("$\mat{C}\bm{x}$", C, S);
draw(connect(x,C), Arrow);
label("$\mat{C}$", 0.5*(x+C), N);
ship();

dot(B);
label("$\mat{B}\mat{C}\bm{x}$", B, S);
draw(connect(C,B), Arrow);
label("$\mat{B}$", 0.5*(B+C), N);
ship();

dot(A);
label("$\mat{A}\mat{B}\mat{C}\bm{x}$", A, E);
draw(connect(B,A), Arrow);
label("$\mat{A}$", 0.5*(B+A), N);
ship();

label("$(\mat{B}\mat{C})\bm{x}$", B, 5N);
draw(jump(x,B, 1), Arrow);
label("$(\mat{B}\mat{C})$", 0.5*(B+x)+(0,0.5), N);
ship();

label("$\mat{A}(\mat{B}\mat{C})\bm{x}$", A, 2N);
ship();


label("$(\mat{A}\mat{B})\mat{C}\bm{x}$", A, 5S);
draw(jump(C,A, -1), Arrow);
label("$(\mat{A}\mat{B})$", B-(0,0.5), S);
ship();
