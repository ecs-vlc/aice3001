settings.outformat="pdf";
import myutil;

size(400,0);

int nin = 10;
pair in[] = new pair[nin];

for(int i=0; i<nin; ++i) {
  in[i] = (i-(nin-1)/2,0);
  filldraw(circle(in[i], 0.1));
}

draw(box((-5,-0.2),(5,6)), white);

picture bg = new picture;

add(bg, currentpicture);

for(real theta =-pi; theta<0.001; theta+=pi/10) {
  erase();
  pair n1 = (0,3) + 3*(cos(theta), 0.5*sin(theta));
  pair n2 = (0,3) + 3*(-cos(theta), -0.5*sin(theta));
  for(int i=0; i<nin; ++i) {
    draw(in[i]--n1, red);
    draw(in[i]--n2, blue);
  }
  add(bg);
  pair out = (0, 5.5);
  draw(n1--out, red);
  draw(n2--out, blue);
  draw(out--out+(0,0.5));
  if (abs(theta+pi)<1.0e-8) {
    label("$w_1^1=5$", 0.3*in[0]+0.7*n1, red, UnFill);
    label("$w_1^2=-2$", 0.3*in[0]+0.7*n2, blue, UnFill);
    label("$w_1^3 =3$", 0.5*out+0.5*n1, red, UnFill);
    label("$w_2^3 = 9$", 0.5*out+0.5*n2, blue, UnFill);
  } else if (abs(theta)<1.0e-8) {
    label("$w_1^2=5$", 0.3*in[0]+0.7*n1, red, UnFill);
    label("$w_1^1=-2$", 0.3*in[0]+0.7*n2, blue, UnFill);    
    label("$w_2^3=3$", 0.5*out+0.5*n1, red, UnFill);
    label("$w_1^3=9$", 0.5*out+0.5*n2, blue, UnFill);
  } else {
    label("5", 0.3*in[0]+0.7*n1, red, UnFill);
    label("-2", 0.3*in[0]+0.7*n2, blue, UnFill);
    label("3", 0.5*out+0.5*n1, red, UnFill);
    label("9", 0.5*out+0.5*n2, blue, UnFill);
  }

  filldraw(circle(out, 0.25));
  filldraw(circle(n1, 0.25), red);
  filldraw(circle(n2, 0.25), blue);
  label("3", out, white);
  label("2", n2, white);
  label("1", n1, white);
  ship();
}
