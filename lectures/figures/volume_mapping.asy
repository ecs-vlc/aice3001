import myutil;
size(500,0);

void draw_axes(pair pos, string s) {
  draw(pos-(0,1)--pos+(0,1), Arrows);
  draw(pos-(1,0)--pos+(1,0), Arrows);
  label("$"+s+"_1$", pos+(1,0), E);
  label("$"+s+"_2$", pos+(0,1), N);
}


void label_vertex(string l, pair A, pair B, pair C, pair pos, pen col) {
  label(l, pos + A + 0.1*unit(2*A-B-C), col);
}

void draw_triangle(pair A, pair B, pair C, pair pos, string V) {
  filldraw(shift(pos)*(A--B--C--cycle), paleblue, blue);
  label_vertex("$A$", A, B, C, pos, blue);
  label_vertex("$B$", B, A, C, pos, blue);
  label_vertex("$C$", C, B, A, pos, blue);
  label(V, pos+(A+B+C)/3.0);
}



pair transform_pair(pair A, real[][] M) {
  return (M[0][0]*A.x+M[0][1]*A.y, M[1][0]*A.x+M[1][1]*A.y);
}

pair A = (0.2, 0.1);
pair B = (0.4, 0.6);
pair C = (0.5, -0.2);

draw_axes((0,0), "x");
draw_triangle(A, B, C, (0,0), "$V$");

real [][] M = {{1.2,0.8},{0.5,-1.4}};
pair Ap = transform_pair(A, M);
pair Bp = transform_pair(B, M);
pair Cp = transform_pair(C, M);

draw_axes((4,0), "x'");
draw_triangle(Ap, Bp, Cp, (4,0), "$V'$");

draw((1,0.5)--(3,0.5), linewidth(3)+red, Arrow(10));

string mat2str(real[][] M) {
  string v = "\begin{pmatrix}";
  v += string(M[0][0], 2) + "&";
  v += string(M[0][1], 2) + "\\";
  v += string(M[1][0], 2) + "&";
  v += string(M[1][1], 2) + "\end{pmatrix}";
  return v;
}

string mapping = "$\begin{pmatrix}x'_1\\ x'_2\end{pmatrix} = ";
mapping += mat2str(M);
mapping +="\begin{pmatrix}x_1\\ x_2\end{pmatrix}$";

label(mapping, (2,0.55), N, red);
