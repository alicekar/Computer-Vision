function [Gx, Gy] = difference(type)
    % x is pointing downwards, y to the right
    if strcmpi('central',type)
        Gx = [0 -1/2 0; 0 0 0; 0 1/2 0]; 
        Gy = Gx';
    elseif strcmpi('sobel',type)
        Gx = [-1 -2 -1; 0 0 0; 1 2 1];
        Gy = Gx';
    else
        disp("type must be either 'central' or 'sobel' and size must be 3 or 5")
    end
end