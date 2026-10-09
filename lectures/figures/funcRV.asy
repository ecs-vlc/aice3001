import myutil;
size(300,0);
int nx = 80;
int ny = 40;


for(int i=1; i<ny; ++i) {
  draw((0,i)--(nx,i), lightgray);
}

for(int i=1; i<nx; ++i) {
  draw((i,0)--(i,ny), lightgray);
}

for(int i=10; i<ny; i+=10) {
  draw((0,i)--(nx,i));
}

for(int i=20; i<nx; i+=20) {
  draw((i,0)--(i,ny));
}

draw(box((0,0), (nx,ny)), linewidth(1));
draw("$\Omega$", (nx-0.5,ny), N);

picture basepic;
add(basepic,currentpicture);

int k = 1;
for(int j=0; j<ny; j+=10) {
  for(int i=0; i<nx; i+=20) {
    label("$x_{"+string(k)+"}$", (i+10,j+5));
    ++k;
  }
}

ship();

erase();
add(basepic);

int k = 1;
for(int j=0; j<ny; j+=10) {
  for(int i=0; i<nx; i+=20) {
    label("$y_{"+string(k)+"}=g(x_{"+string(k)+"})$", (i+10,j+5));
    ++k;
  }
}

draw("$Y=g(X)$", (0.5*nx,ny), N);

ship();

