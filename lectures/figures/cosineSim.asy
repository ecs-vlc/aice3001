size(400,0);
import three;
import graph3;
import settings;
import myutil;
render=0;

currentprojection=perspective(3, 2, 1);

xaxis3("Titanic", YZEquals(1,1,align=(1,1,1)), 1, 5, OutTicks(4));
yaxis3("Dr No", XZEquals(1,1,align=(1,1,1)), 1, 5, OutTicks(4));
zaxis3("The Matix", XYEquals(1,1,align=(1,1,1)), 1, 5, OutTicks(4));

triple r1 = (3,2,3);
triple r2 = (2,3,4);
draw((1,1,1)--r1, red, Arrow3);
draw((1,1,1)--r2, red, Arrow3);
triple p1 = (1,1,1) + unit(r1-(1,1,1));
triple p2 = (1,1,1) + unit(r2-(1,1,1));
triple p3 = (1,1,1) + 1.1*unit(0.5*(p1+p2)-(1,1,1));
draw(p1..p3..p2, blue);

label("\Large$\theta$", 1.1*p3, W, blue);
label("\Large$\bm{r}_{rob}$", r1, N, red);
label("\Large$\bm{r}_{pete}$", r2, N, red);

label("\Large$\cos(\theta) = \frac{\bm{r}_{rob}^\tr \bm{r}_{pete}}{\|\bm{r}_{rob}\|\,\|\bm{r}_{pete}\|}$", (1,3.5,2), blue);
