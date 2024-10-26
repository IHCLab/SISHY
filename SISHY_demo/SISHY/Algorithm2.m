function [E_re,S_re,d_re,Z_re,time] = Algorithm2(X_omega,N)

t1=tic;

[M,L]=size(X_omega);


%inital Z0 by Algorithm1  --------------------------------
[~,~,~,Zi,index,~]=Algorithm1(X_omega,N,'default');
%-------------------iteration-----------------------

for i = 1:10
%Update (Ei, Si, di) by applying PCA on Zi−1
[Si,Ei,di]=PCA(Zi,N);

%update Z with closed form solutin

S=Ei*Si+di*ones(1,L);

%update Z with proximal mapping
Zi(index)=S(index);
Zi(~index)=X_omega(~index);

end
E_re=Ei;%eigen basis
d_re=di;%mean
Z_re=Zi;%reconstruct matrix
S_re=Si;%eigenimage
time = toc( t1);

end

