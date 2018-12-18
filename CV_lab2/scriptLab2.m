clear all;
import Lab2.*;

% 1. Difference Operators
Lab2.Q1()

%keyboard
%% 2 Point?wise thresholding of gradient magnitudes
Lab2.Q2()
%keyboard
%% 
Lab2.Q3()
%keyboard

%% 4 Computing differential geometry descriptors
Lab2.Q4()
%keyboard
%%
Lab2.Q5()
%keyboard
%% 5 Extraction of edge segments
% Args: scale tools, threshold tools, scale house, threshold house
Lab2.Q7(6,50,2,60)
%keyboard

%% 6 Hough transform
Lab2.Q8()
%keyboard
%%
t = triangle128;
figure(1)
showgrey(t)
figure(2)
c = zerocrosscurves(t-128);
overlaycurves(t, c)
%showgrey(printcurves(t, c));
