size(400,0);
import myutil;

void drawBox(int x, int y, real off, string s="") {
  filldraw(box((off-0.5*x, -0.5*y), (off+0.5*x,0.5*y)), gray(0.8), white);
  draw((off-0.5*x, -0.5*y)..(off-0.5*x-0.6, 0)..(off-0.5*x, 0.5*y), linewidth(1));
  draw((off+0.5*x, -0.5*y)..(off+0.5*x+0.6, 0)..(off+0.5*x, 0.5*y), linewidth(1));
  if (length(s)>0)
    label(s, (off,10));
}

void diagBox(int x, int y, real off, string s="") {
  filldraw(box((off-0.5*x, -0.5*y), (off+0.5*x,0.5*y)), gray(0.8), white);
  draw((off-0.5*x, -0.5*y)..(off-0.5*x-0.6, 0)..(off-0.5*x, 0.5*y), linewidth(1));
  draw((off+0.5*x, -0.5*y)..(off+0.5*x+0.6, 0)..(off+0.5*x, 0.5*y), linewidth(1));
  if (x>y) {
    draw((off-0.5*x+1, 0.5*y-1)--(off-0.5*x+y-1, -0.5*y+1), linewidth(3)+blue);
    label("0", (off+0.5*(y-x),0), NE);
    label("0", (off+0.5*(y-x),0), SW);
  } else {
    draw((off-0.5*x+1, 0.5*y-1)--(off+0.5*x-1, 0.5*y-x+1), linewidth(3)+blue);
    label("0", (off, 0.5*(y-x)), NE);
    label("0", (off, 0.5*(y-x)), SW);
  }
    if (length(s)>0)
    label(s, (off,10));
    
}

int n = 10;
int m = 15;
drawBox(m, n, -0.5*(n+m)-8, "$\mat{X}$");
label("$=$", (-0.5*n-4,0));
label("$=$", (-0.5*n-4,10));
drawBox(n, n, 0, "$\mat{U}$");
diagBox(m, n, 0.5*(n+m)+4, "$\mat{S}$");
drawBox(m, m, 0.5*(n+m)+m+8, "$\mat{V}^\tr$");

n = 15;
m = 10;
int off = 100;
drawBox(m, n, off-0.5*(n+m)-8, "$\mat{X}$");
label("$=$", (off-0.5*n-4,0));
label("$=$", (off-0.5*n-4,10));
drawBox(n, n, off, "$\mat{U}$");
diagBox(m, n, off+0.5*(n+m)+4, "$\mat{S}$");
drawBox(m, m, off+0.5*(n+m)+m+8, "$\mat{V}^\tr$");

shipout("svdNonSquare");

erase();
int n = 10;
int m = 15;
drawBox(m, n, -0.5*(n+m)-8, "$\mat{X}$");
label("$=$", (-0.5*n-4,0));
label("$=$", (-0.5*n-4,10));
drawBox(n, n, 0, "$\mat{U}$");
diagBox(m, n, 0.5*(n+m)+4, "$\mat{S}$");
drawBox(m, m, 0.5*(n+m)+m+8, "$\mat{V}^\tr$");

int off = 100;
drawBox(m, n, off-0.5*(n+m)-8, "$\mat{X}$");
label("$=$", (off-0.5*n-4,0));
label("$=$", (off-0.5*n-4,10));
drawBox(n, n, off, "$\mat{U}$");
diagBox(n, n, off+0.5*(n+n)+4, "$\mat{S}$");
drawBox(m, n, off+0.5*(n+m)+n+8, "$\mat{V}^\tr$");

shipout("twoForms1");
erase();
int n = 15;
int m = 10;
drawBox(m, n, -0.5*(n+m)-8, "$\mat{X}$");
label("$=$", (-0.5*n-4,0));
label("$=$", (-0.5*n-4,10));
drawBox(n, n, 0, "$\mat{U}$");
diagBox(m, n, 0.5*(n+m)+4, "$\mat{S}$");
drawBox(m, m, 0.5*(n+m)+m+8, "$\mat{V}^\tr$");

int off = 100;
drawBox(m, n, off-0.5*(n+m)-8, "$\mat{X}$");
label("$=$", (off-0.5*n-4,0));
label("$=$", (off-0.5*n-4,10));
drawBox(m, n, off, "$\mat{U}$");
diagBox(m, m, off+0.5*(m+m)+4, "$\mat{S}$");
drawBox(m, m, off+0.5*(m+m)+m+8, "$\mat{V}^\tr$");

shipout("twoForms2");
