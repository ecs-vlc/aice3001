settings.outformat="pdf";
import myutil;
import palette;
size(27cm,0);
int n =256;
real[][] ls=new real[n][n];

pen[] Palette=Grayscale();

path bb = box((-1.3,-1.2),(12,4.25));
draw(bb, white);

for(int i=0; i<n; ++i) {
  for(int j=0; j<n; ++j) {
    ls[i][j] = 1-exp(-0.0004*((i-128)*(i-128)+(j-128)*(j-128)));
  }
}

image(ls,(-1,-1),(1,1),Palette);
draw((-1,0)--(1,0), red, Arrow);
draw((0,-1)--(0,1), red, Arrow);
draw(sqrt(0.5)*(1,1)--sqrt(0.5)*(-1,-1), red, Arrow);
label("$z_1$", (0,1), N, red);
label("$z_2$", (1,0), E, red);
label("$z_3$", -(0.8,0.8), red);

path im = box((-1,-1), (1,1));

for(int i=0; i<10; ++i) {
  filldraw(shift(0.05*(i-5),3+0.05*(i-5))*im, white);
}
label("\Huge $\mathcal{D}$", (0.25,3.25));

path network = (0,-1.2)--(0,1.2)--(2,0.8)--(2,-0.8)--cycle;
path network2 = (0,-0.8)--(0,0.8)--(2,1.2)--(2,-1.2)--cycle;


draw(shift(2.2,0)*network2, linewidth(2));
label("\Huge $G(\bm{z}, \bm{w}_G)$", (3.2,0));

draw(shift(9,1.5)*network, linewidth(2));
draw((11,1.5)--(11.5,1.5), Arrow(10));
label("\Huge $D(\bm{x}, \bm{w}_D)$", (10,1.5));

picture bg=new picture;
add(bg, currentpicture);

real ndev() {
  return (rand()/randMax + rand()/randMax + rand()/randMax)/1.5-1;
}

void gen(int i) {
  erase();
  add(bg);
  dot((ndev(), ndev()), blue+linewidth(5));
  label(graphic("cifar/cifar" + string(i) + ".eps", "width=4.7cm"), (6.125,-0.07));
  layer();
  draw(shift(6.2,0)*im, linewidth(1.5));
  draw((4.3,0)--(5.1,0), linewidth(4)+blue, Arrow(25));
  draw((1.3,0)--(2.1,0), linewidth(4)+blue, Arrow(25));
  draw((7.3,0)--(8,0)--(8,1.5)--(8.9,1.5), linewidth(4)+blue, Arrow(25));
  label("\huge 0", (11.5,1.5), E);
  ship();
}

void data(int i) {
  erase();
  add(bg);
  label(graphic("cifar/cifar" + string(i) + ".eps", "width=4.7cm"), (6.125,3-0.07));
  layer();
  draw(shift(6.2,3)*im,linewidth(1.5));
  draw((1.3,3)--(5.1,3), linewidth(4)+blue, Arrow(25));
  label("\huge sample from $\mathcal{D}$", (3.1,3), N, blue);
  draw((7.3,3)--(8,3)--(8,1.5)--(8.9,1.5), linewidth(4)+blue, Arrow(25));
  label("\huge 1", (11.5,1.5), E);
  ship();
}


for(int i=0; i<10; ++i) {
  if(rand() < 0.5*randMax) {
    gen(i);
  } else {
    data(i);
  }
}




