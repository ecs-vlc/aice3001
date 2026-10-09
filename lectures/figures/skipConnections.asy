settings.outformat="pdf";
import myutil;

size(400,0);

pair ll = (-5.1,-5.1);
pair ur = (19.1, 11.1);
path bb = box(ll, ur);
draw(bb, white);



void featureMaps(pair pos, int noFM) {
  for(int i=0; i<noFM; ++i) {
    draw(shift(pos)*((0.5*i+0.5, -5+1)--(0.5*i, -5)--(0.5*i,5)--(0.5*i+2,8)--(0.5*i+2,7.3)));
  }
  int i = noFM-1;
  draw(shift(pos)*((0.5*i, -5)--(0.5*i+2,-1)--((0.5*i+2,8))));
}

featureMaps((-5,0), 11);

ship();

label(rotate(-90)*Label("Filter"), (6,2));
label(rotate(-90)*Label("ReLU"), (7.2,2));
draw((5, -1)--(5,5)--(8.2,3)--(8.2,1)--cycle);


featureMaps((12,0),1);

ship();

picture bg = new picture;
add(bg, currentpicture);

pair delta = (0.7,1);
pair a = (0,5);
pair b = (0,3);
pair c = (5,3);
pair d = (5,5);
pair e = a + delta;
pair f = d + delta;
pair g = c + delta;
path filter = a--b--c--d--a--e--f--g--c--d--f;

pair A = (0,0);
pair B = (0,-0.5);
pair C = B + 0.3*delta;
pair D = 0.3*delta;
path value = A--B--C--D--cycle;


for(int i=0; i<2; ++i) {
  for(int j=0; j<7; ++j) {
    erase();
    add(bg);
    pair pos = (-5,-i)+0.3*j*delta;
    draw(shift(pos)*filter, linewidth(1)+red);
    pair pos1 = (12.25,4.5-i)+0.3*j*delta;
    filldraw(shift(pos1)*value, red);
    draw(pos+d--pos1+A, dotted+red);
    draw(pos+c--pos1+B, dotted+red);
    draw(pos+g--pos1+C, dotted+red);
    draw(pos+f--pos1+D, dotted+red);
    ship();
    if (i==1 && j==3)
      break;
  }
}

erase();
draw(bb, white);

featureMaps((-5,0), 11);


label(rotate(-90)*Label("Filters"), (6,2));
label(rotate(-90)*Label("ReLU"), (7.2,2));
draw((5, -1)--(5,5)--(8.2,3)--(8.2,1)--cycle);


featureMaps((12,0),11);
draw((1,2)--(5,2), Arrow);
draw((8.2,2)--(12,2), Arrow);

ship();

for(int i=0; i<11; ++i) {
  pair a = (-5+0.5i,5)+1.5*delta;
  pair b = (17-0.5i,5)+1.5*delta;
  pair s = (0, 4.5-0.15*i);
  draw(a--a+s--b+s--b, blue, Arrow);
  label("$+$", b+(0,3-0.15*i), blue, UnFill);
}

label("Skip Connections", (7,9), blue); 
ship();
