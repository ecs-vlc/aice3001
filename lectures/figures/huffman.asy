size(450,0);

real dx = 0.2;
real sqrth = sqrt(0.5);
real u = 3.5;
real u1 = 1.2;
real sigmax = 2.6;

real prob(real x) {
  return 0.5*(erfc((x-0.5*dx)*sqrth)-erfc((x+0.5*dx)*sqrth));
}

real sqrt2pi = sqrt(2*pi);

real normal(real x) {
  return exp(-0.5*x*x)/sqrt2pi;
}

guide gauss;
real y = -sigmax;
for(int i=0; i<=50; ++i) {
  gauss = gauss--u*(y, u*u1*normal(y));
  y += 2.0*sigmax/50;
}


void drawInterval(real x, pair pos) {
  draw(pos+(-1.05u*sigmax,0)--pos+(1.05u*sigmax,0), red);
  draw(pos+(0,0)--pos+(0,5.1u/sqrt2pi), red);
  draw(shift(pos)*gauss, red);
  real y = x-0.5*dx;
  guide g = (y,0);
  for(int i=0; i<10; ++i) {
    g = g--(y, u*u1*normal(y));
    y += 0.1*dx;
  }
  g = g--(y, u*u1*normal(y))--(y, 0)--cycle;
  filldraw(shift(pos)*scale(u)*g);
}

struct Freq {
  real midPoint;
  real frequency;
  static Freq Freq(real x, real f) {
    Freq fr=new Freq;
    fr.midPoint = x;
    fr.frequency = f;
    return fr;
  }
}

from Freq unravel Freq;

Freq[] frequencies;

real sum=0;
for(real x=0.0; x<sigmax; x+=dx) {
  frequencies.push(Freq(x+0.5*dx, prob(x+0.5*dx)));
  frequencies.push(Freq(-x-0.5*dx, prob(-x-0.5*dx)));
  sum += prob(x+0.5*dx)+prob(-x-0.5*dx);
}
write(sum);


real[] sep = {100,50,25,12.5,13,10,12,12,14,4,10,10,10,10, 10, 10};
struct Node {
  real freq;
  real midPoint;
  Node leftNode;
  Node rightNode;
  static Node leaf(Freq f) {
    Node l = new Node;
    l.freq = f.frequency;
    l.midPoint = f.midPoint;
    l.leftNode = null;
    l.rightNode = null;
    return l;
  }
  static Node combine(Node l, Node r) {
    Node n = new Node;
    n.freq = l.freq+r.freq;
    n.leftNode = l;
    n.rightNode = r;
    return n;
  }
  void showRecurse(int level, pair pos, align a) {
    if (leftNode==null) {
      drawInterval(midPoint, pos-(0,8));
    } else {
      real dist = sep[level];
      draw((pos+(-dist,-16))--pos--(pos+(dist,-16)));
      fill(circle(pos+(-0.5*dist,-8),5), white);
      fill(circle(pos+(+0.5*dist,-8),5), white);
      label("0", pos+(-0.5*dist,-8));
      label("1", pos+(0.5*dist,-8));
      leftNode.showRecurse(level+1,pos+(-dist,-16), NW);
      rightNode.showRecurse(level+1,pos+(dist,-16), NE);
    }
  }
  void show() {
    showRecurse(0, (0,0), N);
  }
  void showCode(string code, pair pos, real u) {
    if (leftNode==null) {
      label(rotate(90)*Label(code),pos+(u*midPoint,0), N, UnFill);
    } else {
      leftNode.showCode(code+"0", pos, u);
      rightNode.showCode(code+"1", pos, u);
    }
  }
}

bool operator <=(Node lhs, Node rhs)
{
  return lhs.freq <= rhs.freq;
}

bool operator <(Node lhs, Node rhs)
{
  return lhs.freq < rhs.freq;
}

bool operator >=(Node lhs, Node rhs)
{
  return lhs.freq >= rhs.freq;
}


struct Heap
{
  Node[] list;

  int size() {return list.length;}

  bool empty() {return list.length==0;}

  void add(Node v) {
    list.push(v);
    int child = list.length-1;
    int parent;
    while(child>0) {
      parent = quotient(child-1,2);
      if (list[parent]<=list[child])
	break;
      Node tmp = list[child];
      list[child] = list[parent];
      list[parent] = tmp;
      child = parent;
    }
  }

  Node getMin() {return list[0];}

  Node removeMin() {
    Node minElem = list[0];
    list[0] = list[list.length-1];
    list.pop();
    int parent = 0;
    int child = 1;
    while (child<list.length) {
      if (child<list.length-1 && list[child+1]<list[child])
	child += 1;
      if (list[child]>=list[parent])
	break;
      Node tmp = list[child];
      list[child] = list[parent];
      list[parent] = tmp;
      parent = child;
      child = 2*parent+1;
    }
    return minElem;
  }

}

Heap operator init() {return new Heap;}


Heap heap;

for(int i=0; i<frequencies.length; ++i) {
  heap.add(Node.leaf(frequencies[i]));
}

while (heap.size()>1) {
  Node node1 = heap.removeMin();
  Node node2 = heap.removeMin();
  heap.add(Node.combine(node1,node2));
}

Node tree = heap.removeMin();

tree.show();


real offset = -260;
real u2 = 70;

draw((-1.05*sigmax*u2,offset)--(1.05*sigmax*u2,offset), red, Arrow);
label("\Large $\frac{x-\mu}{\sigma}$", (1.05*sigmax*u2,offset), E, red);
draw(shift((0,offset))*yscale(0.835)*scale(u2/u)*gauss, red);
for(real x=0; x<=sigmax; x+=dx) {
  draw((u2*x,offset)--(u2*x, u*u2*normal(x)+offset), red);
  draw((-u2*x,offset)--(-u2*x, u*u2*normal(x)+offset),red);
}


draw((0,offset)--(0, 1.1*u*u2*normal(0)+offset), red, Arrow);
tree.showCode("", (0,offset), u2);
