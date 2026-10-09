import settings;
render=0;

srand(1);

import myutil;
import three;
import stats;

size(300,0);

int n = 10;

triple[] data = new triple[n];
triple mu = (0,0,0);

for(int i=0; i<n; ++i) {
  data[i] = (Gaussrand(), Gaussrand(), 0.7*Gaussrand());
  mu += data[i];
  dot(data[i], blue);
}

dot((0,0,1),white);

ship();
mu /= n;

label("$\times$", mu, red);
label("$\mu$", mu, S, red);

ship();

picture pic = new picture;
add(pic, currentpicture);

for(int k=0; k<2; ++k) {
  erase();
  add(pic);
  triple v = unit((Gaussrand(), Gaussrand(),0.7*Gaussrand()));
  draw(mu-1.8v--mu+1.8v, dashed);
  draw(mu--mu+v, Arrow3);
  label("$\bm{v}+\bm{\mu}$", mu+1.1v);
  ship();
  for(int i=0; i<n; ++i) {
    real h = dot((data[i]-mu), v);
    draw(data[i]--h*v+mu, green);
    dot(data[i], red);
    dot(h*v+mu, green);
  }
  ship();
}
