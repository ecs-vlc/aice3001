import settings;
//settings.outformat="pdf";
//settings.prc=true;
render=0;
import three;
import graph3;
import myutil;


size(400,0);

axes3("$x_1$", "$x_2$", "$x_3$", (0,0,0), (1,1,1));
dot((1,-0.5,-0.75),white);
dot((-2,2,1.2), white);

if (false){
label("\begin{align*}
\bm{M} &= \begin{pmatrix}
0.80 & 0.01 & 0.25 \\
0.01 & 0.85 & 0.48 \\
0.25 &  0.48 & 0.5
\end{pmatrix} \\
&= \bm{V} \begin{pmatrix}
0.8 & 0 & 0 \\
0 & 1.25 & 0 \\
0 & 0 & 0.1
\end{pmatrix} \bm{V}^{\textsf{T}}
\end{align*}", (-1.3,1.3,0.9));
}

label("$\bm{M} = \begin{pmatrix}
0.80 & 0.01 & 0.25 \\
0.01 & 0.85 & 0.48 \\
0.25 &  0.48 & 0.5
\end{pmatrix}$", (-1.3,1.3,0.9));

label("$= \bm{V} \begin{pmatrix}
0.8 & 0 & 0 \\
0 & 1.25 & 0 \\
0 & 0 & 0.1
\end{pmatrix} \bm{V}^{\textsf{T}}$", (-1.1,1.62,0.5));

ship();

triple[] u;
u.push((-0.892477, 0.450240, -0.027731));
u.push((0.34926, 0.72859,  0.58921));
u.push((-0.28549, -0.51617, 0.80750));
draw((0,0,0)--0.5u[0], blue, Arrow3);
label("$\bm{v}_1$", 0.6*u[0], blue);
draw((0,0,0)--0.5u[1], blue, Arrow3);
label("$\bm{v}_2$", 0.6*u[1], blue);
draw((0,0,0)--0.5u[2], blue, Arrow3);
label("$\bm{v}_3$", 0.6*u[2], blue);

ship();

triple[] p;

for (int i=0; i<3; ++i) {
  p.push((rand(), rand(), rand())/randMax);
  p[i] = 2*p[i]-(1,1,1);
  dot(p[i], red+linewidth(3));
  label("$\bm{x}_" + string(i+1) + " = \begin{pmatrix}" + string(p[i].x,2) + "\\" 
	+ string(p[i].y,2) + "\\"  + string(p[i].z,2) + "\end{pmatrix}$",
	p[i], E, red);
  write(p[i]);
}

ship();

triple[] mp;
mp.push((0.68423, 0.10225, 0.35334));
mp.push((0.33193, 0.41519, 0.24853));
mp.push((-0.369720,  0.237988, -0.045673));

for (int i=0; i<3; ++i) {
  draw(0.95*p[i]+0.05*mp[i]--0.05*p[i]+0.95*mp[i], green, Arrow3);
  dot(mp[i], heavygreen+linewidth(3));
  label(Label("$\bm{M} \bm{x}_" + string(i+1) + "$", green, UnFill), 0.5*(p[i]+mp[i]));
}

ship();

draw(0.8*u[0]+0.8*u[1]--0.8*u[0]-0.8*u[1]--(-0.8*u[0]-0.8*u[1])--(-0.8*u[0]+0.8*u[1])--cycle);
label("$\bm{x}^{\textsf{T}} \, \bm{v}_3 = 0$", 0.8*u[0]+0.8*u[1], NW);

ship();

if(false) {
label("\begin{align*}
\bm{M}^{-1} &= \begin{pmatrix}
 1.9 &   1.17 &  -2.1 \\
 1.17 &   3.34 &  -3.8 \\
 -2.1 &  -3.8 &   6.8
\end{pmatrix} \\
&= \bm{V} \begin{pmatrix}
1.25 & 0 & 0 \\
0 & 0.8 & 0 \\
0 & 0 & 10
\end{pmatrix} \bm{V}^{\textsf{T}}
\end{align*}", (-1.3,1.3,0));
}

label("$\bm{M}^{-1} = \begin{pmatrix}
 1.9 &   1.17 &  -2.1 \\
 1.17 &   3.34 &  -3.8 \\
 -2.1 &  -3.8 &   6.8
\end{pmatrix}$", (-1.3,1.4,-0.1));

label("$= \bm{V} \begin{pmatrix}
1.25 & 0 & 0 \\
0 & 0.8 & 0 \\
0 & 0 & 10
\end{pmatrix} \bm{V}^{\textsf{T}}$", (-1.1,1.72,-0.5));

ship();
