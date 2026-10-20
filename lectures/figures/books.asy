// Rank-3 SVD and NMF of a words x books count matrix.
// Numbers from books.py (writes books_data.asy); replaces books.m.
size(650,0);
include "books_data.asy";

string[] books = {"Euclid", "Gauss", "Feynman", "Newton", "Darwin", "Mendel"};

string[] words = {"theorem", "proof", "sum", "vector", "wave", "species", "fitness"};

real[][] counts = {{51, 101, 5, 10, 3, 1}, {51, 103, 2, 8, 0, 0}, {22, 51, 60, 72, 5, 7}, {0, 70, 90, 50, 3, 3}, {0, 1, 51, 92, 2, 0}, {0, 4, 5, 1, 161, 89}, {0, 1, 3, 1, 35, 2}};


void bracket(pair pos1, pair pos2, real d) {
  draw(pos1..0.5*(pos1+pos2)+(d,0)..pos2, linewidth(1.2));
}

real u = 1.2;

void DrawMatrix(pair pos, real[][] M, string[] row, string[] col, bool counts=false) {
  int m = row.length;
  int n = col.length;

  for(int b=0; b<n; ++b) {
    label(rotate(90)*Label(col[b]), pos+(u*(b-0.2), 1), N, red);
  }

  for(int w=0; w<m; ++w) {
    label(row[w], pos+(-u, -w), W, red);
    for(int b=0; b<n; ++b) {
      label(counts ? string(round(M[w][b])) : format("%#.1f", M[w][b]), pos+(u*b, -w), W);
    }
  }

  bracket(pos+(-0.8u,0.5), pos+(-0.8u, -m+0.5), -0.2);
  bracket(pos+((n-0.95)*u,0.5), pos+((n-0.95)*u, -m+0.5), 0.2);
}

DrawMatrix((0,0), counts, words, books, counts=true);



string[] rank = {"1", "2", "3"};

label("\Huge$\approx$", (8.1,-3));

DrawMatrix((12,0), A, words, rank);
DrawMatrix((17,0), B, rank, books);

shipout("books");
erase();

DrawMatrix((0,0), counts, words, books, counts=true);



label("\Huge$\approx$", (8.1,-3));

DrawMatrix((12,0), A1, words, rank);
DrawMatrix((17,0), B1, rank, books);

shipout("booksNN");

// without this, asy ships the last picture again as books.pdf at exit
erase();
