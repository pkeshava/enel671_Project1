%% ENEL 671 Project1
% Pouyan Keshavarzian
% FALL 2016
% https://github.com/pkeshava/enel671_Project1
%
% a(n) - BPSK data source
% h(n) - channel impulse response
% delta1 - channel delay
% delta2 - adaptive filter delay
% w(n) - adaptive filter impulse response
% d(n) = a(n-totaldelta) - desired signal 
% dhat(n) = estimate of desired data
% v(n) - zero mean gaussian noise
%% Pre-Experiment Calculations
% Define Noise matrix 
sigma_squared = 0.0001;
Rv = sigma_squared*eye(11);
% Define impulse response matrix of channels
h = [0.2194 1.0 0.2194;0.2798 1.0 0.2798;0.3365 1.0 0.3365;0.3887 1.0 0.3887];
% calculate values of r for each channel
r = autocorrelation_values(h);
[R1, max1, min1, spread1] = autocorrelation_eigen(r(:,1),Rv);
[R2, max2, min2, spread2] = autocorrelation_eigen(r(:,2),Rv);
[R3, max3, min3, spread3] = autocorrelation_eigen(r(:,3),Rv);
[R4, max4, min4, spread4] = autocorrelation_eigen(r(:,4),Rv);
%% Generate sequence of BPSK data source
a = round(rand(1,1000));
n = size(a,2);
for i=1:n
    if a(i) == 0
        a(i) = -1;
    end
end
%% Calculate u(n)
u = filterinput(a,h);
%% Effect of Eignevalue Spread
% Generate and plot the learning curves for Channels 1,2,3,4

% Run data vector through LMS algorithm 

%% Effect of Filter Order
% Generate and plot MSE with oder M = 9, 11, 21






%% Effect of Step Size Parameter 
% Generate MSE for M = 11, mew = 0.0125, 0.025, 0.075


%% Comparison of Standard LMS and Normalized LMS
% Comparison of Standard LMS and Normalized LMS

