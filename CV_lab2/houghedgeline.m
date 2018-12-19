function [linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, ...
                     nrho, ntheta, nlines, dt_bin, K_bin, verbose, power)
    curves = extractedge(pic, scale, gradmagnthreshold);
    smooth_pic = discgaussfft(pic, scale);
    magnitude = sqrt(Lv(smooth_pic, 'sobel'));
    %magnitude = magnitude(magnitude > gradmagnthreshold);
    if nargin < 10
        [linepar, acc] = houghline(curves, magnitude, nrho, ntheta,... 
                           gradmagnthreshold, nlines, dt_bin, K_bin, verbose);
    else
        [linepar, acc] = houghline(curves, magnitude, nrho, ntheta,... 
                           gradmagnthreshold, nlines, dt_bin, K_bin, verbose, power);
    end
end