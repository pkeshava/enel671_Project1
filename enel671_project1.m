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
%% Generate sequence of BPSK data source
a = round(rand(1,1000));
n = size(a,2);
for i=1:n
    if a(i) == 0
        a(i) = -1;
    end
end
%% Generate Guassian White Noise Data
y = wgn(11,11,-40);
x = var(y);
%% Define impulse response matrix of channels
h = [0.2194 1.0 0.2194;0.2798 1.0 0.2798;0.3365 1.0 0.3365;0.3887 1.0 0.3887];
%% Calculate R Autocorrleation matrix and associated values for each channel

%Channel 1 
r1_0 = h(1,1)^2+h(1,2)^2+h(1,3)^2;
r1_1 = h(1,1)*h(1,2)+h(1,2)*h(1,3);
r1_2 = h(1,1)*h(1,3);

%Channel 2 
r2_0 = h(2,1)^2+h(2,2)^2+h(2,3)^2;
r2_1 = h(2,1)*h(2,2)+h(2,2)*h(2,3);
r2_2 = h(2,1)*h(2,3);

%Channel 3 
r3_0 = h(3,1)^2+h(3,2)^2+h(3,3)^2;
r3_1 = h(3,1)*h(3,2)+h(3,2)*h(3,3);
r3_2 = h(3,1)*h(3,3);
%% calculate u(n)
u = zeros(3,1000);
% transform each value of a with the three paths and add noise for channel
% 1
for i=1:3
    for j=1:n
        u(i,j) = h(1,i)*a(j);
    end
end
u = awgn(u,40);

%% Pre-Experiment calculations
% Calculate eignevalues for autocorrelation matrix
    % Define tap-input vector u(n)
        % Inner product of channel impulse response with data source +
        % gaussian noise
        % Eigenvalue spread

        
%% Effect of Eignevalue Spread
% Generate and plot the learning curves for Channels 1,2,3,4





%% Effect of Filter Order
% Generate and plot MSE with oder M = 9, 11, 21






%% Effect of Step Size Parameter 
% Generate MSE for M = 11, mew = 0.0125, 0.025, 0.075


%% Comparison of Standard LMS and Normalized LMS
% Comparison of Standard LMS and Normalized LMS

