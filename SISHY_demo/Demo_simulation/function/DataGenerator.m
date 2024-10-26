function [OBS, A, S_NL] = DataGenerator(N,M,L,SNR, seed_num)

load seed 
seed = seed(seed_num);
load S_6maps
load KK_simulation_Library_21endmembers_20140303;
A_sp2 = KK_simulation_Library_21endmembers_20140303;
A_sp2 = KK_simulation_Library_21endmembers_20140303(:,[ 4 6 7 11 12 13]); 
A = A_sp2(:,1:N);
OBS = A*S_NL ; 

%% add noise
if SNR < 100
varianc = sum(OBS(:).^2)/10^(SNR/10) /M/L ; % sigma^2
Cn = diag( varianc*ones(M,1) ); %  DIAG(sigma^2), if eta=0
randn('state',seed);
n = sqrtm(Cn)*randn([M L]);
OBS = OBS+n; 
end
OBS(OBS<0) = 0;