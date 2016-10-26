%% ENEL 671 Project1
% Pouyan Keshavarzian
% FALL 2016
% https://github.com/pkeshava/enel671_Project1
% LMS algorithm
    % Filter order: M
    % Step-size parameter: mu
    % vector data length: N
    % channel delay + adaptive filter delay: delta
    % number of runs: K
    
clear all
close all
clc
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

%% Effect of Eignevalue Spread
M = 11;
mu = 0.075;
N = 600;
delta=(M-1)/2 + (length(h(1,:))-1)/2;
K = 500;
for k=1:K
    % Generate sequence of BPSK data source
    a = BPSK(N);
    % Calculate u(n)
    u = filterinput(a,h);
    % Run data vector through LMS algorithm for each channel and get calculated
    % error and weight vector
    [e1,W1] = LMS_algorithm(u(:,1),a,mu,delta,M);
    ed1(:,k) = e1.^2;
    MSEE1 = sum(ed1,2)/K;
    [e2,W2] = LMS_algorithm(u(:,2),a,mu,delta,M);
    ed2(:,k) = e2.^2;
    MSEE2 = sum(ed2,2)/K;
    [e3,W3] = LMS_algorithm(u(:,3),a,mu,delta,M);
    ed3(:,k) = e3.^2;
    MSEE3 = sum(ed3,2)/K;
    [e4,W4] = LMS_algorithm(u(:,4),a,mu,delta,M);
    ed4(:,k) = e4.^2;
    MSEE4 = sum(ed4,2)/K;
end 
% Plot learning curves

for MSEE = [MSEE1 MSEE2 MSEE3 MSEE4]
    figure(1)
    semilogy(1:N,MSEE,'LineWidth',2)
    legend('Channel 1','Channel 2','Channel 3','Channel 4')
    grid on
    xlabel('Time (s)');
    ylabel('Mean Squared Error'); 
    title('Effect of Eigenvalue Spread');
    hold on
end
hold off
%% Effect of Filter Order
% Generate and plot MSE with oder M = 9, 11, 21 for channel 2
mu = 0.075;
N = 600;
K = 500;
for M = [9 11 21]
    delta=(M-1)/2 + (length(h(1,:))-1)/2;
    for k=1:K
        a = BPSK(N);
        % Calculate u(n)
        u = filterinput(a,h);
        % LMS
        [e2_2,W2_2] = LMS_algorithm(u(:,2),a,mu,delta,M);
        ed2_2(:,k) = e2_2.^2;
        MSEE2_2 = sum(ed2_2,2)/K;
    end
    figure(2)
    semilogy(1:N,MSEE2_2,'LineWidth',2)
    legend('M = 9','M = 11','M = 21')
    grid on
    xlabel('Time (s)');
    ylabel('Mean Squared Error');
    title('Effect of Filter Order');
    hold on
end
hold off
%% Effect of Step Size Parameter 
% Generate MSE for M = 11, mu = 0.0125, 0.025, 0.075
M = 11;
N = 1600;
delta=(M-1)/2 + (length(h(1,:))-1)/2;
K = 500;
% Generate and plot MSE with oder M = 9, 11, 21 for channel 2
for mu = [0.0125 0.025 0.075]
    for k=1:K
        a = BPSK(N);
        % Calculate u(n)
        u = filterinput(a,h);
        % Recursive LMS
        [e1_2,W1_2] = LMS_algorithm(u(:,1),a,mu,delta,M);
        ed1_2(:,k) = e1_2.^2;
        MSEE1_2 = sum(ed1_2,2)/K;
    end
    figure(3)
    semilogy(1:N,MSEE1_2,'LineWidth',2)
    legend('mu = 0.0125','mu = 0.025','mu = 0.075')
    grid on
    xlabel('Time (s)');
    ylabel('Mean Squared Error');
    title('Effect of Step Size Parameter');
    hold on
end
hold off
%% Comparison of Standard LMS and Normalized LMS
M = 11;
N = 1600;
delta=(M-1)/2 + (length(h(1,:))-1)/2;
K = 500;
% Generate and plot MSE with oder M = 9, 11, 21 for channel 2
for mu = [0.025 0.075]
    for k=1:K
        a = BPSK(N);
        % Calculate u(n)
        u = filterinput(a,h);
        % Recursive LMS
        [e2_3,W2_3] = LMS_algorithm(u(:,2),a,mu,delta,M);
        ed2_3(:,k) = e2_3.^2;
        MSEE2_3 = sum(ed2_3,2)/K;
    end
        figure(4)
        semilogy(1:N,MSEE2_3,'LineWidth',2)
        grid on
        xlabel('Time (s)');
        ylabel('Mean Squared Error');
        hold on
end

for k=1:K
    a = BPSK(N);
    % Calculate u(n)
    u = filterinput(a,h);
    % Recursive LMS
    [e2_n,W2_n] = Normalized_LMS_algorithm(u(:,2),a,delta,M);
    ed2_n(:,k) = e2_n.^2;
    MSEE2_n = sum(ed2_n,2)/K;
end
semilogy(1:N,MSEE2_n,'LineWidth',2)
legend('mu = 0.025','mu = 0.075','Normalized LMS')
title('Comparison of Standard LMS and Normalized LMS');
hold off