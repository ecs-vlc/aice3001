settings.outformat="pdf";
import myutil;

size(0,100);


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

matRect((0,0), m, n, "\mat{X}^\tr", paleblue);
matRect((n,0), m, m, "\mat{0}", palegray);
matRect((0,m), n, n, "\mat{0}", palegray);
matRect((n,m), n, m, "\mat{X}", pink);
braces((0,0), n+m, n+m);

pair pos = (n+m+1.5,0);

matRect(pos+(0,0), m,n, "\mat{V}", paleblue);
matRect(pos+(0,m), n,n, "\mat{U}", pink);
matRect(pos+(n,0), m,n, "-\mat{V}", paleblue);
matRect(pos+(n,m), n,n, "\mat{U}", pink);
matRect(pos+(2n,0), m,m-n, "\mat{V}_0", paleblue);
matRect(pos+(2n,m), n,m-n, "\mat{0}", pink);
braces(pos, n+m, n+m);

pos += (n+m+1.5,0);
label("$=$" ,pos+(0,0.5*(n+m)));

pos += (1.5,0);

matRect(pos+(0,0), m,n, "\mat{V}", paleblue);
matRect(pos+(0,m), n,n, "\mat{U}", pink);
matRect(pos+(n,0), m,n, "-\mat{V}", paleblue);
matRect(pos+(n,m), n,n, "\mat{U}", pink);
matRect(pos+(2n,0), m,m-n, "\mat{V}_0", paleblue);
matRect(pos+(2n,m), n,m-n, "\mat{0}", pink);
braces(pos, n+m, n+m);


pos += (n+m+1.5,0);

matRect(pos+(0,0), m-n,n, "\mat{0}", palegray);
matRect(pos+(0,m-n), n,n, "\mat{0}", palegray);
matRect(pos+(0,m), n,n, "\mat{S}", green);
matRect(pos+(n,0), m-n,n, "\mat{0}", palegray);
matRect(pos+(n,m-n), n,n, "-\mat{S}", green);
matRect(pos+(n,m), n,n, "\mat{0}", palegray);
matRect(pos+(2n,0), m-n,m-n, "\mat{0}", yellow);
matRect(pos+(2n,m-n), n,m-n, "\mat{0}", palegray);
matRect(pos+(2n,m), n,m-n, "\mat{0}", palegray);
braces(pos, n+m, n+m);

ship();

erase();

matRect((0,0), m, n, "\mat{X}^\tr", paleblue);
matRect((n,0), m, m, "\mat{0}", palegray);
matRect((0,m), n, n, "\mat{0}", palegray);
matRect((n,m), n, m, "\mat{X}", pink);
braces((0,0), n+m, n+m);

pair pos = (n+m+1.5,0);
label("$=$" ,pos+(0,0.5*(n+m)));

pos += (1.5,0);


matRect(pos+(0,0), m,n, "\mat{V}", paleblue);
matRect(pos+(0,m), n,n, "\mat{U}", pink);
matRect(pos+(n,0), m,n, "-\mat{V}", paleblue);
matRect(pos+(n,m), n,n, "\mat{U}", pink);
matRect(pos+(2n,0), m,m-n, "\mat{V}_0", paleblue);
matRect(pos+(2n,m), n,m-n, "\mat{0}", pink);
braces(pos, n+m, n+m);



pos += (n+m+1.5,0);

matRect(pos+(0,0), m-n,n, "\mat{0}", palegray);
matRect(pos+(0,m-n), n,n, "\mat{0}", palegray);
matRect(pos+(0,m), n,n, "\mat{S}", green);
matRect(pos+(n,0), m-n,n, "\mat{0}", palegray);
matRect(pos+(n,m-n), n,n, "-\mat{S}", green);
matRect(pos+(n,m), n,n, "\mat{0}", palegray);
matRect(pos+(2n,0), m-n,m-n, "\mat{0}", yellow);
matRect(pos+(2n,m-n), n,m-n, "\mat{0}", palegray);
matRect(pos+(2n,m), n,m-n, "\mat{0}", palegray);
braces(pos, n+m, n+m);

pos += (n+m+1.5,0);

matRect(pos+(0,0), m-n,n, "\mat{0}", paleblue);
matRect(pos+(0,m-n), n,n, "\mat{U}^\tr", pink);
matRect(pos+(0,m), n,n, "\mat{U}^\tr", paleblue);
matRect(pos+(n,0), m-n,m, "\mat{V}_0^\tr", pink);
matRect(pos+(n,m-n), n,m, "-\mat{V}^\tr", paleblue);
matRect(pos+(n,m), n,m, "\mat{V}^\tr", pink);
braces(pos, n+m, n+m);

ship();

erase();

