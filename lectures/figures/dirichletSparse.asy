settings.outformat="pdf";
import graph3;
import settings;
render = 0;

size(200,0);
currentprojection=orthographic(3,1,2);

void dirichlet(real a1, real a2, real a3) {
  real a0 = a1+a2+a3;
  real norm = gamma(a0)/(gamma(a1)*gamma(a2)*gamma(a3));
  int N = 50;
  real a = 1.0/N;
  for(int i=0; i<N; i+=1) {
    for (int j=0; j<N-i; j+=1) {
      triple pta = a*(i,j,N-i-j);
      triple ptb = a*(i+1,j,N-i-j-1);
      triple ptc = a*(i,j+1,N-i-j-1);
      triple mid = (pta+ptb+ptc)/3.0;
      real p = norm*mid.x^(a1-1)*mid.y^(a2-1)*mid.z^(a3-1);
      draw(surface(pta--ptb--ptc--cycle), gray(1-p), nolight);
      if (j<N-i-1) {
	triple pta = a*(i+1,j+1,N-i-j-2);      
	triple mid = (pta+ptb+ptc)/3.0;
	draw(surface(pta--ptb--ptc--cycle), gray(1-p), nolight);
      }
    }
  }
  layer();
  // bbox3 b=limits(O,(1.2,1.2,1.2));
  draw(X--Y--Z--cycle);
  xaxis3(Label("$p_1$",1.1),0,1.1,red,Arrow3);
  yaxis3(Label("$p_2$",1.1),0,1.1,red,Arrow3);
  zaxis3(Label("$p_3$",1.1),0,1.1,red,Arrow3);
  /*
  draw((1,0,0)--(1,0,-0.05),red);
  label("1", (1,0,-0.05),S,red);
  draw((0,1,0)--(0,1,-0.05),red);
  label("1", (0,1,-0.05),S,red);
  draw((0,0,1)--(0,-0.05,1),red);
  label("1", (0,-0.05,1),W,red);
  label("$O$",(0,0,0),NE,red);
  */
  triple pos = (-0.3,0.95,0);
  for(int i=0; i<N; i+=1) {
    draw(surface(pos+(0,0,a*i)--pos+(-0.03,0.1,a*i)--pos+(-0.03,0.1,a*i+a)--pos+(0,0,a*i+a)--cycle), gray(1-i*a), nolight);
  }
  draw(pos--pos+(-0.03,0.1,0)--pos+(-0.03,0.1,1)--pos+(0,0,1)--cycle);
  label("0", pos+(0,0.1,0),E);
  label("1", pos+(0,0.1,1),E);
  draw((0,0,0)--(1,0,0), red+white+linewidth(1.5));
  draw((0,0,0)--(0,1,0), red+white+linewidth(1.5));
  draw((0,0,0)--(0,0,1), red+white+linewidth(1.5));
  //  dot((a1,a2,a3)/a0);
  //  label("$\mu$", (a1,a2,a3)/a0, W);
}

real alpha = 1/3;
dirichlet(alpha,alpha,alpha);

