import palette;

size(500,0);

file  fin = input("semeion.data");
real[] in = fin;

int k=0;
int px = 0;
int py = 0;
for(int i1=0; i1<200; ++i1) {
  real[][] im = new real[16][16];
  for(int j=15; j>=0; --j) {
    for (int i=0; i<16; ++i, ++k) {
      im[i][j] = 1-in[k];
    }
  }
  for (int i=0; i<10; ++i, ++k) {
    if (in[k]==1) {
      image(im,(px,py),(px+0.7,py+0.7),Grayscale(2));
      ++px;
      if (px==20) {
	px = 0;
	++py;
      }
    }
  }
}
