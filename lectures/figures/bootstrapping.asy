size(600,0);
import myutil;

int n = 6;

picture bg = new picture;

draw(bg, box((-0.5,-1.3), (2n+0.5, 1.3)), white);

string example(int i) {
  string idx = "{" + string(i+1) +"}";
  return "$(\bm{x}_"+idx+",\,y_"+idx+")$";
}

for(int i=0; i<n; ++i) {
  label(bg, example(i), (i,0));
}

add(bg);
ship();

srand(123);

for(int i=0; i<n; ++i) {
  erase();
  int r = floor(1.0*n*rand()/randMax);
  add(bg);
  label(example(r), (n+1+i, 1), blue);
  draw(circle((r,0), 0.45), blue);
  label(bg, example(r), (n+1+i, 1));
  ship();
}


for(int j=1; j>-3; --j) {
  erase();
  add(bg);
  for(int i=0; i<n; ++i) {
    int r = floor(1.0*n*rand()/randMax);
    label(example(r), (n+1+i, 0.5*j), blue);
    label(bg, example(r), (n+1+i, 0.5*j));
  }
  ship();
}
