import myutil;
import matrix_visualisation;
size(300,0);



Matrix A = Matrix(4, 1, (0,0));
Matrix B = Matrix(1, 3, (2.5,0));
Matrix C = Matrix(4, 3, (7,0));
A.draw();
B.draw();
label("\large $=$", (4.5,0));
C.draw();
picture bg = new picture;
bg.add(currentpicture);

ship();


for(int j=0; j<4; ++j) {
  for(int i=0; i<3; ++i) {
    A.highlight_row(j);
    B.highlight_col(i);
    C.highlight(j,i);
    ship();
    if (i==0 && j==0) {
      show_explicit_calc(j, i, A, B);
      ship();
    }
    erase();
    add(bg);
  }
}
