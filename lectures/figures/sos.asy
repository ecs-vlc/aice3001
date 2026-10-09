struct Sos {
  int cnt;
  real av;
  real nvar;

  static Sos Sos() {
    Sos sos = new Sos;
    sos.cnt = 0;
    sos.av = 0.0;
    sos.nvar = 0.0;
    return sos;
  }

  void add(real x) {
    real delta = (x-this.av)/(this.cnt+1.0);
    this.nvar += this.cnt*delta*(x-this.av);
    this.av += delta;
    ++this.cnt;
  }

  void subtract(real x) {
    real delta = x-this.av;
    this.av -= delta/(this.cnt-1);
    this.nvar -= this.cnt*delta*delta/(this.cnt-1);
    --this.cnt;
  }

  Sos copy() {
    Sos sos = Sos();
    sos.cnt = this.cnt;
    sos.av = this.av;
    sos.nvar = this.nvar;
    return sos;
  }
  
  real var() {return (this.cnt>1)? this.nvar/(this.cnt-1):0.0;}
  real var_n() {return this.nvar/this.cnt;}
  real sd() {return sqrt(this.var());}
  real err() {return sqrt(var()/this.cnt);}
  real sum() {return this.av*this.cnt;}
  real mean() {return av;}
  void print() {write(this.cnt, this.av, this.nvar, this.var());}

};

from Sos unravel Sos;
