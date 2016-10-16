function   [e,W]= LMS_P1(u,d,mu,delta,M);
 
% mu: step size
% M: filter length
% W: initial values for filter coefficients (Mx1)
% e: estimation error (Nx1)
% u: tap-input signal
% d: desired signal
% delat: delay of channel
W= zeros(M,1);
N=length(u);
u=u(:);
d=d(:);
for n=M:N
    uvec=u(n:-1:n-M+1);
    e(n)=d(n-delta)-W'*uvec;
    W=W+mu*uvec*e(n);
end
e=e(:);
end