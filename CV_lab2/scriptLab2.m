clear all;
import Lab2.*;

% 1. Difference Operators
Lab2.Q1()
keyboard

% 2 Point-wise thresholding of gradient magnitudes
Lab2.Q2()
keyboard
 
Lab2.Q3()
keyboard

% 4 Computing differential geometry descriptors
Lab2.Q4()
keyboard

Lab2.Q5()
keyboard

% 5 Extraction of edge segments
% Args: scale tools, threshold tools, scale house, threshold house
Lab2.Q7(6,50,2,60)
keyboard

% 6 Hough transform
% Args: pic, scale, threshold, nrho, ntheta, nlines, bin_smooth, K_bin, verbose
pic1 = triangle128;
Lab2.Q89(pic1,20, 20, 400, 300, 3, 0.1, 10, 2)
keyboard

pic2 = houghtest256;
Lab2.Q89(pic2, 1, 40, 700, 500, 7, 0.5, 18, 2)
keyboard

pic3 = few256;
Lab2.Q89(pic3, 0.5, 80, 800, 50, 10, 0, 0, 0) 
keyboard

pic4 = phonecalc256;
Lab2.Q89(pic4, 10, 30, 1200, 40, 10, 0, 0, 0) 
keyboard

pic5 = godthem256;
Lab2.Q89(pic5, 3, 60, 900, 40, 18, 0, 0, 0) 

%%
% OBS, TIME CONSUMING, corresponds to graph in question 9
Lab2.time()

%%
% Args: pic, scale, threshold, nrho, ntheta, nlines, bin_smooth, K_bin,
% verbose, power
pic4 = phonecalc256;
Lab2.Q10(pic4, 10, 30, 1200, 40, 10, 0, 0, 0, 1)

