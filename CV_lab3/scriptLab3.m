% imread, imwrite, imresize

% Typically, images are stored with each value represented by a byte (uint8),
% change to (double/single) to keep the prcision when applying filtering operations

% Change 3D array (H,W,3) to 2D (WH,3) with Ivec = reshape(I, width*height, 3)
% Matlab prefers 2D for maximum speed
import Lab3.*;

% OBS, this parts takes some time to run
%I = imread('orange.jpg');
I = imread('tiger1.jpg');
K = 10;               % number of clusters used
L = 25;              % number of iterations
scale_factor = 1.0;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale
iters = 1%00;

Lab3.Q2(I,K,L,scale_factor,image_sigma,iters)
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
I = imread('orange.jpg');
Lab3.Q5(7,4,I)
%keyboard

%%
clear all;
close all;
im = imread('orange.jpg');
size(im)
im(:,:,1);
[segmentation, centers ]=kmeans_segm(im, 8, 8, 3);
im(1,1,:)
size(im)
class(centers)


