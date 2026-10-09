import myutil;
size(100,0);
int nx = 50;
int ny = 70;


for(int i=1; i<ny; ++i) {
  draw((0,i)--(nx,i), lightgray);
}

for(int i=1; i<nx; ++i) {
  draw((i,0)--(i,ny), lightgray);
}

for(int i=10; i<ny; i+=10) {
  draw((0,i)--(nx,i));
}

for(int i=10; i<nx; i+=10) {
  draw((i,0)--(i,ny));
}

int k = 1;
for(int j=0; j<ny; j+=10) {
  for(int i=0; i<nx; i+=10) {
    label("$x_{"+string(k)+"}$", (i+5,j+5));
    ++k;
  }
}
draw(box((0,0), (nx,ny)), linewidth(1));
draw("$\Omega$", (nx-0.5,ny), N);

