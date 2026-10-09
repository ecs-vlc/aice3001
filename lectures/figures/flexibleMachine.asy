settings.outformat="pdf";
import myutil;
size(600,0);

int n = 3;
int N = 2^n;

draw(box((-3,0.5), (10, -N+0.5)), white);

string tobinary(int x) {
  string s = "";
  for(int i=0; i<n; ++i) {
    if(x%2==1)
      s += "1\,";
    else
      s += "0\,";
    x = floor(x/2);
  }
  return s;
}
		
for(int i=0; i<N; ++i) {
  label("$\bm{x}_{" + string(i) + "} = " + tobinary(i) + "$", (0, -i), W);
  label("$y_{" + string(i) + "} = \left\{ \begin{array}{c} 0 \\ 1\end{array}\right.$", (0, -i), E);
}

ship();

bool[] isTraining = new bool[N];
string s = "$\mathcal{D}=\left\{\strut";
bool first = true;
for(int i=0; i<N; ++i) {
  isTraining[i] = false;
  if (rand()<0.3*randMax) {
    isTraining[i] = true;
    if (!first) {
      s+= ",\, ";
    }
    first = false;
    string y;
    if (rand()<0.5*randMax) {
      y = "0";
      label("\large $\times$", (1.02, -i-0.14), blue);
    } else {
      y = "1";
      label("\large $\times$", (1.02, -i+0.19), blue);
    }
    s += "(" + tobinary(i) + ",\," + y + ")";
  }
}

s += "\right\}$";
label(s, (3,-2.5), E);

ship();

picture bg = new picture;
add(bg, currentpicture);

void unseen(int i) {
  draw(box((-1.8,-i-0.5), (1.5,-i+0.5)), red);
  if (isTraining[i])
    label("seen", (1.5,-i), E, red);
  else
    label("unseen", (1.5,-i), E, red);
}

int[] a = {1,7,4};

for(int i; i<a.length; ++i) {
  erase();
  add(bg);
  unseen(a[i]);
  ship();
}
