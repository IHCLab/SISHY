function er = sep_est(U_tr,U_es)  
[n,r] = size(U_tr);
% Nguyen, Viet-Dung, Karim Abed-Meraim, Nguyen Linh-Trung, and Rodolphe Weber.
% "Generalized minimum noise subspace for array processing."
%  IEEE Transactions on Signal Processing 65, no. 14 (2017): 3789-3802.
U_tr = orth(U_tr);
U_es = orth(U_es);
er   = abs(trace(U_es' * (eye(n)-U_tr*U_tr') * U_es)/trace(U_es'*(U_tr*U_tr')*U_es));



