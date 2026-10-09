settings.outformat="pdf";
size(200,0);
import myutil;
import graph;

void axis(real xmin, real xmax, real ymin, real ymax, pair offset, string f) {
  draw(offset+(xmin,0)--offset+(xmax,0), Arrow);
  draw(offset+(0,ymin)--offset+(0,ymax), Arrow);
  pair o = (ymax>ymin)? N:S;
  label("$" + f + "$", offset+(0,ymax), o);
  label("$x$", offset+(xmax,0), E);
}

/* abs */

pair offset = (0,0);

axis(-2,2,0,2,offset, "|x|");

draw(shift(offset)*graph(abs,-2,2), blue);
