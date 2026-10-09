import myutil;
size(600,0);

srand(1);

draw(box((-5,0), (55, 15)), white);

pair randPair() {
  return 15.0*(rand(), rand())/randMax;
}

real dist(pair a, pair b) {
  return sqrt((a.x-b.x)**2 + (a.y-b.y)**2);
}

pair[] positions(int n, pair offset = (0,0)) {
  pair[] x = new pair[n];
  for(int i=0; i<n; ++i) {
    bool tooClose;
    do {
      tooClose = false;
      x[i] = randPair() + offset;
      for(int j=0; j<i; ++j) {
	if (dist(x[i], x[j])<5)
	  tooClose =true; 
      }
    } while (tooClose);
  }
  return x;
}

int n = 5;
real radius = 1;

pair[] x = positions(n);
pair[] y = positions(n, (30,0));

for(int i=0; i<n; ++i) {
  draw(circle(x[i], radius));
  label("$x_{" + string(i) + "}$", x[i]);
  draw(circle(y[i], radius));
  label("$y_{" + string(i) + "}$", y[i]);
}

ship();

picture bg = new picture;
bg.add(currentpicture);

path outSideCircle(pair a, pair b, real r) {
  return a + r*unit(b-a) -- b + r*unit(a-b);
}

string makeVar(int i, bool group) {
  string t = (group)? "x" : "y";
  return t + "_{" + string(i) + "} - \mu^{" + t + "}_{" + string(i) + "}";
}

void showCovariance(int i, int j, bool group1, bool group2) {
  pair p1 = (group1)? x[i] : y[i];
  pair p2 = (group2)? x[j] : y[j];
  string v1 = makeVar(i, group1);
  string v2 = makeVar(j, group2);
  string Cov;
  pen col;
  if (group1) {
    if (group2) {
      Cov = "A";
      col = red;
    } else {
      Cov = "B";
      col = blue;
    }
  } else {
    if (group1) {
      Cov = "B";
      col = blue;
    } else {
      Cov = "C";
      col = heavygreen;
    }
  }
  string cov = "\small$\scriptstyle\mathbb{E}\!\left(\strut("+v1+")\,("+v2 + ")\right) =";
  cov += Cov + "_{" + string(i) + "," + string(j) + "}$";
  draw(outSideCircle(p1, p2, radius), col);

  label(cov, 0.5*(p1+p2), col, UnFill);
}

void drawPairs(pair[] x, pair[] y, pen col, string name) {
  pair meanPos = (0,0);
  int cnt = 0;
  for(int i=0; i<x.length; ++i) {
    for(int j=0; j<y.length; ++j) {
      if (x[i]==x[j])
	continue;
      draw(outSideCircle(x[i], y[j], radius), col);
      meanPos += x[i] + y[j];
      cnt += 2;
    }
  }
  label(name, meanPos/cnt, col, UnFill);
}

showCovariance(1,2,true,true);

ship();
erase();
add(bg);
showCovariance(2,4,false,false);
ship();
erase();
add(bg);
showCovariance(4,1,true,false);
ship();

erase();
add(bg);

drawPairs(x, x, red+dashed, "$\Large\mat{A}$");
drawPairs(x, y, blue+dotted, "$\Large\mat{B}$");
drawPairs(y, y, heavygreen+dashed, "$\Large\mat{C}$");
ship();
