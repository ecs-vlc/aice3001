import myutil;
import graph;
import sos;
size(600,0);

real func(real x) {return 0.25*sin(5*x);}

pair[] data = new pair[];
for(int i=0; i<100; ++i) {
  real x = rand()/randMax - 0.5;
  real y = func(x) + 0.1*rand()/randMax - 0.05;
  data.push((x,y));
}

picture bg = new picture;

real min_x = -0.5;
real max_x = 0.5;

bool less(pair p1, pair p2) {
  return p1.x<p2.x;
}



/* Structures to support decision tree */

Sos compute_sos(pair[] arr) {
  Sos sos = Sos();
  for(int i=0; i<arr.length; ++i) {
    sos.add(arr[i].y);
  }
  return sos;
}


struct Split {
  real diff;
  int i;
  int id;
  
  static Split Split(real diff, int i, int id) {
    Split split = new Split;
    split.diff = diff;
    split.i = i;
    split.id = id;
    return split;
  }

  void print() {
    write("Split");
    write(this.diff, this.i, this.id);
  }
}

from Split unravel Split;

real logvar(Sos sos) {
  if (sos.var_n()<=0.0) {
    return 0.0;
  } else {
    return 0.5*sos.cnt*log(sos.var_n());
  }
}

struct Leaf {
  pair[] data;
  real min;
  real max;
  Sos sos;
  int id;

  static Leaf Leaf(pair[] data, real min, real max, Sos sos, int id) {
    Leaf leaf = new Leaf;
    leaf.data = data;
    leaf.min = min;
    leaf.max = max;
    leaf.sos = sos;
    leaf.id = id;
    return leaf;
  }

  Split bestSplit() {
    if (this.data.length==1) {
      return(Split(-50,0,0));
    }
    real var = this.sos.var_n();
    //    real lv = logvar(this.sos);
    Sos left = Sos();
    Sos right = this.sos.copy();
    int best_i = 0;
    real best_diff = 0.0;
    for(int i=0; i<this.data.length-1; ++i) {
      left.add(this.data[i].y);
      right.subtract(this.data[i].y);
      // real diff = lv - logvar(left) - logvar(right);
      real diff = var - max(left.var_n(), right.var_n());
      if (diff>best_diff) {
	best_diff = diff;
	best_i = i;
      }
    }
    return Split(best_diff, best_i, this.id);
  }

  Leaf[] split(int split_i) {
    pair[] left = new pair[];
    pair[] right = new pair[];
    for(int i=0; i<this.data.length; ++i) {
      if (i<=split_i) {
	left.push(this.data[i]);
      } else {
	right.push(this.data[i]);
      }
    }
    Sos sos_left = compute_sos(left);
    Sos sos_right = compute_sos(right);
    real div = 0.5*(this.data[split_i].x+this.data[split_i+1].x);
    Leaf[] leaves;
    leaves.push(Leaf(left, min, div, sos_left, 2*id));
    leaves.push(Leaf(right, div, max, sos_right, 2*id+1));
    return leaves;
  }
}

from Leaf unravel Leaf;

struct Node {
  Node left;
  Node right;
  Node parent;
  Leaf leaf;
  string rule;

  static Node Node(Leaf leaf=null, Node left=null, Node right=null, Node parent=null, string rule="") {
    Node n = new Node;
    n.leaf = leaf;
    n.left = left;
    n.right = right;
    n.parent = parent;
    return n;
  }

  void print() {
    write("Node");
    if (this.leaf !=null) {
      write("Leaf");
      write(this.leaf.id, this.leaf.sos.cnt, this.leaf.min, this.leaf.max);
    } else {
      write("Left");
      this.left.print();
      write("Right");
      this.right.print();
    }
  }

}

from Node unravel Node;

struct FunctionApprox {
  pair[] steps;

  void push(real x, real y) {
    this.steps.push((x,y));
  }
  
  void draw(string comment="") {
    guide g;
    real last = steps[0].y;
    bool print = false;
    bool up = false;
    for(int i=0; i<steps.length; ++i) {
      if (!print && up && steps[i].y>0 && steps[i].y<last) {
	if (steps[i].x>0.4)
	  label("\Huge " + comment, (steps[i].x, steps[i-1].y), NW);
	else
	   label("\Huge " + comment, (steps[i].x, steps[i-1].y), NE);
	print = true;
      }
      if (!print && i==steps.length-1) {
	label("\Huge " + comment, (0.48, steps[i].y), NW);
	print = true;
      }
      g = g--(steps[i].x, last)--steps[i];
      up = steps[i].y>last;
      last = steps[i].y;
    }
    g = g--(0.5, last);
    draw(g, darkgreen+linewidth(3));
  }
  
  void add(FunctionApprox f2) {
    real f1value = this.steps[0].y;
    real f2value = f2.steps[0].y;
    real x = this.steps[0].x;
    pair[] f = new pair[];
    f.push((x, f1value+f2value));
    int k1 = 1;
    int k2 = 1;
    while (true) {
      if (k1==this.steps.length) {
	for(; k2<f2.steps.length; ++k2)
	  f.push(f2. steps[k2]+(0,f1value));
	steps = f;
	return;
      }
      if (k2==f2.steps.length) {
	for(; k1<this.steps.length; ++k1)
	  f.push(this.steps[k1]+(0,f2value));
	steps = f;
	return;
      }
      if (this.steps[k1].x<f2.steps[k2].x) {
	x = this.steps[k1].x;
	f1value = this.steps[k1].y;
	++k1;
      } else {
	x = f2.steps[k2].x;
	f2value = f2.steps[k2].y;
	++k2;
      }
      f.push((x, f1value+f2value));
    }
    steps = f;
  }
}

