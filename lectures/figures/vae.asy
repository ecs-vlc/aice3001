import myutil;
import contour;
pair mu = (0,0);
pair sigma = (1,1);

real f(real x, real y) {
  return exp(-0.5*((x-mu.x)/sigma.x)^2-0.5*((y-mu.y)/sigma.y)^2)/(2*pi*sqrt(sigma.x*sigma.y));
}

real[] level = new real[20];
for(int i=0; i<20; ++i) {
  level[i] = 0.02*i+0.02;
}





size(50,0);
draw(box((0,0),(2,2)));
draw((0.75,1.2)..(0.79,0.6)..(0.75,0.2), brown+linewidth(5));
draw((0.85,1.2)..(0.81,0.6)..(0.55,0.2), brown+linewidth(5));
filldraw(circle((0.8, 1.3), 0.4), heavygreen, heavygreen);
picture im = new picture;
add(im,currentpicture.fit());
erase();

draw(box((0,0),(2,2)));
draw((0.75,1.2)..(0.79,0.6)..(0.76,0.2), brown+linewidth(5));
draw((0.85,1.2)..(0.81,0.6)..(0.75,0.2), brown+linewidth(5));
filldraw(circle((0.8, 1.3), 0.4), deepgreen, deepgreen);
picture im1 = new picture;
add(im1,currentpicture.fit());
erase();




size(80,0);
draw((-1.7,0)--(1.7,0), Arrow);
draw((0,-1.7)--(0,1.7), Arrow);
label("$z_1$", (1.7,0), E);
label("$z_2$", (0,1.7), N);

draw(contour(f,(-1.5,-1.5),(1.5,1.5), level), blue);
mu = (-0.8,0.6);
sigma=(0.06, 0.08);
draw(contour(f,mu+(-1,-1),mu+(1,1), level), red);


picture latent = new picture;
add(latent,currentpicture.fit());
erase();

size(550,0);

draw(box((-1.6,-5.4),(19.5,2.1)),white);
label("$\bm{x}\sim \mathcal{D}$", (0,0), W);
add(im.fit(), (-1.5,-5));
ship();

draw((0,0)--(1,0), MidArrow);
draw((1,-2)--(1,2)--(4,0.5)--(4,-0.5)--cycle);
label("Encoder", (2.5,0.4));
label("(parameters $\bm{\phi})$", (2.5,-0.3));
draw((4,0)--(5,0), MidArrow);
add(latent.fit(), (5,-4));

real a = 5;
real b = a + 1.5;
label("$(\bm{\mu}, \bm{\sigma})$", (0.5*(a+b),0));
real c = b + 1;
real d = c + 2.5;

label("$q_{\bm{\phi}}(\bm{z}| \bm{x})=\mathcal{N}(\bm{z}|\bm{\mu},\mathrm{diag}(\bm{\sigma}^2))$", (0.5*(c+d),-1.5));
ship();


draw((b,0)--(c,0), MidArrow);
label("$\bm{z}\sim q_{\bm{\phi}}(\bm{z}| \bm{x})$", (0.5*(c+d),0));
label("$\bm{\times}$", (4.4,-3.4));



ship();
draw((d,0)--(d+1,0), MidArrow);
draw((d+1,-0.5)--(d+1,0.5)--(d+4,2)--(d+4,-2)--cycle);
label("Decoder", (d+2.5,0.3));
label("(parameters $\bm{\theta})$", (d+2.5,-0.3));
draw((d+4,0)--(d+5,0), MidArrow);
real f = d+5;
real g = f+1;
label("$\hat{\bm{x}}$", (0.5*(f+g),0));
add(im1.fit(), (15,-5));
ship();
draw((g,0)--(g+1,0), MidArrow);
label("$p_{\bm{\theta}}(\bm{x}|\bm{z})$", (g+1,0), E);
ship();
label("$=\mathcal{N}\!\left(\bm{x}-\hat{\bm{x}}\big|\bm{0}, \sigma_e^2\, \mat{I}\right)$", (d+5,-1.5), E);
ship();

erase();
