% imread, imwrite, imresize

% Typically, images are stored with each value represented by a byte (uint8),
% change to (double/single) to keep the prcision when applying filtering operations

% Change 3D array (H,W,3) to 2D (WH,3) with Ivec = reshape(I, width*height, 3)
% Matlab prefers 2D for maximum speed
import Lab3.*;

% Question 2
% OBS, this parts takes some time to run
I2 = imread('tiger1.jpg');
K = 10;               % number of clusters used
L = 25;              % number of iterations
scale_factor = 1.0;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale
iters = 1%00;

Lab3.Q2(I2,K,L,scale_factor,image_sigma,iters)
%keyboard

%% Question 3
clear all;
% first arg = K, second is decrease in K
Lab3.Q3(6,1)
%keyboard

%% Question 4
% args = two K-values
Lab3.Q4(5,10)
%keyboard
%% Question 5
% args = s_band, c_band
I5 = imread('tiger3.jpg');
Lab3.Q5(6,4,I5)
%keyboard

%% Question 7
% args: ncuts_thresh (cutting threshold), min_area (minimum area of
% segment), max_depth (maximum splitting depth), colour_bandwidth 
I7 = imread('orange.jpg');
Lab3.Q7(0.1,80,8,20, I7)        
%keyboard
%% Question 10
% % args: ncuts_thresh (cutting threshold), min_area (minimum area of
% segment), max_depth (maximum splitting depth), colour_bandwidth, radius 
I10 = imread('orange.jpg');
Lab3.Q10(0.1,80,8,20, I10, 4)  
%keyboard
%% Question 11
scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ]; % image region to train foreground with
K = 2;                      % number of mixture components
alpha = 10;%8.0;                 % maximum edge cost
sigma = 4; %10
I11 = imread('tiger1.jpg');
Lab3.Q11(scale_factor, area, K, alpha, sigma, I11)
%keyboard
%%
clear all;
close all;
%{
im = imread('orange.jpg');
[segmentation, centers ]=kmeans_segm(im, 8, 8, 3);
size(im);
class(centers);
%}
K = 6;
scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ];
I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
size(I)
%Iback = I;
area = int16(area*scale_factor);
[h,w,c] = size(I);
dw = area(3) - area(1) + 1;
dh = area(4) - area(2) + 1;
mask = uint8([zeros(area(2)-1,w); zeros(dh,area(1)-1), ones(dh,dw), ...
	     zeros(dh,w-area(3)); zeros(h-area(4),w)]);
size(mask)

fprob = mixture_prob(I, K, 2, mask);
%{
l = [5,6,0;2,0,0]
%l(:,:,2) = [9,8,0; 0,7,0]
%l = reshape(l, 2,6)
o = [1,0,0;1,1,0]
k = find(o==1)
l.*o
%l(~any(l,2),:) =[]
%l(:,~any(l,1))=[]
%}

