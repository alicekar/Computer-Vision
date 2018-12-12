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
iters = 100;

Lab3.Q2_2(I,K,L,scale_factor,image_sigma,iters)
%keyboard
%% Question 2.3
clear all;
Lab3.Q2_3(6,1)

%% Question 2.4
Lab3.Q2_4(5,10)

%%
clear all;
close all;
im = imread('orange.jpg');
size(im)
im(:,:,1);
%kmeans_segm(im, 8, 8, 3);
im(1,1,:)
size(im)
H = size(im,1);
W = size(im,2);
I_flat = reshape(im,H*W,3);
I_flat = double(I_flat);
size(I_flat,1)
I_flat(30000,:)
randi([1 10],1,3)
randperm(size(I_flat,1), 20)
centers = datasample(I_flat,4,'Replace',false)


h = [1,3,4,3; 9,9,9,9];
min(h,[],2);
k = [0,2,3,4;2,3,6,1];
b=h-k;
sum(sum(b));


l = [9,8,7]
zeros(1,10)
o=string(unique(l))
j=num2cell(o)
a=strrep(o,char(91),'')
u = num2cell(a)



    
b={'yes','no','undecided'}

    
    

