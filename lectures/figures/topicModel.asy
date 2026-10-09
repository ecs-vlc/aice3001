size(400,0);

void drawDoc(pair pos, string str) {
  path p = (0,0)--(0,1)--(0.6,1)--(0.6,0.15)--(0.45,0.15)--(0.45,0)--cycle;
  draw(shift(pos)*p);
  draw(pos+(0.45,0)--pos+(0.6,0.15));
  for(real y=0.1; y<0.99; y+=0.1) {
    real x = 0.1;
    while (x<0.5) {
      real xp = x + 0.02 + 0.03*rand()/randMax;
      if (y<0.15 && xp>0.45) {
	xp = 0.44;
      }
      draw(pos+(x,y)--pos+(xp,y), linewidth(3)+gray);
      x = xp + 0.03;
      if (y<0.15 && x>0.44) {
	break;
      }
    }
  }
  label(str, pos+(0.3,1), N);
}

for(real i=0; i<3; i+=1) {
  drawDoc((i,0), "$d_" + string(i+1) + "$");
}

for(real i=3; i<3.7; i+=0.3)
  filldraw(circle((i,0.5), 0.03));

drawDoc((4,0), "$d_{|\mathcal{C}|}$");


void drawTopic(pair pos, string str) {
  filldraw(shift(pos)*xscale(2.1)*yscale(1.1)*circle((0,0), 0.2), white, white);
  draw(shift(pos)*xscale(2)*circle((0,0), 0.2));
  label("Topic " + str, pos);
}

pair tp[] = {(0.5, -1), (1.7, -1), (4, -1)};

void connect(path p, real w, real a) {
  draw(point(p,0)--point(p,a*length(p)), linewidth(w),
       Arrow(10));
}

connect((0.28,-0.08)--tp[0], 3, 0.74);
connect((0.32,-0.08)--tp[1], 2, 0.81);
connect((1.28,-0.08)--tp[0], 1, 0.78);
connect((1.32,-0.08)--tp[1], 4, 0.73);
connect((2.3,-0.08)--tp[1], 5, 0.73);
connect((4.28,-0.08)--tp[0], 1, 0.9);
connect((4.32,-0.08)--tp[2], 4, 0.72);


for(int x=1; x<3; x+=1) {
  drawTopic(tp[x-1], "$t_" + string(x) + "$");
}

for(real i=2.6; i<3.2; i+=0.3)
  filldraw(circle((i,-1), 0.03));


drawTopic(tp[2], "$t_{|\mathcal{T}|}$");

shipout("topicModel");

erase();

label("\Huge $\mathcal{V} = \left\{w_1,\,w_2,\,w_3,\,\ldots,\, w_{|\mathcal{V}|}\right\}$", (2,0), N);
draw(tp[0]--(1.2,0), linewidth(4), Arrow(10));
draw(tp[1]--(1.25,0), linewidth(1), Arrow(10));
draw(tp[0]--(1.55,0), linewidth(2), Arrow(10));
draw(tp[1]--(1.63,0), linewidth(3), Arrow(10));
draw(tp[1]--(2.1,0), linewidth(5), Arrow(10));
draw(tp[1]--(3.08,0), linewidth(4), Arrow(10));
draw(tp[2]--(3.12,0), linewidth(1), Arrow(10));


for(int x=1; x<3; x+=1) {
  drawTopic(tp[x-1], "$t_" + string(x) + "$");
}

drawTopic(tp[2], "$t_{|\mathcal{T}|}$");
for(real i=2.6; i<3.2; i+=0.3)
  filldraw(circle((i,-1), 0.03));

shipout("topicModel1");
