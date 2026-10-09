size(200,0);

void drawArrow(pair p1, pair p2) {draw(p1--p2, MidArrow);}

void drawNode(pair p, string s) {
  filldraw(circle(p, 0.5), white);
  label("$"+s+"$", p);
}

// X-->Y

pair[] p1 = {(0,0), (0,-2)};
drawArrow(p1[0], p1[1]);
drawNode(p1[0], "X");
drawNode(p1[1], "Y");

// Y-->X

pair[] p1 = {(2,0), (2,-2)};
drawArrow(p1[0], p1[1]);
drawNode(p1[0], "Y");
drawNode(p1[1], "X");

pair[] p1 = {(5,0), (4,-2), (6,-2)};
drawArrow(p1[0], p1[1]);
drawArrow(p1[0], p1[2]);
drawNode(p1[0], "Z");
drawNode(p1[1], "X");
drawNode(p1[2], "Y");
shipout("simpleGraphicalModels");

// X<--Z-->Y

erase();
size(80,0);
drawArrow(p1[0], p1[1]);
drawArrow(p1[0], p1[2]);
drawNode(p1[0], "Z");
drawNode(p1[1], "X");
drawNode(p1[2], "Y");
shipout("conditionalIndependence");
