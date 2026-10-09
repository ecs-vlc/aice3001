import myutil;
import graph;

size(500,0);

real dx = 0.1;
real sqrth = sqrt(0.5);
real u = 3;
real u1 = 2;
real sigmax = 4;

real prob(real x) {
  return 0.5*(erfc(x*sqrth)-erfc((x+dx)*sqrth));
}

real sqrt2pi = sqrt(2*pi);

real normal(real x) {
  return exp(-0.5*x*x)/sqrt2pi;
}


struct Freq {
  int interval;
  real frequency;
  static Freq Freq(int interval, real f) {
    Freq fr=new Freq;
    fr.interval = interval;
    fr.frequency = f;
    return fr;
  }
}

from Freq unravel Freq;

struct Node {
  real freq;
  int interval;
  Node leftNode;
  Node rightNode;
  static Node leaf(Freq f) {
    Node l = new Node;
    l.freq = f.frequency;
    l.interval = f.interval;
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

  void computeLengths(int length, int[] posLength, int[] negLength) {
    if (leftNode==null) {
      if (interval>=0) {
	posLength[interval] = length;
      } else {
	negLength[-interval-1] = length;
      }
    } else {
      leftNode.computeLengths(length+1, posLength, negLength);
      rightNode.computeLengths(length+1, posLength, negLength);
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

real u=0.15;
int maxLength = 25;



draw((-1.05*sigmax,0)--(1.05*sigmax,0), Arrow);
draw((0,0)--(0,1.1*u*maxLength), Arrow);
label("$\displaystyle \frac{x-\mu}{\sigma}$", (1.05*sigmax,0), E);
label("Huffman code length", (-0.1,1.1*u*maxLength), NW, red);
label("$-\log_2(\mathbb{P}(X)) = -\log_2\!\left(\mathcal{N}(x_i|\mu,\sigma)\,\Delta x\strut\right)$",
      (0.1,1.1*u*maxLength-0.08), NE, blue);
dot((1.3*sigmax,0), white);

bool half = false;
for(real x=-sigmax; x<=sigmax; x+=0.5) {
  real down = (half)? -0.05:-0.1;
  draw((x,0)--(x,down));
  if (!half)
    label(string(x,2), (x,down), S);
  half = !half;
}

for(int i=1; i<=maxLength; i+=1) {
  if (i%5==0) {
    draw((0,u*i)--(-0.1, u*i));
    label(string(i), (-0.1, u*i), W);
  } else {
    draw((0,u*i)--(-0.05, u*i));
  }
}

real logProb(real x) {
  return (0.5*x*x + 0.5*log(2*pi) - log(dx))/log(2);
}


for (dx = 0.1; dx>0.0005; dx*=0.1) {
  Heap heap;

  Freq[] frequencies;

  real sum=0;
  int noInterval = floor(sigmax/dx);
  for(int interval=0; interval<noInterval; ++interval) {
    real p = prob(interval*dx);
    frequencies.push(Freq(interval, p));
    frequencies.push(Freq(-interval-1, p));
    sum += 2*p;
  }
  write(sum);

  for(int i=0; i<frequencies.length; ++i) {
    heap.add(Node.leaf(frequencies[i]));
  }

  while (heap.size()>1) {
    Node node1 = heap.removeMin();
    Node node2 = heap.removeMin();
    heap.add(Node.combine(node1,node2));
  }

  Node tree = heap.removeMin();
  int[] posLength = new int[noInterval];
  int[] negLength = new int[noInterval];

  tree.computeLengths(0, posLength, negLength);

  int lastPos = posLength[0];
  guide gpos = (0,u*lastPos);
  int lastNeg = negLength[0];
  guide gneg = (0,u*negLength[0]);
  for(int i=0; i<noInterval; ++i) {
    real x = i*dx;
    if (posLength[i]!=lastPos) {
      gpos = gpos--(x,u*lastPos)--(x,u*posLength[i]);
      lastPos = posLength[i];
    }
    if (negLength[i]!=lastNeg) {
      gneg = gneg--(-x,u*lastNeg)--(-x,u*negLength[i]);
      lastNeg = negLength[i];
    }
  }
  draw(gpos, red);
  draw(gneg, red);


  draw(yscale(u)*graph(logProb, -4,4, operator..), blue+dashed);
  label(rotate(40)*Label("$\Delta x = " + string(dx,4) + "\sigma$"), (4, u*logProb(4)+0.1), E);
  ship();
}
