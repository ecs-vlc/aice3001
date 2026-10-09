size(450,0);

string l = "$\mathcal{D} = \{D_i\}_{i=1}^P\quad D_i = (\mathbf{x}_i, y_i)$";
label(l, (95,12));
draw(box((-5,-4),(195,4)));
for(int i=0; i<20; ++i) {
  label("$D_{" + string(i+1) + "}$", (10*i,0));
  draw((10*i+5,-4)--(10*i+5,4));
}

picture data;
add(data, currentpicture);

int picno = 0;
void show() {
  draw(box((-20, -45),(210,20)), white);
  add(data);
  string fn = "cross_validation" + string(picno);
  shipout(fn);
  ++picno;
  erase();
}

show();
import stats;

picture pluspic;
real avE = 0;
for(int k=0; k<5; ++k) {
  label("$E_g =$", (-20,-35), E);
  fill(box((-5+40*k,-4),(35+40*k,4)), red);
  real e = abs(4+Gaussrand());
  label(string(e,2), (40*k+10,-35), NE);
  label(pluspic, string(e,2), (40*k+10,-35), NE);
  avE += e;
  if (k>0)
    label(pluspic, "$+$", (-5+40*k,-35), NE);
  label("Test Set", (15+40*k, -5), S, heavyred);
  if (k>0) {
    label("Training Set", (-5+20*k, -5), S);
  }
  if (k<4) {
    label("Training Set", (195-20*(4-k), -5), S);
  }
  label("5-fold cross-validation", (95,-12), S);
  show();
}

label("$\langle E_g \rangle =$", (-20,-35), E);
add(pluspic);
draw((0,-35)--(190,-35));
label("5", (90,-35), S);
label(" = " + string(avE/5,2), (190,-35), E);
show();

erase(pluspic);

avE = 0;
for(int k=0; k<10; ++k) {
  label("$E_g =$", (-20,-35), E);
  real e = abs(4.2+sqrt(2)*Gaussrand());
  label(string(e,2), (20*k,-35), NE);
  label(pluspic, string(e,2), (20*k,-35), NE);
  avE += e;
  if (k>0)
    label(pluspic, "$+$", (-7.5+20*k,-35), NE);
  fill(box((-5+20*k,-4),(15+20*k,4)), red);
  label("Test Set", (5+20*k, -5), S, heavyred);
  if (k>1) {
    label("Training Set", (-5+10*k, -5), S);
  }
  if (k<8) {
    label("Training Set", (195-10*(9-k), -5), S);
  }
  label("10-fold cross-validation", (95,-12), S);
  show();
}
label("$\langle E_g \rangle =$", (-20,-35), E);
add(pluspic);
draw((0,-35)--(190,-35));
label("10", (90,-35), S);
label(" = " + string(avE/10,2), (190,-35), E);
show();

avE = 0;
for(int k=0; k<5; ++k) {
  label("$E_g = $", (-20,-35), E);
  real e = abs(4.4+2*Gaussrand());
  label(string(e,2), (10*k-5,-35), NE);
  avE += e;
  fill(box((-5+10*k,-4),(5+10*k,4)), red);
  label("Test", (10*k, -5), S, heavyred);
  label("Leave-one-out cross-validation", (95,-12), S);
  show();
}

label("$\langle E_g \rangle =$"+string(avE/5,2), (-20,-35), E);

show();
