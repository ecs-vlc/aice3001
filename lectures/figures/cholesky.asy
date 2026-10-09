real[][] cholesky(real[][] M) {
  int n = M.length;
  real[][] L = copy(M);
  for(int i=0; i<n; ++i) {
    for(int j=i; j<n; ++j) {
      real sum = L[i][j];
      for(int k=i-1; k>=0; --k) {
	sum -= L[i][k]*L[j][k];
      }
      if (i==j) {
	L[i][i] = sqrt(sum);
      } else {
	L[j][i] = sum/L[i][i];
      }
    }
  }
  for(int i=0; i<n; ++i) {
    for(int j=0; j<i; ++j) {
      L[j][i] = 0;
    }
  }
  
  return L;
}

real[] CholSolve(real[][] chol, real[] b) {
  assert(b.length==chol.length, "CholSolve error matrix and vector wrong size");
    
  real[] x = new real[b.length];
  for (int i=0; i<b.length; ++i) {
    x[i] = b[i];
    for (int j=0; j<i; ++j)
      x[i] -= x[j]*chol[i][j];
    x[i] /= chol[i][i];
  }
  return x;
}

real[] CholTransSolve(real[][] chol, real[] b) {
  assert(b.length==chol.length, "CholSolve error matrix and vector wrong size");
    
  real[] x = new real[b.length];
  for (int i=b.length-1; i>=0; --i) {
    x[i] = b[i];
    for (int j=b.length-1; j>i; --j)
      x[i] -= x[j]*chol[j][i];
    x[i] /= chol[i][i];
  }
  return x;
}

real[] CholFullSolve(real[][] chol, real[] b) {
  return CholTransSolve(chol, CholSolve(chol, b));
}
