settings.outformat="pdf";
import myutil;

size(150,0);


void matRect(pair pos, int row, int col, string str,
	 pen colour=gray) {
  filldraw(box(pos, pos+(col,row)), colour, white);
  label("$"+str+"$", pos+0.5*(col,row));
}

void braces(pair pos, int row, int col) {
  draw(pos+(-0.1,-0.1)..pos+(-0.3, 0.5*row)..pos+(-0.1,row+0.1));
  pos += (col,0);
  draw(pos+(0.1,-0.1)..pos+(0.3, 0.5*row)..pos+(0.1,row+0.1));
}

int m = 6;
int n = 4;
dot(n+m+6.5, white);

matRect((0,0), m, n, "\mat{X}^\tr", paleblue);
matRect((n,0), m, m, "\mat{0}", white);
matRect((0,m), n, n, "\mat{0}", white);
matRect((n,m), n, m, "\mat{X}", pink);
braces((0,0), n+m, n+m);
ship();

pair pos = n+m+1;

matRect(pos, m, 1, "\bm{v}", pink);
matRect(pos+(0,m), n, 1, "\bm{u}", paleblue);
braces(pos, n+m, 1);


label("$=$", (pos+(2,0.5*(n+m))));
label("$s$", (pos+(3,0.5*(n+m))));
pos +=(4,0);

matRect(pos, m, 1, "\bm{v}", pink);
matRect(pos+(0,m), n, 1, "\bm{u}", paleblue);
braces(pos, n+m, 1);
ship();
