% imread, imwrite, imresize

% Typically, images are stored with each value represented by a byte (uint8),
% change to (double/single) to keep the prcision when applying filtering operations

% Change 3D array (H,W,3) to 2D (WH,3) with Ivec = reshape(I, width*height, 3)
% Matlab prefers 2D for maximum speed
clear all;
im = imread('orange.jpg');
size(im)
im(:,:,1);
kmeans_segm(im, 8, 1, 3);
%{
h = [1,3,4,3; 9,9,9,9]
k = h
k(2) = 6
k
h
min(h,[],2)

find(h == 3)
mean(h,1)
%}