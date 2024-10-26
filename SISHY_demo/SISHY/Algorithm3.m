function [E_re,S_re,d_re,Z_re,time] = Algorithm3(X_omega,N,H,W)

t1=tic;
net = denoisingNetwork("DnCNN");

[M,L]=size(X_omega);


if nargin==2
    H=sqrt(L);
    W=sqrt(L);
end


%inital Z0 by Algorithm1  --------------------------------
[~,~,~,Zi,index,~]=Algorithm1(X_omega,N,'default');
%-------------------iteration-----------------------

for i = 1:10
%Update (Ei, Si, di) by applying PCA on Zi−1
[Si,Ei,di]=PCA(Zi,N);

%update Z with closed form solutin

Si_tensor=reshape(Si',H,W,N);% defaultly consider the input are square tensor
for j=1:N
    Si_tensor(:,:,j) = denoiseImage(Si_tensor(:,:,j),net);% gray-level image denoising
end
Si=reshape(Si_tensor,L,N)';% reshape the 3D-tensor back to 2D form
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