struct Matrix {
  int no_rows;
  int no_cols;
  pair centre;

  void operator init(int no_rows, int no_cols, pair centre) {
    this.no_rows = no_rows;
    this.no_cols = no_cols;
    this.centre = centre;
  }
  
  pair pos(real row, real col) {
    return centre + (col-0.5*(no_cols-1), 0.5*(no_rows-1)-row);
  }

  void draw_element(int row, int col, pen colour) {
    filldraw(box(pos(row,col)+(-0.2,-0.2), pos(row, col)+(0.2,0.2)), colour, colour);
  }
  
  void draw() {
    real mid = 0.5*(no_rows-1);
    draw(pos(0,0)+(-0.4,0.4)..pos(mid, 0)+(-0.4-0.05*no_rows,0.0)..pos(no_rows-1,0)+(-0.4,-0.4));
    draw(pos(0,no_cols-1)+(0.4,0.4)..pos(mid,no_cols-1)+(0.4+0.05*no_rows,0.0)..pos(no_rows-1,no_cols-1)+(0.4,-0.4));
    for(int col=0; col<no_cols; ++col) {
      for(int row=0; row<no_rows; ++row) {
	draw_element(row, col, gray);
      }
    }
  }

  void highlight_row(int row) {
    for(int col=0; col<no_cols; ++col) {
      draw_element(row, col, red);
    }
  }
  
  void highlight_col(int col) {
    for(int row=0; row<no_rows; ++row) {
      draw_element(row, col, red);
    }
  }

  void highlight(int row, int col) {
    draw_element(row, col, red);
  }
}


void show_explicit_calc(int row, int col, Matrix A, Matrix B) {
  for(int i=0; i<A.no_cols; ++i) {
    draw(A.pos(row,i)--B.pos(i, col), green);
    label("\tiny$\times$", 0.5*(A.pos(row, i)+B.pos(i,col)), green, UnFill);
    if (i<A.no_cols-1){
      label("\tiny $+$", B.pos(i,col)-(0,0.5), green);
    }
  }
}
