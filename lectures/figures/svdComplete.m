M = 0.1*round(50*rand(6,3)*rand(3,8) + 0.1*rand(6,8));
observed = rand(6,8)>0.2;

missing = observed==0;
Visable = M.*observed;
Vmean = sum(Visable,2)./sum(observed,2);
[m,n] = size(Visable);

M1 = Visable + (Vmean*ones(1,n)).*missing;
theta = 2
for i = 1:5
  [U,S,V] = svd(M1);
  R1 = U*diag(S(S>theta), m, n)*V';
  M1 = Visable + R1.*missing;
endfor
