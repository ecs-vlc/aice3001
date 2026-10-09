import graph3;
import stats;
size(700,0);
usepackage("bm");

triple mu = (1,2,0.5);

triple randpoint() {
  triple r=(Gaussrand(),Gaussrand(),Gaussrand());
  triple r1 = (1.73205*r.x-1.15470*r.y-0.57735*r.z, 1.63299*r.y-0.59196*r.z,
	       1.14728*r.z);
  return r1 + mu;
}

for(int i=0; i<100; ++i)
  dot(randpoint(),blue);

axes3("$x$","$y$","$z$");
triple e1 = (0.65490,0.45145,0.60605);
triple e2 = (-0.41451,-0.45596,0.78758);
triple e3 = (-0.63189,0.76700,0.11148);
real l1= 0.69592;
real l2= 2.7;
real l3= 5.60408;

draw(shift(mu)*scale3(sqrt(l1))*(O--e1), red, Arrow3);
draw(shift(mu)*scale3(sqrt(l2))*(O--e2), red, Arrow3);
draw(shift(mu)*scale3(sqrt(l3))*(O--e3), red, Arrow3);

label("$\sqrt{\lambda_3}\,\bm{v}_3$", 1.3*sqrt(l1)*e1+mu); 
label("$\sqrt{\lambda_2}\,\bm{v}_2$", 1.3*sqrt(l2)*e2+mu); 
label("$\sqrt{\lambda_1}\,\bm{v}_1$", 1.3*sqrt(l3)*e3+mu); 

draw(surface(shift(mu)*rotate(aCos(dot((0,0,1),e3)),cross((0,0,1),e3))*scale(sqrt(l1),sqrt(l2),sqrt(l3))*unitsphere),pink+opacity(0.3));

label("$(\bm{x}-\bm{\mu})^\textsf{T} \bm{\textsf{C}}^{-1}(\bm{x}-\bm{\mu})=1$", mu + 1.8*(e2-1.5*e3));
