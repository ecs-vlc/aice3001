size(400,0);

pair paperJam = (-2,1);
pair ink = (0,1);
pair off = (2,1);
pair fuseBlown = (4, 1);
pair warning = (-1,0);
pair powerLight = (3,0);


void state(string str, pair pos, pen col=white, pen penCol=black) {
  frame f = newframe;
  path p = ellipse(f, Label(str, penCol), Fill(col));
  draw(f,p);
  add(f, pos);
}


void connect(path p, real a) {
  draw(point(p,0)--point(p,a*length(p)), Arrow);
}

connect(paperJam--warning, 0.8);
//connect(paperJam--powerLight, 0.83);
connect(ink--warning, 0.81);
connect(off--powerLight, 0.81);
connect(off--warning, 0.83);
connect(off--powerLight, 0.8);
connect(fuseBlown--powerLight, 0.8);
connect(fuseBlown--warning, 0.85);

state("paper jam", paperJam);
state("out of ink", ink);
state("switched off", off);
state("fuse blown", fuseBlown);
state("warning light", warning, gray, white);
state("power light", powerLight);

