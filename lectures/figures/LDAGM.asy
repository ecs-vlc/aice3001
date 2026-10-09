size(550,0);
import myutil;

void state(string str, pair pos, pen col=white, real mar=1) {
  frame f = newframe;
  pen penCol = (col==white)? black:white;
  path p = ellipse(f, Label(str, penCol), Fill(col), xmargin=mar);
  draw(f,p);
  add(f, pos);
}

void connect(path p, real a) {
  draw(point(p,0)--point(p,a*length(p)), Arrow);
}

real[] y = {15,2,-6,-15};

pair[] wpos = new pair[];

for(int d=0; d<4; ++d) {
  pair p = (10, y[d]);
  if (d==2) {
    label("\Huge $\vdots$", p);
    label("\Huge $\vdots$", p+(10,0));
    label("\Huge $\vdots$", p+(20,0));
    continue;
  }
  connect((0,0)--p, 0.84+0.008*fabs(p.y));
  string doc = (d==3)? "{d_{|\mathcal{C}|}}": "{d_" + string(d+1) + "}";
  for (int i=0; i<4; ++i) {
    pair pt = p + (10, -3*(i-1.5));
    pair pw = p + (20, -3*(i-1.5));
    if (i == 2) {
      label("$\vdots$", pt);
      label("$\vdots$", pw);
      continue;
    }
    connect(p--pt, 0.82);
    connect(pt--pw, 0.8);
    string sub = (i==3)? "{N_ " + doc + "}":string(i+1);
    string st = "$\tau^{("+doc+")}_"+ sub + "$";
    state(st,pt);
    wpos.push(pw+(2,0));
    string sw = "$w^{("+doc+")}_"+ sub + "$";
    state(sw,pw);
  }
  string s = "$\bm{\theta}^{(" + doc + ")}$";
  state(s, p);
}

state("$\alpha$", (0,0), gray(0.4), 3);

pair[] tpos = new pair[];
for(int t=0; t<5; ++t) {
  pair p = (40, 5*(2-t));
  if (t==3) {
    continue;
  }
  tpos.push(p);
}

for(int i=0; i<wpos.length; ++i) {
  int r = floor((rand()/randMax)*tpos.length);
  connect(tpos[r]--wpos[i], 1);
}

for(int t=0; t<5; ++t) {
  pair p = (40, 5*(2-t));
  if (t==3) {
    label("\Huge $\vdots$", p);
    continue;
  }
  string topic = (t==4)? "{t_{|\mathcal{T}|}}": "{t_" + string(t+1) + "}";
  connect((50,0)--p, 0.86+0.005*fabs(p.y));
  state("$\bm{\phi}^{(" + topic + ")}$", p);
}

state("$\beta$", (50,0), gray(0.4), 3);

ship();

// *****************************************************
erase();


wpos = new pair[];

for(int d=0; d<4; ++d) {
  pair p = (10, y[d]);
  if (d==2) {
    label("\Huge $\vdots$", p);
    label("\Huge $\vdots$", p+(10,0));
    label("\Huge $\vdots$", p+(20,0));
    continue;
  }
  connect((0,0)--p, 0.84+0.008*fabs(p.y));
  string doc = (d==3)? "{d_{|\mathcal{C}|}}": "{d_" + string(d+1) + "}";
  for (int i=0; i<4; ++i) {
    pair pt = p + (10, -3*(i-1.5));
    pair pw = p + (20, -3*(i-1.5));
    if (i == 2) {
      label("$\vdots$", pt);
      label("$\vdots$", pw);
      continue;
    }
    connect(p--pt, 0.82);
    connect(pt--pw, 0.8);
    string sub = (i==3)? "{N_ " + doc + "}":string(i+1);
    string st = "$\tau^{("+doc+")}_"+ sub + "$";
    state(st,pt);
    wpos.push(pw+(2,0));
    string sw = "$w^{("+doc+")}_"+ sub + "$";
    state(sw,pw,gray(0.4));
  }
  string s = "$\bm{\theta}^{(" + doc + ")}$";
  state(s, p);
}

state("$\alpha$", (0,0), gray(0.4), 3);

pair[] tpos = new pair[];
for(int t=0; t<5; ++t) {
  pair p = (40, 5*(2-t));
  if (t==3) {
    continue;
  }
  tpos.push(p);
}

for(int i=0; i<wpos.length; ++i) {
  int r = floor((rand()/randMax)*tpos.length);
  connect(tpos[r]--wpos[i], 1);
}

for(int t=0; t<5; ++t) {
  pair p = (40, 5*(2-t));
  if (t==3) {
    label("\Huge $\vdots$", p);
    continue;
  }
  string topic = (t==4)? "{t_{|\mathcal{T}|}}": "{t_" + string(t+1) + "}";
  connect((50,0)--p, 0.86+0.005*fabs(p.y));
  state("$\bm{\phi}^{(" + topic + ")}$", p);
}

state("$\beta$", (50,0), gray(0.4), 3);

ship();
