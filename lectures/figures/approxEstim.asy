import myutil;
import stats;

size(400,0);

srand(12131);

real urand() {return rand()/randMax;}


guide ghyp;
guide gtar;

for(real a=0; a<2*pi; a+=0.5) {
  pair p = (2*cos(a), sin(a)) + 0.1*(urand(), urand());
  ghyp = ghyp..p;
  p = 2*(1.5*cos(a), sin(a)) + (0.2, 0.3) + 0.1*(urand(), urand());
  gtar = gtar..p;
}
ghyp = ghyp..cycle;
gtar = gtar..cycle;

picture bg = new picture;
filldraw(bg, gtar, yellow);
filldraw(bg, ghyp, orange);
label(bg, "\Large Hypothesis Space", (0,0), SE);
label(bg, "\Large Target Space", (0,2), E);
add(bg);
ship();

pair pf = (-1,1.6);
dot(bg, pf, blue+linewidth(5));
label(bg, "$f(\bm{x})$", pf, 1.5W, blue);

erase();
add(bg);

ship();

pair pb = (-0.8, 0.96);
dot(pb, blue+linewidth(5));
label("$\hat{f}(\bm{x}|\bm{\theta}_{\text{\tiny \it best}})$", pb+(0,0.1), 1.2W, blue);

ship();

draw(pf--pb, dashed+linewidth(0.5));
dot(pf, blue+linewidth(5));
dot(pb, blue+linewidth(5));
label("approximation error", 0.5*(pf+pb), E);

ship();

pair[] data;

pair d1 = unit(pb-pf);
pair d2 = (d1.y, -d1.x);
pair mm = pb + 0.5*d1;


pair dataGen() {
  pair a = 0.05*d1*Gaussrand() + 0.2*d2*Gaussrand();
  while (5*length(a)<urand()) {
     a = 0.05*d1*Gaussrand() + 0.2*d2*Gaussrand();
  }
  return mm + a;
}

data.push(dataGen());

dot(data[0]);
label("$\hat{f}(\bm{x}|\bm{\theta}_{\mathcal{D}})$", data[0], 1.2E, blue);
ship();

draw(pf--data[0], dashed+linewidth(0.5));
label("generalisation error", 0.3pf+0.7data[0], W);

ship();

draw(pb--data[0], dashed+linewidth(0.5));
label("estimation error", 0.5*(pb+data[0]), E);

ship();

erase();

add(bg);
draw(pf--data[0], dashed+linewidth(0.5));
dot(data[0]);
dot(pf, blue);
label("$\hat{f}(\bm{x}|\bm{\theta}_{\mathcal{D}})$", data[0], 1.2E, blue);
label("generalisation error", 0.3*pf+0.7*data[0], E);
ship();

int n= 10;
pair bias = mm;
for(int i=1; i<n; ++i) {
  data.push(dataGen());
  erase();
  add(bg);
  draw(pf--data[i], dashed+linewidth(0.5));
  dot(data[i]);
  dot(pf, blue);
  label("$\hat{f}(\bm{x}|\bm{\theta}_{\mathcal{D}_{" + string(i) + "}})$", data[i], 1.2E, blue);
  label("generalisation error", 0.3pf+0.7data[i], E);
  ship();
}

erase();
add(bg);
for(int i=0; i<9; ++i) {
  dot(data[i]);
}

ship();

for(int i=0; i<200; ++i) {
  dot(dataGen(), linewidth(1)+gray);
}

ship();



label("\large $\times$", bias, green);
bg.erase();
bg.add(currentpicture);
label("mean machine", bias, NE, green);

ship();


draw(pf--bias, dashed+linewidth(0.5));

dot(pf, blue);
label("bias=generalisation of mean machine", 0.3*pf+0.7bias, E);

ship();

erase();
add(bg);
dot(pf, blue);
label("bias", 0.3*pf+0.7bias, E);
draw(pf--bias, dashed+linewidth(0.5));


for(int i=0; i<9; ++i) {
  draw(bias--data[i], purple, Arrows);
}
label("\large $\times$", bias, green);
label("variance", bias+(0.2,-0.12), E, purple);
ship();
