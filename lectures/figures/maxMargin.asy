size(300,0);
import myutil;

pair w = unit((1,2));
real b = 1.5;
real m = 0.3;
pair A = (0,0);
pair B = (3,2);
path bb = box(A,B);
draw(bb,white);

real udev() {return rand()/randMax;}
pair randPair() {return (B.x*udev(), B.y*udev());}
pair[] posPos;
pair[] negPos;

for(int i=0; i<30; ++i) {
  pair p = randPair();
  real x = dot(p,w)-b;
  if(x>m) {
    dot(p, red+linewidth(5));
    posPos.push(p);
  }
  if(x<-m) {
    label("$\bm{\times}$", p, blue+linewidth(5));
    negPos.push(p);
  }
}

pair sv1 = (b+m)*w + 1.6*(w.y,-w.x);
pair sv2 = (b+m)*w - 0.2*(w.y,-w.x);
pair sv3 = (b-m)*w + 0.2*(w.y,-w.x);

dot(sv1, red+linewidth(5));
dot(sv2, red+linewidth(5));
label("$\bm{\times}$", sv3, blue+linewidth(5));
posPos.push(sv1);
posPos.push(sv2);
negPos.push(sv3);

ship();

picture data = new picture;
add(data, currentpicture);

draw((0.1,B.y)--(2.3,0));

ship();

erase();
add(data);

draw((0,1.6)--(B.x,0.2));

ship();

erase();
add(data);

draw((0,1.4)--(B.x,0.7));

ship();

erase();
add(data);

draw((0,1.2)--(B.x,0.6));

ship();
erase();

add(data);

pair wp = (w.y,-w.x);
pair sp1 = b*w + 2.6*wp;
pair sp2 = b*w - 0.75wp;
draw(sp1--sp2);
pair m11 = (b+m)*w+ 2.4*wp;
pair m12 = (b+m)*w- 0.78*wp;
draw(m11--m12, dashed);
pair m21 = (b-m)*w+ 2.4*wp;
pair m22 = (b-m)*w- 0.6*wp;
draw(m21--m22, dashed);
draw(b*w--(b+m)*w, Arrows);
draw(b*w--(b-m)*w, Arrows);
label("$\Delta$", (b+0.5*m)*w, E);
label("$\Delta$", (b-0.5*m)*w, E);

ship();

picture fg = new picture;
add(fg, currentpicture);

label("support vector", sv1, W, red);
label("support vector", sv2, E, red);
label("support vector", sv3, E, blue);

ship();

erase();

for(int i=0; i<posPos.length; ++i) {
  filldraw(circle(posPos[i], m), palered, palered);
}


for(int i=0; i<negPos.length; ++i) {
  filldraw(circle(negPos[i], m), paleblue, paleblue);
}

add(fg);

clip(bb);

ship();

erase();

add(fg);

ship();
