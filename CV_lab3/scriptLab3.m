import Lab3.*;

% Question 2
% OBS, LONG RUNNING TIME DUE TO 100 iters
I2 = imread('tiger1.jpg');
K = 10;               % number of clusters used
L = 25;              % number of iterations
scale_factor = 1.0;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale
iters = 100;

Lab3.Q2(I2,K,L,scale_factor,image_sigma,iters)
%keyboard
%%


% Question 3
clear all;
% first arg = K, second is decrease in K
Lab3.Q3(6,1)
keyboard



% Question 4
% args = two K-values
Lab3.Q4(5,10)
keyboard



% Question 5
% args = s_band, c_band
I5 = imread('tiger3.jpg');
Lab3.Q5(6,4,I5)
keyboard



% Question 7
% args: ncuts_thresh (cutting threshold), min_area (minimum area of
% segment), max_depth (maximum splitting depth), colour_bandwidth 
I7 = imread('orange.jpg');
Lab3.Q7(0.1,80,8,20, I7)        
keyboard



% Question 10
% % args: ncuts_thresh (cutting threshold), min_area (minimum area of
% segment), max_depth (maximum splitting depth), colour_bandwidth, radius 
I10 = imread('orange.jpg');
Lab3.Q10(0.1,80,8,20, I10, 4)  
keyboard



% Question 11
scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ]; % image region to train foreground with
K = 8; %16                      % number of mixture components
alpha = 30;%40;                 % maximum edge cost
sigma = 4;%3;
Lab3.Q11(scale_factor, area, K, alpha, sigma)


