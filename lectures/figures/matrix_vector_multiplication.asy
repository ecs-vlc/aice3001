import myutil;
import matrix_visualisation;
size(300,0);



Matrix A = Matrix(4, 5, (0,0));
Matrix B = Matrix(5, 1, (4,0));
Matrix C = Matrix(4, 1, (7,0));
A.draw();
B.draw();
label("\large $=$", (5.5,0));
C.draw();
picture bg = new picture;
bg.add(currentpicture);

ship();

for(int j=0; j<4; ++j) {
  int i = 0;
  A.highlight_row(j);
  B.highlight_col(i);
  C.highlight(j,i);
  ship();
  erase();
  add(bg);
}

