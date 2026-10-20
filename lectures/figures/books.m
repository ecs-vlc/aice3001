
M =  [[51, 101, 5, 10, 3, 1]; [51, 103, 2, 8, 0, 0]; [22, 51, 60, 72, 5, 7]; [0, 70, 90, 50, 3, 3]; [0, 1, 51, 92, 2, 0]; [0, 4, 5, 1, 161, 89]; [0, 1, 3, 1, 35, 2]];
[U,S,V] = svd(M);
[m,n] = size(M);
A = U*diag(S(S>100), m, n);
A = -A(:,1:3)/10;
B = -10*V(:,1:3)';

cStyleArray(A);
cStyleArray(B);

A(A<0)=0;
B(B<0)=0;
recError = norm(M-A*B)
r= 0.002;
for t = 1:100  
  B = B -r*(-A'*M + A'*A*B);
  A = A -r*(-M*B' + A*B*B');
  A(A<0)=0;
  B(B<0)=0;
endfor
recError = norm(M-A*B)

cStyleArray(A);
cStyleArray(B);

