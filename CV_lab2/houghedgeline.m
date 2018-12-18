function [linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, ...
                     nrho, ntheta, nlines, verbose)
    curves = extractedge(pic, scale, gradmagnthreshold);
    smooth_pic = discgaussfft(pic, scale);
    magnitude = sqrt(Lv(smooth_pic, 'sobel'));
    %magnitude = magnitude(magnitude > gradmagnthreshold);
    [linepar, acc] = houghline(curves, magnitude, nrho, ntheta,... 
                           gradmagnthreshold, nlines, verbose);
end