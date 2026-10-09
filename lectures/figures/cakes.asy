settings.outformat = "pdf";
include myutil;

real r = 1;

void node(pair pos, string s, bool observed=false) {
  if (observed) {
    filldraw(circle(pos,r), gray, black);
    label(s, pos, white);
  } else {
    draw(circle(pos,r), black);
    label(s, pos);
  }
}

void depend(pair a, pair b) {
  pair d = r*(unit((a-b)));
  draw(a-d--b+d, Arrow);
}

