function [E,S,d,Zi,index,time]=Algorithm1(X_omega,N,Omega)
%% Initialize the missing index
t1=tic;
[M,L]=size(X_omega);

if strcmp(Omega,'default')
X_omega(X_omega==0)=nan;
index=isnan(X_omega);%index matrix of missing data 
else
    index=Omega;
end
%% main algorithm
d=mean(X_omega,2,'omitnan');%mean except Nan
X_omega(index) = 0;%Replace NaN in X_HSI_2D to 0 
U_hat=(X_omega-d*ones(1,L));% approximated mean-removed data
U_hat(index)=0;% U_hat=X_omega-d1_L on omega and 0 on omega_bar
C=(U_hat*U_hat')./((~index)*(~index)');
C(isinf(C))=0;%avoid numerical error
C(isnan(C))=0;%avoid numerical error
[eV ~] = eig(C);
E= eV(:,M-N+1:end);
S=E'*U_hat;
Zi = E*(S)+d*ones(1,L);%z_inital= E_est*S_est + mean
time = toc( t1);