import myutil;
size(280, 70,IgnoreAspect);

int[] prob = {1,1,1,1,2,2};
string[] code = {"000", "001", "010", "011", "10", "11"};



pen[] col={black, black, black, black};

for(int j =0; j<=4; ++j) {
  label("$X_i$:", (-1,0), W, col[0]);
  label("$p(X_i)$:", (-1,-1), W, col[1]);
  label("Code:", (-1,-2), W, col[2]);
  label("$L= -\log_2\left(\strut p(X_i)\right)$:", (-1,-3), W, col[3]);
  for(int i=0; i<6;++i) {
    label(string(i+1), (i,0), col[0]);
    label("$\tfrac{1}{" + string(8/prob[i],1) + "}$", (i,-1), col[1]);
    label(code[i], (i,-2), col[2]);
    label(string(4-prob[i]), (i,-3), col[3]);
  }
  ship();
  erase();
  for(int p=0; p<4; ++p) {
    col[p] = black;
  }
  col[j] = red;
}

