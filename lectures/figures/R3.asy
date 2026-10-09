import settings;
render=0;

import three;
import graph3;
currentprojection=perspective(5,4,2);

size(100,0);

xaxis3(Label("$x_1$",EndPoint),0,1, red, Arrow3);
yaxis3(Label("$x_2$",EndPoint),0,1, red, Arrow3);
zaxis3(Label("$x_3$",EndPoint),0,1, red, Arrow3);

draw((0,0,0)--(0.3,.8,.7), Arrow3);

