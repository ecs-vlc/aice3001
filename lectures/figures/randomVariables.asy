import myutil;
size(100,0);
int nx = 5;
int ny = 7;
draw(box((0,0), (nx,ny)), linewidth(1));

for(int i=1; i<ny; ++i) {
  draw((0,i)--(nx,i), gray);
}

for(int i=1; i<nx; ++i) {
  draw((i,0)--(i,ny), gray);
}

draw("$\Omega$", (nx-0.5,ny), N);
picture bg = new picture;
add(bg, currentpicture);

draw("$\omega_i$", (3.5, 4.5));

erase();

filldraw((1,1)--(4,1)--(4,3)--(3,3)--(3,5)--(2,5)--(2,4)--(1,4)--cycle, green, darkgreen);
draw("$x_3$", (2.5, 2.5));
filldraw((0,3)--(0,0)--(3,0)--(3,1)--(1,1)--(1,3)--cycle, lightblue);
draw("$x_2$", (0.5, 0.5));
filldraw((0,3)--(0,7)--(3,7)--(3,6)--(2,6)--(2,4)--(1,4)--(1,3)--cycle, pink);
draw("$x_1$", (1.5,5.5));
filldraw((2,5)--(2,6)--(3,6)--(3,7)--(5,7)--(5,5)--(4,5)--(4,4)--(3,4)--(3,5)--cycle, orange);
draw("$x_4$", (3.5,5.5));
filldraw((3,0)--(3,1)--(4,1)--(4,3)--(3,3)--(3,4)--(4,4)--(4,5)--(5,5)--(5,0)--cycle, yellow);
draw("$x_5$", (4.5,3.5));

add(bg);

