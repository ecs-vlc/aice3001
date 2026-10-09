settings.outformat="pdf";
size(500,300, IgnoreAspect);
import myutil;
import stats;
import graph;
import sos;

int n = 10;

int winner = 0;
real winningValue = -100;
real trueValue = -100;

path bb = box((-2,-2.2), (10, 6));
picture errors = new picture;

int iter = 100000;
real delta[] = new real[iter];

int showT = 10;

for(int t=0; t<iter; ++t) {
  winningValue = -100;
  for(int i=0; i<n; ++i) {
    real r = 3*rand()/randMax;
    real d = r+Gaussrand();
    if (d>winningValue) {
      winner = i;
      winningValue = d;
      trueValue = r;
    }
    if (t<showT) {
      dot((i,r), red+linewidth(8));
      dot(errors,(i,d), blue+linewidth(8));
    }
  }
  real d = winningValue-trueValue;
  delta[t] = d;
  if (t<showT) {
    draw((-1,-2)--(-1,5));
    for(int i=-2; i<=5; ++i) {
      draw((-1,i)--(-1.2,i));
      label(string(i), (-1.2,i), W);
    }
    draw(bb, white);
    if (t<4) {
      label("\large $P_i\sim3\,U(0,1)$", (2,4), red);
      ship();
    }
    add(errors);
    if (t<4) {
      label("\large $\hat{P}_i=P_i+\eta_i,\quad \eta_i\sim\mathcal{N}(0,1)$", (6,4), blue);
      ship();
    }
    draw((winner-0.2,winningValue)--(winner+0.2,winningValue));
    draw((winner-0.2,trueValue)--(winner+0.2,trueValue));
    draw((winner,winningValue)--(winner,trueValue));
    label("\large $\Delta$", (winner, 0.5*(winningValue+trueValue)), E);
    draw(circle((winner, winningValue), 0.2));
    label("\large Error $\Delta = $" + string(d, 3), (4,5));
    ship();
    erase();
    erase(errors);
  }
}


histogram(delta, -1,4,20,normalize=true,lightred, black,bars=false);
xaxis("\large Error, $\Delta$", xmin=-1, xmax=4, RightTicks(5));
yaxis("\Large $f(\Delta)$", ymin=0, ymax=0.6, LeftTicks(3));
draw((0,0)--(0,0.6));
real  m = mean(delta);
draw((m,0)--(m,0.6), dashed);

ship();


Sos[] means = new Sos[11];
for(int i=0; i<means.length; ++i) {
  means[i] = Sos();
}
means[1].av=0;
means[1].cnt =2;
means[10].av = m;
means[10].sqr = (iter-1)*variance(delta);
means[10].cnt = iter;


for(n=2; n<10; ++n) {
  for(int t=0; t<iter; ++t) {
    winner = 0;
    winningValue = -100;
    trueValue = -100;
    for(int i=0; i<n; ++i) {
      real r = 3*rand()/randMax;
      real d = r+Gaussrand();
      if (d>winningValue) {
	winner = i;
	winningValue = d;
	trueValue = r;
      }
    }
    real d = winningValue-trueValue;
    means[n].add(d);
  }
}

erase();

draw((0,0)--(10,0));

for(int i=1; i<11; ++i) {
  draw((i,0)--(i,-0.05));
  label(string(i), (i,-0.05), S);
  dot((i,means[i].mean()), red+linewidth(8));
}

draw((0,0)--(0,1.5));
for(real r=0; r<1.51; r+=0.5) {
  draw((0,r)--(-0.2,r));
  label(string(r,2), (-0.2,r), W);
}

label("\large $\mathbb{E}[\Delta]$", (0,1.5), N);
label("\large Best of $n$", (5,-0.2));
ship();
