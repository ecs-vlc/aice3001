import myutil;
size(100,0);
int nx = 7;
int ny = 5;
draw(box((0,0), (nx,ny)), linewidth(1));

for(int i=1; i<ny; ++i) {
  draw((0,i)--(nx,i));
}

for(int i=1; i<nx; ++i) {
  draw((i,0)--(i,ny));
}

draw("$\Omega$", (nx+0.5,ny-1), N);

picture bg = new picture;
add(bg, currentpicture);

draw("$\omega_i$", (3.5, 2.5));

ship();

erase();
add(bg);

filldraw((1,1)--(4,1)--(4,2)--(5,2)--(5,3)--(3,3)--(3,4)--(1,4)--cycle, green, darkgreen);
draw("$\mathcal{E}$", (2.5, 2));

ship();
erase();
add(bg);

filldraw(box((0,0), (nx,ny)), lightblue, black+linewidth(1));

filldraw((1,1)--(4,1)--(4,2)--(5,2)--(5,3)--(3,3)--(3,4)--(1,4)--cycle, green, darkgreen);
draw("$\mathcal{E}$", (2.5, 2));
draw("$\neg\mathcal{E}$", (6, 2.5));

ship();
