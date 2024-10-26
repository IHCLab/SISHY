addpath('../SISHY');addpath('common\');
clear all;close all;clc
%% Data generator setting
mode='Mode2'; % Mode1、Mode2、Mode3 ---> Mode2 is suggested default mode
N =6 ; % Number of principal component
load('data.mat')
sigma = 0.01;
run_PPCA=0;% if run_PPCA=1, this demo will run the peer method, i.e., PPCA
[h,w,c]=size(img_clean);
noise = sigma.*randn(h,w,c);
img_incomplete=(img_clean+noise).*mask_3D;


%% Reference subspace estimation
img_clean_2D=reshape(img_clean,h*w,c)'; % Reshape the 3D image into 2D matrix
img_incomplete_2D=reshape(img_incomplete,h*w,c)';
[~,V,~]=PCA(img_clean_2D,N);


%% SISHY: Algorithm 2
[ E_SISHY,S_SISHY,d_SISHY,Z_SISHY,time_SISHY] = SISHY(img_incomplete_2D,N,mode);

SEP_SISHY = sep_est(V,E_SISHY);
CD_SISHY =  chordal_dis(V,E_SISHY); 

%% PPCA subspace estimation
 if run_PPCA==1
    [E_ppca,d_ppca,~,~] = ppcaEm(img_incomplete_2D,N);

 elseif run_PPCA==0

     load('common\PPCA_result.mat')
 end

SEP_ppca = sep_est(V,E_ppca);
CD_ppca =  chordal_dis(V,E_ppca); 

%% Visualize the recoverd hyperspectral image
image_SISHY=reshape(Z_SISHY',h,w,c); % Reshape the 2D matrix back to 3D image
plot_image(img_clean,img_incomplete,image_SISHY)

fprintf('SEP of ppca :%f\n',SEP_ppca)
fprintf('SEP of SISHY :%f\n',SEP_SISHY)
fprintf('Chordal Distance of ppca :%f\n',CD_ppca)
fprintf('Chordal Distance of SISHY :%f\n',CD_SISHY)

