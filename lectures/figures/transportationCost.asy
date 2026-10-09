settings.outformat="pdf";
import myutil;
import palette;
size(300,0);

int n = 10;
int[][] gamma = array(n, array(n,0));
int[] p = array(n,0);
int[] q = array(n,0);

int ndev() {
  real r = 0;
  for (int i=0; i<3; ++i) {
    r += 10*(rand()/randMax)/3;
  }
  return floor(r);
}

pen[] col = Rainbow(n);
pen[] gpen = Grayscale(23);

for(int i=0; i<100; ++i) {
  int r1 = ndev();
  int r2 = ndev();
  ++p[r1];
  ++q[r2];
  ++gamma[r2][r1];
}

void show() {
  erase();
  for(int i=0; i<1n; ++i) {
    filldraw(box((i,n+1),(i+1, n+1+0.1*q[i])), gray(0.8));
    filldraw(box((-1, i),(-1-0.1*p[i],i+1)), col[i]);
    for(int j=0; j<n; ++j) {
      filldraw(box((i,j),(i+1,j+1)), gpen[22-gamma[i][j]]);
    }
  }

  label("$q(y)$", (0.5, n+3));
  label("$y$", (n,n+1), E);
  label(rotate(90)*Label("$p(x)$"), (-3.5,1));
  label(rotate(90)*Label("$x$"), (-1,n), N);

  picture bg = new picture;
  add(bg, currentpicture);


  real[] q1 = array(n,0);
  for(int i=0; i<n; ++i) {
    int p1 = 0;
    for(int j=0; j<n; ++j) {
      if (gamma[j][i]>0) {
	p1 += gamma[j][i];
	draw(bg,(-1-0.1*p1,i)--(-1-0.1*p1,i+1));
	real qn = q1[j]+0.1*gamma[j][i];
	filldraw(bg, box((j,n+1+q1[j]),(j+1,n+1+qn)), col[i]);
	q1[j] = qn;
      }
    }
  }

  erase();
  add(bg);
  ship();
}

void distance() {
  picture bg = new picture;
  add(bg, currentpicture);
  real cost=0;
  for(int i=0; i<1n; ++i) {
    for(int j=0; j<n; ++j) {
      int d = abs(i-j);
      filldraw(box((i,j),(i+1,j+1)), (d/6)*red+(1-d/6)*white);
      cost+=d*gamma[i][j]/100;
    }
  }
  ship();
  erase();
  add(bg);
  label("cost = " + string(cost,3), (5, 10.5));
  ship();
}

show();
distance();

int r10() {
  return floor(10.0*rand()/randMax);
}
    
for(int iter = 0; iter<10000; ++iter) {
  int i1 = r10();
  int i2 = r10();
  if (i1==i2)
    continue;
  if (i1<i2) {
    int s = i1;
    i1 = i2;
    i2 = s;
  }
  if (p[i1]==0 || p[i2]==0)
    continue;
  int j1=0;
  for(; j1<n; ++j1) {
    if(gamma[i1][j1]>0)
      break;
  }
  int j2=n-1;
  for(; j2>=0; --j2) {
    if(gamma[i2][j2]>0)
      break;
  }
  if(j2<=j1)
    continue;
  int m = min(gamma[i1][j1],gamma[i2][j2]);
  gamma[i1][j1] -= m;
  gamma[i2][j1] += m;
  gamma[i1][j2] += m;
  gamma[i2][j2] -= m;
}

show();
distance();
