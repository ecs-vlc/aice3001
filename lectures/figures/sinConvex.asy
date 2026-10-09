settings.outformat="pdf";
import graph;
import myutil;
size(300,0);

draw((-0.5,0)--(9.9,0), Arrow);
draw((0,-1.2)--(0,1.2), Arrow);
string[] l = {"0","", "\pi" , "", "2\,\pi", "", "3\,\pi"};
for(int i=0; i<=6; ++i) {
  real x = i*pi/2;
  draw((x,0)--(x,-0.08));
  label("$"+l[i]+"$",(x,-0.08),S);
}
draw(graph(sin,-0.5, 9.9), red);

ship();

picture fg = new picture;

add(fg,currentpicture);
erase();

filldraw(graph(sin,0,pi)--(pi,-1.2)--(0,-1.2)--cycle, pink, white);
add(fg);
ship();

filldraw(graph(sin,2pi,3pi)--(3pi,-1.2)--(2pi,-1.2)--cycle, pink, white);
add(fg);
ship();
