import palette;

usepackage("bm");
size(100,0);

real[] myread(real[] in, int k, int n) {
  real[] x = new real[n];
  for(int i=0; i<n; ++i, ++k)
    x[i] = in[k];
  return x;
}

void myimage(pair p, real[] x, int gs=256) {
  real[][] im = new real[16][16];
  int k = 0;
  for(int j=15; j>=0; --j) {
    for (int i=0; i<16; ++i, ++k) {
      im[i][j] = 1-x[k];
    }
  }
  image(im,p,p+(0.7,0.7),Grayscale(gs));
}

file  fin = input("pca_data.dat");
real[] in = fin;
int k=0;
real[] pc = myread(in, k, 20);
k+=20;
real[] char20 = myread(in, k, 256);
k+=256;
real[] mu = myread(in, k, 256);
k+=256;
real[][] ev = new real[20][256];
for(int j=0; j<20; ++j) {
  for(int i=0; i<256; ++i, ++k)
    ev[j][i] = in[k];
}
size(500,0);
myimage((0,0), mu);
label("$\bm{\mu}$", (0.35,0),S);
// write(mu[0]);
pair p = (1, 0);
for (int i=0; i<20; ++i) {
  // write(ev[i][0]);
  myimage(p, ev[i]);
  label("$\bm{v}_{"+string(i+1)+"}$", p+(0.35,0),S);
  p += (1,0);
  if (p.x>6.5) {
    p = (0, p.y-1);
  }
}
shipout("digit_pca");
erase();


size(500,0);
myimage((0,0), mu);
// write(mu[0]);
pair p = (1, 0);
for (int i=0; i<19; ++i) {
  // write(ev[i][0]);
  myimage(p, ev[i]);
  p += (1,0);
  if (p.x>3.5) {
    p = (0, p.y-1);
  }
}
shipout("digit_pca1");
erase();


int picno =0;
void ship() {
  string fn = "pca_reconstruct" + string(picno);
  shipout(fn);
  erase();
  ++picno;
}

real[] reconst = mu;
myimage((0,0), char20, 2);
myimage((2,0), reconst);
for (int i=0; i<20; ++i) {
  label("\small "+string(pc[i],2), (i*3/22,1), E);
}
ship();

for(int j=0; j<20; ++j) {
  myimage((0,0), char20, 2);
  myimage((1,0), ev[j]);
  for (int i=0; i<256; ++i)
    reconst[i] += pc[j]*ev[j][i];
  myimage((2,0), reconst);
  for (int i=0; i<20; ++i) {
    label("\small "+string(pc[i],2), (i*3/22,1), E);
  }
  label("\small "+string(pc[j],2), (j*3/22,1), E, red);
  ship();
}
