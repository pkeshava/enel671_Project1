function   [e_n,W_n]= Normalized_LMS_algorithm(u,d,delta,M)
%% REQUIRES
    
    % u: tap-input vector
    % d: desired signal vector
    % delta: delay of channel
    % M: filter order
% Returns    
    % W: Tap weight vector
    % e: estimation error (Nx1)
    
W_n = zeros(M,1);
N = length(u);
u = u(:);
d = d(:);

for n=M:N
    u_vec = u(n:-1:n-M+1);
    e(n) = d(n-delta)- W_n'*u_vec;
    W_n = W_n+1/(norm(u_vec)^2)*u_vec*e(n);
end
e_n = e(:);
end