size(100,0);
import graph;

real q(real p) {
  return p*(1-p);
}

draw((0,0.5)--(0,0)--(1.2,0), Arrows);
label("$p_c\,(1-p_c)$", (0,0.5), E, red);
label("$p_c$", (1.2,0), E);
for(int i=0; i<=1; ++i) {
  draw((i,0)--(i,-0.1));
  label(string(i), (i,-0.1), S);
}
draw(graph(q,0,1), red);
