import cakes;

texpreamble("\newcommand{\indep}{\perp \!\!\!\! \perp}");

size(6cm,0);
pair A = (0,0);
pair B = (10,0);
pair C = (5,-2);
pair D = (0,-4);
pair E = (10,-4);
node(A,"A");
node(B,"B");
node(C,"C");
node(D,"D");
node(E,"E");
depend(A,C);
depend(B,C);
depend(C,D);
depend(C,E);

label("$A \indep B$", B+(10,0));
label("$D \not\indep E$", E +(10,0));

ship();
erase();

node(A,"A");
node(B,"B");
node(C,"C", true);
node(D,"D");
node(E,"E");
depend(A,C);
depend(B,C);
depend(C,D);
depend(C,E);

label("$A \not\indep B$", B+(10,0));
label("$D \indep E$", E +(10,0));
ship();
