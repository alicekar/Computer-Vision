% Author: Alice Karnsund

% To speed of the presentation of your labs you must create a script such 
% that the lab can easily be reproduced. For the purpose of presentation 
% you can interrupt the script at certain points of execution, so that the 
% intermediate results can be presented. This can be done using the 
% commands keyboard, pause or input. In many cases the first command is 
% preferable, since it allows Matlabs command window to be accessed.
import Lab1.*;
%%
Lab1.question1();
%keyboard;
%%
Lab1.question2();
%keyboard
%%
Lab1.question5();
%keyboard
%%
% Question: fftshift simply shifts the zero-frequency component to center 
% of spectrum, by swapping the first and third quadrants and second and
% fourth quadrants. This operation, placing the zero-frequency in the
% middle, with increasing frequency the further away we go, facilitates the
% understanding of different operations. The dynamic range of an image can 
% be compressed by replacing each pixel value with its logarithm. This has
% the effect that low intensity pixel values are enhanced, making the
% picture brighter. Since the logarithm is not defined at 0, the constant 1
% is added. If the constant value take on lower values the intensity in the
% frequency domain is enhanced. 
% https://homepages.inf.ed.ac.uk/rbf/HIPR2/pixlog.htm

Lab1.question7();
%keyboard
%%
% Question: The operation F.*G performs a element-wise multiplication for 
% the matrix elements of F and G. Since F and G only contain pixel values 
% that are 0 (black) or 1 (white), the resulting matrix will only be white 
% where both F and G are white, i.e. in the center square, 16x16. 
Lab1.question10();
%keyboard

%%
Lab1.question11();
%keyboard

%%
%angles = [0,30,45,60,90];
angles = [0,45,60];
Lab1.question12(angles);
%keyboard

%%
Lab1.question13();
