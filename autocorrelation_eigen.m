 function [R, maxval, minval, spread] = autocorrelation_eigen(r,Rv)
 
% Takes values of autocorrelation matrix and a noise matrix and calculates
% the overall autocorellation along with the eigenvalues.
r = [r' zeros(1,8)];
R = toeplitz(r)+Rv;
[~, D]= eig(R);
minval = min(D(D > 0));
maxval = max(D);
spread= maxval/minval;
end