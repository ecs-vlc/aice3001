size(400,0);
import myutil;

real urand() {return 2.0*(rand()/randMax)-1;}
real bound(real x) {
  if (x<0)
    return 0.05;
  if (x>1)
    return 0.95;
  return x;
}
      
pair genPoints(pair centre, real r=0.2) {
  return (bound(centre.x+r*urand()), bound(centre.y+r*urand()));
}


pair[] posCentres = {(0.1,0.2), (0.7,0.5),(0.1,0.4)};
pair[] posData;
for(int i=0; i<posCentres.length; ++i) {
  for(int j=0; j<10; ++j) {
    posData.push(genPoints(posCentres[i],0.14));
  }
}

pair[] frogCentres = {(0.91,0.27)};
pair[] frogData;
for(int i=0; i<frogCentres.length; ++i) {
  for(int j=0; j<20; ++j) {
    frogData.push(genPoints(frogCentres[i],0.14));
  }
}

pair[] negCentres = {(0.63,0.2), (0.7,0.8), (0.3, 0.8)};
pair[] negData;
for(int i=0; i<negCentres.length; ++i) {
  for(int j=0; j<12; ++j) {
    negData.push(genPoints(negCentres[i]));
  }
}

void drawPos(pair p) {
  dot(p, linewidth(5)+red);
}

void drawNeg(pair p) {
  label("$\bm{\times}$", p, heavygreen);
}

void drawFrog(pair p) {
  label("\small $\bm{\bigtriangleup}$", p, blue);
}

void drawData() {
  draw(box((0,0), (1,1)));
  label("$x$", (0.5,0), S);
  label("$y$", (0, 0.5), W);
  for(int i=0; i<posData.length; ++i) {
    drawPos(posData[i]);
  }
  for(int i=0; i<frogData.length; ++i) {
    drawFrog(frogData[i]);
  }
  for(int i=0; i<negData.length; ++i) {
    drawNeg(negData[i]);
  }
}

void drawfork(string s, pair p, real d) {
  draw(p+(-d,-0.2)--p+(-d,0)--p+(d,0)--p+(d,-0.2));
  label("\small yes",p+(-d,-0.1),W);
  label("\small no",p+(d,-0.1),E);
  label(s, p, UnFill);
}

draw(box((0,0),(2,1)), white);
label("$0$", (0,0), SW);
label("$1$", (1,0), S);
label("$1$", (0,1), W);
drawData();
ship();
draw((0,0.6)--(1,0.6));
drawfork("$y>0.6$", (1.5,0.9), 0.2);
ship();

draw((0.35,0)--(0.35,0.6));
drawfork("$x>0.35$", (1.7,0.7), 0.2);
ship();

draw((0.35,0.4)--(1,0.4));
drawfork("$y>0.4$", (1.5,0.5), 0.2);
ship();

draw((0.8,0)--(0.8,0.4));
drawfork("$x>0.8$", (1.7,0.3), 0.2);
ship();

drawNeg((1.3,0.67));
drawPos((1.9,0.47));
drawPos((1.3,0.27));
drawFrog((1.5,0.07));
drawNeg((1.9,0.07));
ship();
