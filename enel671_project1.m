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

