settings.outformat="pdf";
size(600,0);
usepackage("amsmath");
texpreamble("\DeclareMathAlphabet{\mat}{OT1}{cmss}{bx}{n}");
int picno = 1;
void out() {
  string fn = "matrixPicture" + string(picno);
  ++ picno;
  shipout(fn);
}


pair[] p;
p.push((0.1,0.2));
p.push((0.3,0.7));
p.push((0.6,0.6));

draw((-2.5,0)--(2.5,0), Arrow);
label("$x_1$", (2.5,0), E);
draw((0,-1.1)--(0,1.5), Arrow);
label("$x_2$", (0,1.5), N);

string matrix(real a, real b, real c, real d) {
  string str = "\begin{pmatrix} ";
  str += string(a,2) + " &";
  str += string(b,2) + " \\";
  str += string(c,2) + " &";
  str += string(d,2) + " \end{pmatrix}";
  return str;
}

// matches Asymptote's rotate(theta), which turns anticlockwise
string orthmatrix(real theta) {
  string t = string(floor(theta)) + "^\circ";
  string str = "\begin{pmatrix} ";
  str += "\cos(" + t + ") &";
  str += "-\sin(" + t + ") \\";
  str += "\sin(" + t + ") &";
  str += "\cos(" + t + ")  \end{pmatrix}";
  return str;
}


real theta1 = 75;
real theta2 = -175;
real l1 = 2;
real l2 = 0.75;

transform t = rotate(theta2)*scale(l1,l2)*rotate(theta1);
write(rotate(theta2)*scale(l1,l2)*rotate(theta1));
label("$\mat{M} = " + matrix(t.xx, t.xy, t.yx, t.yy) +
      "=" + "\mat{U}\,  \mat{S} \, \mat{V}^\mathsf{T} = " 
      + orthmatrix(theta2) + matrix(l1,0,0,l2) + orthmatrix(theta1) +
      "$", (0,1.9));

picture axes;
add(axes, currentpicture);

filldraw(p[0]--p[1]--p[2]--cycle, lightblue, heavyblue);
draw((-1,0)--(-1,-0.1));
draw((1,0)--(1,-0.1));
draw((0,-1)--(-0.1,-1));
draw((0,1)--(-0.1,1));

out();

filldraw(p[0]--p[1]--p[2]--cycle, paleblue, lightblue+dashed);

filldraw(rotate(theta1)*(p[0]--p[1]--p[2]--cycle), lightblue, heavyblue);
draw(arc((0,0), 1.5,60,60+theta1), Arrow);
out();

erase();
add(axes);
filldraw(p[0]--p[1]--p[2]--cycle, paleblue, lightblue+dashed);
filldraw(rotate(theta1)*(p[0]--p[1]--p[2]--cycle), paleblue, lightblue+dashed);

filldraw(scale(l1,1)*rotate(theta1)*(p[0]--p[1]--p[2]--cycle), lightblue, heavyblue);
draw(scale(l1,1)*((-1,0)--(-1,-0.1)));
draw(scale(l1,1)*((1,0)--(1,-0.1)));
draw((0,-1)--(-0.1,-1));
draw((0,1)--(-0.1,1));

out();

erase();
add(axes);
filldraw(p[0]--p[1]--p[2]--cycle, paleblue, lightblue+dashed);
filldraw(rotate(theta1)*(p[0]--p[1]--p[2]--cycle), paleblue, lightblue+dashed);
filldraw(scale(l1,1)*rotate(theta1)*(p[0]--p[1]--p[2]--cycle), paleblue, lightblue+dashed);

filldraw(scale(l1,l2)*rotate(theta1)*(p[0]--p[1]--p[2]--cycle), lightblue, heavyblue);
draw(scale(l1,1)*((-1,0)--(-1,-0.1)));
draw(scale(l1,1)*((1,0)--(1,-0.1)));
draw(scale(1,l2)*((0,-1)--(-0.1,-1)));
draw(scale(1,l2)*((0,1)--(-0.1,1)));

out();

erase();
add(axes);
filldraw(p[0]--p[1]--p[2]--cycle, paleblue, lightblue+dashed);
filldraw(rotate(theta1)*(p[0]--p[1]--p[2]--cycle), paleblue, lightblue+dashed);
filldraw(scale(1,l2)*rotate(theta1)*(p[0]--p[1]--p[2]--cycle), paleblue, lightblue+dashed);
filldraw(scale(l1,l2)*rotate(theta1)*(p[0]--p[1]--p[2]--cycle), paleblue, lightblue+dashed);
filldraw(rotate(theta2)*scale(l1,l2)*rotate(theta1)*(p[0]--p[1]--p[2]--cycle), lightblue, heavyblue);
draw(scale(l1,1)*((-1,0)--(-1,-0.1)));
draw(scale(l1,1)*((1,0)--(1,-0.1)));
draw(scale(1,l2)*((0,-1)--(-0.1,-1)));
draw(scale(1,l2)*((0,1)--(-0.1,1)));
draw(arc((0,0), 1.5,60+theta1,60+theta1+theta2), Arrow);

out();
