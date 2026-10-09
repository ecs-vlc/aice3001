size(100,0);
include myutil;

guide g, g1;
real d=0;
for(int i=0; i<360; i+=30) {
  d+= 0.05*(rand()/randMax-0.5);
  g = g..(0.7+d)*(0.8*Cos(i), Sin(i));
  if (i>260 && i<280)
    g1 = g1..(0.5+0.6*(rand()/randMax))*(0.8*Cos(i), Sin(i))-(0,1.7);
  else;
  g1 = g1..(0.5+0.6*(rand()/randMax))*(0.8*Cos(i), Sin(i))-(0,1.8);
}
g = g..cycle;
g1 = g1..cycle;

filldraw(g, palered);
filldraw(g1, palered);

label("Convex region", (0,0.85));
label("Non-convex region", (0,-1.05));

pair x = (-0.3,-2.4);
pair y = (0.3,-2.5);
pair z = 0.7*x+0.3*y;
draw(x--y, blue);
dot(x, blue);
dot(y, blue);
label("$\bm{x}$", x, N, blue);
label("$\bm{y}$", y, N, blue);
label("$\bm{z}$", z, 2S, blue);
label("\large $\bm{\times}$", z, blue);

x = (-0.3,0);
y = (0.3,0);
z = 0.7*x+0.3*y;
draw(x--y, blue);
dot(x, blue);
dot(y, blue);
label("$\bm{x}$", x, N, blue);
label("$\bm{y}$", y, N, blue);
label("$\bm{z}$", z, 2S, blue);
label("\large $\bm{\times}$", z, blue);
