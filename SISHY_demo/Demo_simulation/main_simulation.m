addpath('function');
addpath('../SISHY');
clear all;close all;clc
%% Data generator setting
mode='Mode2'; % Mode1、Mode2、Mode3 ---> Mode2 is suggested default mode
N =6 ; % Number of pure spectral signatures
M = 224; % Number of spectral bands
L = 16900; % Number of pixels
num_run=1; % Number of independent runs for avoiding experimental bias
SNR_range=20:10:50; 
Missing_range=0.1:0.05:0.6;
run_PPCA=0;%if run_PPCA=1, this demo will run the peer method, i.e., PPCA
%% Main Loop
for a=1:length(Missing_range)
    pp=Missing_range(a);

    for i=1:length(SNR_range)
         SNR=SNR_range(i);

        for run=1:num_run
            %% Generating Data and Mask
            [data, ~, ~] = DataGenerator(N,M,L,SNR, 16);% Generated Data lyings on N-1 dimensional subspace
            ind=rand(size(data));
            mask=ones(size(data));
            mask(ind<=pp)=0;
            X=data.*mask;
            V = orth(data); 
            V = V(:,1:N-1);
            
            %% SISHY: Algorithm 2
            [ E_SISHY,S_SISHY,d_SISHY,Z_SISHY,time_SISHY] = SISHY(X,N-1,mode);
           
            SEP_SISHY(run) = sep_est(V,E_SISHY);
            CD_SISHY(run) =  chordal_dis(V,E_SISHY); 
            %% PPCA subspace estimation
            if run_PPCA==1

                [E_ppca,d_ppca,~,~] = ppcaEm(X,N-1);
                
                SEP_ppca(run) = sep_est(V,E_ppca);
                CD_ppca(run) =  chordal_dis(V,E_ppca); 

            end
           
            
        end

        CD(i,a)=mean(CD_SISHY);
        SEP(i,a)=mean(SEP_SISHY);
        
        if run_PPCA==1

            CD_PPCA(i,a)=mean(CD_ppca);
            SEP_PPCA(i,a)=mean(SEP_ppca);

        end
       
    
    end

end
%% Visualize the CD and SEP Curves
if run_PPCA==0
    load('function\PPCA_result.mat')
end

plot_curve(CD,CD_PPCA,SEP,SEP_PPCA,SNR_range,Missing_range)
