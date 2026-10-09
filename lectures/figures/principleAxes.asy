size(100,0);
import three;
import settings;
render=2;
settings.prc=true;
settings.outformat="pdf";

triple e1 = (0.65490,0.45145,0.60605);
triple e2 = (-0.41451,-0.45596,0.78758);
triple e3 = (-0.63189,0.76700,0.11148);
real l1= 0.69592;
real l2= 2.7;
real l3= 5.60408;
triple mu = (1,2,0.5);
triple O = (0,0,0);

draw(scale3(sqrt(l1))*(O--e1), red, Arrow3);
draw(scale3(sqrt(l2))*(O--e2), red, Arrow3);
draw(scale3(sqrt(l3))*(O--e3), red, Arrow3);
draw(surface(rotate(aCos(dot((0,0,1),e3)),cross((0,0,1),e3))*scale(sqrt(l1),sqrt(l2),sqrt(l3))*unitsphere),pink+opacity(0.3));
