// Animates the block multiplication on the "Matrix Decomposition" slides:
//   B = W D W^T  with  W = [[U, U, 0], [V, -V, V0]],  D = diag(S, -S, 0)
// Frame 0: B = W D W^T            (as svdContinued-1)
// Frame 1: B = (W D) W^T          W D = [[US, -US, 0], [VS, VS, 0]]
// Frame 2: B = (W D W^T)          = [[0, 2USV^T], [2VSU^T, 0]], the shape of B
// Frame 3: the same result moved next to the "=" to give the final equation
// In frames 0-2 each product appears where its right-hand factor was, so the
// remaining matrices never move.
settings.outformat="pdf";
import myutil;

size(0,105);        // fonts do not scale, so keep this modest

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
real gap = 1.5;

// B: the (n+m) x (n+m) symmetric matrix on the left-hand side
void lhs() {
  matRect((0,0), m, n, "\mat{X}^\tr", paleblue);
  matRect((n,0), m, m, "\mat{0}", palegray);
  matRect((0,m), n, n, "\mat{0}", palegray);
  matRect((n,m), n, m, "\mat{X}", pink);
  braces((0,0), n+m, n+m);
  label("$=$", (n+m+gap, 0.5*(n+m)));
}

// W: columns of width n, n, m-n; block rows of height n (top) and m
void matW(pair pos) {
  matRect(pos+(0,0), m,n, "\mat{V}", paleblue);
  matRect(pos+(0,m), n,n, "\mat{U}", pink);
  matRect(pos+(n,0), m,n, "-\mat{V}", paleblue);
  matRect(pos+(n,m), n,n, "\mat{U}", pink);
  matRect(pos+(2n,0), m,m-n, "\mat{V}_0", paleblue);
  matRect(pos+(2n,m), n,m-n, "\mat{0}", pink);
  braces(pos, n+m, n+m);
}

// D = diag(S, -S, 0): block rows and columns of size n, n, m-n
void matD(pair pos) {
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
}

// W^T: block rows of height n, n, m-n; columns of width n and m
void matWt(pair pos) {
  matRect(pos+(0,0), m-n,n, "\mat{0}", paleblue);
  matRect(pos+(0,m-n), n,n, "\mat{U}^\tr", pink);
  matRect(pos+(0,m), n,n, "\mat{U}^\tr", paleblue);
  matRect(pos+(n,0), m-n,m, "\mat{V}_0^\tr", pink);
  matRect(pos+(n,m-n), n,m, "-\mat{V}^\tr", paleblue);
  matRect(pos+(n,m), n,m, "\mat{V}^\tr", pink);
  braces(pos, n+m, n+m);
}

// W D: same block shape as W.  The -V block meets -S, giving +VS
void matWD(pair pos) {
  matRect(pos+(0,0), m,n, "\mat{V}\mat{S}", paleblue);
  matRect(pos+(0,m), n,n, "\mat{U}\mat{S}", pink);
  matRect(pos+(n,0), m,n, "\mat{V}\mat{S}", paleblue);
  matRect(pos+(n,m), n,n, "-\mat{U}\mat{S}", pink);
  matRect(pos+(2n,0), m,m-n, "\mat{0}", palegray);
  matRect(pos+(2n,m), n,m-n, "\mat{0}", palegray);
  braces(pos, n+m, n+m);
}

// W D W^T: same block shape as B, with X = 2 U S V^T
void matWDWt(pair pos) {
  matRect(pos+(0,0), m, n, "2\mat{V}\mat{S}\mat{U}^\tr", paleblue);
  matRect(pos+(n,0), m, m, "\mat{0}", palegray);
  matRect(pos+(0,m), n, n, "\mat{0}", palegray);
  matRect(pos+(n,m), n, m, "2\mat{U}\mat{S}\mat{V}^\tr", pink);
  braces(pos, n+m, n+m);
}

pair start = (n+m+2gap, 0);          // first matrix after the "="
pair step = (n+m+gap, 0);            // from one matrix to the next

// Every frame gets the bounding box of the widest one (frame 0), so the
// figure keeps the same scale as \multipdf steps through it.
void frame() {
  draw(box((-0.4,-0.2), start+3*step+(-gap+0.4, n+m+0.2)), invisible);
}

frame();
lhs();
matW(start);
matD(start+step);
matWt(start+2*step);
ship();

erase();
frame();
lhs();
matWD(start+step);
matWt(start+2*step);
ship();

erase();
frame();
lhs();
matWDWt(start+2*step);
ship();

erase();
frame();
lhs();
matWDWt(start);
ship();
