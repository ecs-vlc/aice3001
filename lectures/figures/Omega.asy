import myutil;
size(100,0);
int nx = 5;
int ny = 7;
draw(box((0,0), (nx,ny)), linewidth(1));

for(int i=1; i<ny; ++i) {
  draw((0,i)--(nx,i));
}

for(int i=1; i<nx; ++i) {
  draw((i,0)--(i,ny));
}

draw("$\Omega$", (nx-0.5,ny), N);
picture bg = new picture;
add(bg, currentpicture);

draw("$\omega_i$", (3.5, 4.5));

ship();

erase();
add(bg);

filldraw((1,1)--(4,1)--(4,3)--(3,3)--(3,5)--(2,5)--(2,4)--(1,4)--cycle, green, darkgreen);
draw("$\mathcal{E}$", (2.5, 2));

ship();
