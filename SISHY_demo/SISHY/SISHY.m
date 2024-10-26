%=====================================================================
% Programmer: Si-Sheng Young
% E-mail: q38121509@gs.ncku.edu.tw
% Date: 04/10/2024
% -------------------------------------------------------
% Reference:
% Signal Subspace Identification for Incomplete Hyperspectral Image with Applications to Various Inverse Problems 
% IEEE Transactions on Geoscience and Remote Sensing
%======================================================================
% Subspace Identification for incomplete data (id)
% [E,S,d,Z,time] = SISHY(X_omega,N,Mode);
%======================================================================
%  Input
%  X_omega is M-by-L data matrix, with missing entries set as 0.
%  N is the number of PCs.
%  Mode: Mode1, Mode2, and Mode3 are corresponding to Algorithm1,
%  Algorithm2, and Algorithm3, respectively.
%----------------------------------------------------------------------
%  Output
%  E is M-by-N basis matrix whose columns are PCs.
%  S is N-by-L coefficient matrix (dimension-reduced data matrix).
%  d is M-by-1 data-mean vector.
%  Z is M-by-L reconstructed data matrix.
%  time is the computation time (in secs).
%========================================================================

function [E,S,d,Z,time] = SISHY(X_omega,N,Mode)

if nargin<3

    Mode='Mode2';
end

    if strcmp(Mode,'Mode1')
        [E,S,d,Z,~,time]=Algorithm1(X_omega,N,'default');
    
    elseif strcmp(Mode,'Mode2')
        [E,S,d,Z,time] = Algorithm2(X_omega,N);
    
    elseif strcmp(Mode,'Mode3')
        [E,S,d,Z,time] = Algorithm3(X_omega,N); 
        % if input image is not a square tensor (e.g., size=sqrt(L),sqrt(L),C)
        % Users need to input the shape of image for PnP denoiseing

    else
        error('Mode error, please reset the mode of SISHY')

    end

end
