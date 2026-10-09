settings.outformat="pdf";
size(400,0);
usepackage("bm");
usepackage("amsmath");
usepackage("amsfonts");
texpreamble("\DeclareMathAlphabet{\mat}{U}{eur}{b}{n}");

string ones = "$1,\,1,\,\ldots,\,1$";
string zeros = "$0,\,0,\,\ldots,\,0$";

void line(string x, pair start) {
  for(int i=0; i<4; ++i) {
    string y = (i==2)? "$\ldots$":x;
    label(y, start+(0.5+i,0.5));
  }
}

void line1(int l, pair start) {
  for(int i=0; i<4; ++i) {
    string x = (i==l)? "1":"0";
    string y = (i==2)? "$\ldots$":x;
    label(y, start+(0.5+i,0.5));
  }
}

for(int j=0; j<4; ++j) {
  for(int i=0; i<4; ++i) {
    string z = (i==j)? "1":"0";
    string y = (i==2)? "$\ldots$":z;
    if (j==2)
      y = "$\vdots$";
    line(y, (4*i, -j));
  }
}
for(int j=4; j<8; ++j) {
  for(int i=0; i<4; ++i) {
    if (j==6)
      line("$\vdots$", (4*i, -j));
    else {
      if (i==2)
	line("$\ldots$", (4*i, -j));
      else
	line1(j-4,  (4*i, -j));
    }
  }
}

for(int i=1; i<4; ++i)
  draw((4*i,1)--(4*i,-7), dotted+red);

draw((0,-3)--(16,-3), dotted+red);

draw((0,1)..(-0.3,-3)..(0,-7));
draw((16,1)..(16.3,-2)..(16,-7));

for(int j=0; j<4; ++j) {
  for(int i=0; i<4; ++i) {
    string s;
    if (j==2 || i==2)
      s = "$\vdots$";
    else {
      string n = (i==3)? "n":string(i+1);
      string m = (j==3)? "n":string(j+1);
      s = "$\gamma(x_{" + n + "},\, y_{" + m + "})$";
    }
    label(s,(19.5, 8.5-3-4*j-i));
  }
}

for(int j=1; j<4; ++j) {
  draw((17.9,6-4*j)--(21.1,6-4*j), dotted+red);
}
draw((17.7,6)..(17.4,-3)..(17.7,5.5-15.5));
draw((21.3,6)..(21.6,-3)..(21.3,5.5-15.5));

label("=", (23,-3));


for(int i=0; i<4; ++i) {
  if (i==2) {
    label("$\vdots$", (25.5,-i+0.5));
  } else {
    string n = (i==3)? "n":string(i+1);
    label("$q(y_{" + n + "})$", (25.5, -i+0.5));
  }
}

for(int i=0; i<4; ++i) {
  if (i==2) {
    label("$\vdots$", (25.5,-i+0.5-4));
  } else {
    string n = (i==3)? "n":string(i+1);
    label("$p(x_{" + n + "})$", (25.5, -i+0.5-4));
  }
}

draw((24.5,1)..(24.5-0.3,-3)..(24.5,-7));
draw((26.5,1)..(26.5+0.3,-3)..(26.5,-7));

draw((24.5,-3)--(26.5,-3), dotted+red);

label("$\mat{A} \, \bm{\gamma} = \bm{P}$", (22.5, 7));
