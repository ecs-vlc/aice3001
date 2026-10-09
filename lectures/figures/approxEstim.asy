import myutil;

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

pair dataGen() {
  real a = 2* pi*urand();
  pair r = 0.4*(cos(a), sin(a)) + pb+(0.2, -0.5) + 0.05*(urand(), urand());
  return (2*r.x+0.7, 0.3*r.y+0.2);
}

data.push(dataGen());

dot(data[0]);
label("$\hat{f}(\bm{x}|\bm{\theta}_{\mathcal{D}})$", data[0], 1.2E, blue);
ship();

draw(pf--data[0], dashed+linewidth(0.5));
label("generalisation error", 0.5*(pf+data[0]), E);

ship();

draw(pb--data[0], dashed+linewidth(0.5));
label("estimation error", 0.5*(pb+data[0]), W);

ship();

erase();

add(bg);
draw(pf--data[0], dashed+linewidth(0.5));
dot(data[0]);
dot(pf, blue);
label("$\hat{f}(\bm{x}|\bm{\theta}_{\mathcal{D}})$", data[0], 1.2E, blue);
label("generalisation error", 0.5*(pf+data[0]), E);
ship();

int n= 8;
pair bias = data[0]/n;
for(int i=1; i<n; ++i) {
  data.push(dataGen());
  bias += data[i]/n;
  erase();
  add(bg);
  draw(pf--data[i], dashed+linewidth(0.5));
  dot(data[i]);
  dot(pf, blue);
  label("$\hat{f}(\bm{x}|\bm{\theta}_{\mathcal{D}_{" + string(i) + "}})$", data[i], 1.2E, blue);
  label("generalisation error", 0.5*(pf+data[i]), E);
  ship();
}

erase();
add(bg);
for(int i=0; i<7; ++i) {
  dot(data[i]);
}

ship();

label("\large $\times$", bias, green);
label("mean machine", bias, NE, green);

ship();

draw(pf--bias, dashed+linewidth(0.5));

dot(pf, blue);
label("bias", 0.5*(pf+bias), E);

ship();

label("mean machine", bias, NE, orange);
for(int i=0; i<7; ++i) {
  draw(bias--data[i], purple, Arrows);
}
label("\large $\times$", bias, green);
label("variance", bias+(0.3,0.1), E, purple);
ship();
