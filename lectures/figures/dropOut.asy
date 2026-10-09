size(600,0);
import myutil;
srand(2);

real u = 4;

picture network = new picture;

void show() {
  ship();
  erase();
  add(network);
}

struct Edge {
  int inNode;
  int outNode;
  path p;
  void draw(pen col) {
    draw(this.p, col);
  }
  static Edge Edge(int inNode, int outNode, path p) {
    Edge e = new Edge;
    e.inNode = inNode;
    e.outNode = outNode;
    e.p = p;
    return e;
  }
};

from Edge unravel Edge;

struct Node {
  int node;
  path p;
  void draw(pen col) {
    filldraw(this.p, col, col);
  }
  static Node Node(int node,  path p) {
    Node e = new Node;
    e.node = node;
    e.p = p;
    return e;
  }
};

from Node unravel Node;

Edge[] edges;
Node[] nodes;

int nodeNumber = 0;


void layer(int nNodes, real xNode, int nOut, real xOut) {
  real offNode = -(nNodes-1)/2;
  real offOut = -(nOut-1)/2;
  for(int i=0; i<nNodes; ++i) {
    pair np = (xNode*u, i+offNode);
    for(int j=0; j<nOut; ++j) {
      pair no = (xOut*u, j+offOut);
      pair v = unit(no-np);
      path p = np+0.3*v--no-0.3*v;
      if (nNodes>1) {
	edges.push(Edge(nodeNumber+i, nodeNumber+nNodes+j, p));
      }
      draw(p);
    }
    path c = circle(np, 0.3);
    filldraw(c, yellow);
    nodes.push(Node(nodeNumber+i, c));
  }
  nodeNumber += nNodes;
}



for(int i=0; i<4; ++i) {
  layer(8,i,8,i+1);
}
layer(8,4,4,5);
layer(4,5,1,6);
layer(1,6,1,7);

add(network, currentpicture);

show();

bool[] nodeOn = new bool[nodeNumber];
int halfRandMax = round(randMax/2);
nodeOn[nodeNumber-1]=true;


for(int iter=0; iter<6; ++iter) {
  for(int i=0; i<nodeOn.length-1; ++i) {
    nodeOn[i] = (rand()>halfRandMax);
    if (!nodeOn[i]) {
      nodes[i].draw(lightgray);
    }
  }
  for(int i=0; i<edges.length; ++i) {
    if (nodeOn[edges[i].inNode]&&nodeOn[edges[i].outNode])
      ;
    else
      edges[i].draw(lightgray);
  }
  for(int i=0; i<edges.length; ++i) {
    if (nodeOn[edges[i].inNode]&&nodeOn[edges[i].outNode])
      edges[i].draw(red);
  }
  show();
}

show();
