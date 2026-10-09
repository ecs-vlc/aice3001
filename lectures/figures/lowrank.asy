size(400,0);

import three;
import stats;
import myutil;
import settings;
render=2;
settings.prc=true;
settings.outformat="pdf";

draw((0,0,0)--(0,0,0.5), Arrow3);
draw((0,0,0)--(0,0.5,0), Arrow3);
draw((0,0,0)--(00.5,0,0), Arrow3);

draw(scale3(1.2)*rotate(32,(1,2,3))*((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle),white);

triple[] points;

for(int i=0; i<30; ++i) {
  points.push(rotate(32,(1,2,3))*(0.3*Gaussrand(), 0.3*Gaussrand(), 0.1*Gaussrand()));
  dot(rotate(32,(1,2,3))*points[i]);
}

ship();

draw(rotate(32,(1,2,3))*((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle));
ship();


for(int i=0; i<30; ++i) {
  draw(rotate(32,(1,2,3))*(points[i]--(points[i].x, points[i].y, 0)), Arrow3);
  dot(rotate(32,(1,2,3))*(points[i].x, points[i].y, 0), red);
}
ship();

erase();
draw(scale3(1.2)*rotate(32,(1,2,3))*((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle),white);

draw(rotate(32,(1,2,3))*((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle));

triple mean = (0,0,0);
for(int i=0; i<30; ++i) {
  dot(rotate(32,(1,2,3))*(points[i].x, points[i].y, 0), red);
  mean += points[i];
}

mean = (mean.x, mean.y, 0)/30;
dot(rotate(32,(1,2,3))*mean, blue);
draw(rotate(32,(1,2,3))*(mean--mean+(0.3,0,0)), blue, Arrow3);
draw(rotate(32,(1,2,3))*(mean--mean+(0,0.5,0)), blue, Arrow3);
label("$\bm{\mu}$", rotate(32,(1,2,3))*mean, NW, blue);
label("$\bm{v}_2$", rotate(32,(1,2,3))*(mean+(0.3,0,0)), S, blue);
label("$\bm{v}_1$", rotate(32,(1,2,3))*(mean+(0,0.5,0)), E, blue);

ship();