FunctionApprox fapprox = new FunctionApprox;
fapprox.push(-0.5,0);

struct Tree {
  Node root;

  static Tree Tree(pair[] data, real min_x, real max_x) {
    Tree t = new Tree;
    data = sort(data, less);
    Sos sos = compute_sos(data);
    Leaf l = Leaf(data, min_x, max_x, sos, 1);
    t.root = Node(Leaf(data, min_x, max_x, sos, 1));
    return t;
  }

  Node leftMost() {
    Node n = this.root;
    while (n.left != null) {
      n = n.left;
    }
    return n;
  }
  
  Node next_node(Node n) {
    Node p = n.parent;
    if (p==null) {
      return null;
    }
    while (p.right == n) {
      n = p;
      p = n.parent;
      if (p==null) {
	return null;
      }
    }
    n = n.parent.right;
    while (n.left != null) {
      n= n.left;
    }
    return n;
  }

  void split() {
    Node n = this.leftMost();
    Split best_split = n.leaf.bestSplit();
    n = this.next_node(n);
    while (n!=null) {
      Split split = n.leaf.bestSplit();
      if (split.diff > best_split.diff) {
	best_split = split;
      }
      n = this.next_node(n);
    }
    //    best_split.print();
    n = this.leftMost();
    while (n.leaf.id != best_split.id) {
      n = this.next_node(n);
    }
    Leaf[] leaves = n.leaf.split(best_split.i);
    Node left = Node(leaves[0], parent=n);
    Node right = Node(leaves[1], parent=n);
    n.leaf = null;
    n.rule = "$x>" + string(leaves[0].max, 2) + "$";
    n.left = Node(leaves[0], parent=n);
    n.right = Node(leaves[1], parent=n);
  }

  FunctionApprox funcApprox() {
    FunctionApprox fa = new FunctionApprox;
    Node n = this.leftMost();
    while (true) {
      fa.steps.push((n.leaf.min, n.leaf.sos.mean()));
      n = this.next_node(n);
      if (n==null)
	break;
    }
    return fa;
  }

  pair[] diff() {
    pair[] data = new pair[];
    Node n = this.leftMost();
    while (true) {
      for (int i=0 ; i<n.leaf.data.length; ++i) {
	data.push(n.leaf.data[i] - (0.0, n.leaf.sos.av));
      }
      n = this.next_node(n);
      if (n==null)
	break;
    }
    return data;
  }

  void subTree(Node n, pair pos, real space) {
    if (n.leaf == null) {
      pair left_pos = pos+(-space, -0.07);
      pair right_pos = pos+(space, -0.07);
      draw(left_pos--pos--right_pos);
      label(n.rule, pos, UnFill);
      subTree(n.left, left_pos, 0.5*space);
      subTree(n.right, right_pos, 0.5*space);
    } else {
      label(string(n.leaf.sos.av, 2), pos, UnFill);
    }
  }
  
  void decisionTree() {
    Node n = this.root;
    this.subTree(n, (-0.25, 0.28), 0.09);    
  }
}

from Tree unravel Tree;

/** Compute Tree **/

picture background(pair[] data, bool groundTruth=false) {
  picture bg = new picture;
  if (groundTruth)
    draw(bg, graph(func, -0.5, 0.5), dashed+lightblue);
  xaxis(bg, "\Large $x$",  -0.51, 0.51, Arrow);
  yaxis(bg, "\Large $y$", -0.33, 0.33, Arrow);

  for(int i=0; i<data.length; ++i) {
    dot(bg, data[i], red+linewidth(4));
  }
  return bg;
}

pair[]  step(pair[] data, picture bg, string s="") {
  Tree tree = Tree(data, min_x, max_x);
  for(int i=0; i<3; ++i) {
    tree.split();
  }
  erase();




  add(bg);
  FunctionApprox fa = tree.funcApprox();
  fa.draw(s);
  fapprox.add(fa);
  tree.decisionTree();
  ship();
  erase();
  return tree.diff();
}

void combined(FunctionApprox fa, pair[] data, string s="") {
  erase();
  draw(graph(func, -0.5, 0.5), dashed+lightblue);
  xaxis("\Large $x$",  -0.51, 0.51, Arrow);
  yaxis("\Large $y$", -0.33, 0.33, Arrow);

  for(int i=0; i<data.length; ++i) {
    dot(data[i], red+linewidth(4));
  }

  fa.draw(s);
  ship();
  erase();
}

picture bg = background(data, true);
add(bg);
ship();

pair[] data1 = step(data, bg, "$C_1(x) = \hat{h}_1(x)$");
picture bg1 = background(data1);
add(bg1);
ship();



pair[] data2 = step(data1, bg1, "$\hat{h}_2(x)$");

combined(fapprox, data, "$C_2(x) = \hat{h}_1(x) + \hat{h}_2(x)$");

picture bg2 = background(data2);
add(bg2);
ship();
pair[] data2 = step(data2, bg2, "$\hat{h}_3(x)$");
picture bg2 = background(data2);
add(bg2);
ship();

combined(fapprox, data, "$C_3(x) = \hat{h}_1(x) + \hat{h}_2(x) + \hat{h}_3(x)$");
