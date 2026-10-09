import settings;
//settings.outformat="pdf";
//settings.prc=true;
render=0;
import three;
import graph3;
import myutil;

size(450,0);

void lattice(int n, int m, int height) {
  for (int i=0; i<=n; ++i) {
    draw((i,0,height)--(i,m,height));
  }
  for (int j=0; j<=m; ++j) {
    draw((0,j,height)--(n,j,height));
  }
}

int l1 = 7;
int l2 =5;
int h = 4;

int[][] makeValues(int n, int m, bool isKernel=false) {
  int[][] image = new int[n][n];
  for (int i=0; i<n; ++i) {
    for (int j=0; j<n; ++j) {
      image[i][j] = (isKernel)? floor(6.0*rand()/randMax)-3:floor(5.0*rand()/randMax);
      label(string(image[i][j]), (i+0.5, j+0.5, 0), blue);
    }
  }
  return image;
}

dot((11,1), white);

int[][] image = makeValues(l1,l1);

lattice(l1,l1,0);
lattice(l2,l2,h);
picture twoLayers = new picture;
add(twoLayers, currentpicture);
ship();

int[][] kernel = makeValues(3,3, true);

for (int i=0; i<l2; ++i) {
  for (int j=0; j<l2; ++j) {
    erase();
    size(600,0);
    add(currentpicture,twoLayers);
    draw((i,j,0)--(i,j,h), red);
    draw((i+3,j,0)--(i+1,j,h), red);
    draw((i,j+3,0)--(i,j+1,h), red);
    draw((i+3,j+3,0)--(i+1,j+1,h), red);
    draw((i,j,0)--(i+3,j,0)--(i+3,j+3,0)--(i,j+3,0)--cycle, red+linewidth(2));
    draw((i,j,h)--(i+1,j,h)--(i+1,j+1,h)--(i,j+1,h)--cycle, red+linewidth(2));
    triple p1 = 0.5*((i,j,0)+(i,j,h));
    triple p2 = 0.5*((i+3,j,0)+(i+1,j,h));
    triple p3 = 0.5*((i+3,j+3,0)+(i+1,j+1,h));
    triple p4 = 0.5*((i,j+3,0)+(i,j+1,h));
    draw(p1--p2--p3--p4--cycle, red+linewidth(2));
    for(int k=1; k<3; ++k) {
      draw(((3-k)*p1+k*p2)/3--((3-k)*p4+k*p3)/3, red);
      draw(((3-k)*p1+k*p4)/3--((3-k)*p2+k*p3)/3, red);
    }
    int featureMap = 0;
    string s = "$\begin{matrix}";
    for(int k=0; k<3; ++k) {
      for(int l=0; l<3; ++l) {
	triple c1 = ((3-k)*p1+k*p2)/3;
	triple c2 = ((3-l)*p1+l*p4)/3;
	label(string(kernel[k][l]), c1+c2-p1+(0.3,0.3,0), blue);
	featureMap += kernel[k][l]*image[i+k][j+l];
	if (kernel[k][l]>=0)
	  s += "+";
	s += string(kernel[k][l]) + " \times " + string(image[i+k][j+l]);
      }
      if (k<2)
	s += "\hfill \\ ";
    }
    label(string(featureMap), (i+0.5,j+0.5,h), blue);
    s += " = " + string(featureMap) + "\end{matrix}$";
    //    write(s);
    label(Label(s), (7,1), E, blue);
    label(twoLayers, string(featureMap), (i+0.5,j+0.5,h), blue);
    ship();
  }
}
