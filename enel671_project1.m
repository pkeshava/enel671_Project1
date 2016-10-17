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

%% Set experiment conditions
% Filter order M
M = 11;
% Step size mu
mu = 0.075;
% Data length N
N = 600;
% Define delay as seen by the desired signal
delta=(M-1)/2 + (length(h(1,:))-1)/2;
% Number of iterations for experiment
K = 500;
%% Generate sequence of BPSK data source
for k=1:K
    a = round(rand(1,N));
    for i=1:N
       if a(i) == 0
           a(i) = -1;
        end
    end
% Calculate u(n)
u = filterinput(a,h);

% Effect of Eignevalue Spread
% Generate and plot the learning curves for Channels 1,2,3,4


% Run data vector through LMS algorithm for each channel and get calculated
% error and weight vector
[e1,W1] = LMS_P1(u(:,1),a,mu,delta,M);
ed1(:,k) = e1.^2;
MSEE1 = sum(ed1,2)/K;
[e2,W2] = LMS_P1(u(:,2),a,mu,delta,M);
ed2(:,k) = e2.^2;
MSEE2 = sum(ed2,2)/K;
[e3,W3] = LMS_P1(u(:,3),a,mu,delta,M);
ed3(:,k) = e3.^2;
MSEE3 = sum(ed3,2)/K;
[e4,W4] = LMS_P1(u(:,4),a,mu,delta,M);
ed4(:,k) = e4.^2;
MSEE4 = sum(ed4,2)/K;
end 
% Plot it 

for MSEE = [MSEE1 MSEE2 MSEE3 MSEE4]
    figure(1)
    semilogy(1:N,MSEE,'LineWidth',2)
    legend('Channel 1','Channel 2','Channel 3','Channel 4')
    grid on
    xlabel('Time (s)');
    ylabel('Mean Squared Error'); 
    hold on
end
hold off
%% Effect of Filter Order
% Generate and plot MSE with oder M = 9, 11, 21 for channel 2
for M = [9 11 21]
for k=1:K
    a = round(rand(1,N));
    for i=1:N
       if a(i) == 0
           a(i) = -1;
        end
    end
% Calculate u(n)
u = filterinput(a,h);
% Recursive LMS
[e2_2,W2_2] = LMS_P1(u(:,2),a,mu,delta,M);
ed2_2(:,k) = e2_2.^2;
MSEE2_2 = sum(ed2_2,2)/K;
end
figure(2)
semilogy(1:N,MSEE2_2,'LineWidth',2)
legend('M = 9','M = 11','M = 21')
grid on
xlabel('Time (s)');
ylabel('Mean Squared Error');
hold on
end
hold off
%% Effect of Step Size Parameter 
% Generate MSE for M = 11, mew = 0.0125, 0.025, 0.075


%% Comparison of Standard LMS and Normalized LMS
% Comparison of Standard LMS and Normalized LMS

