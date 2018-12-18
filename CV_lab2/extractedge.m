function edgecurves = extractedge(inpic, scale, threshold, shape)
    if nargin < 3
        shape = 'same';
        threshold = 0;
    elseif nargin < 4
        shape = 'same';
    end
    smooth_pic = discgaussfft(inpic, scale);
    gradmagn = sqrt(Lv(smooth_pic, 'sobel'));
    
    Lvv = Lvvtilde(smooth_pic,shape);
    Lvvv = Lvvvtilde(smooth_pic,shape);
    
    % We will threshold the first argument based on the SIGN of the second
    % argument. Therefore we convert the logical values, (0,1), of Lvvv<0  
    % and gradmagn>threshold to (-1,1)
    maskpic1 = (Lvvv<0)*2-1;
    maskpic2 = (gradmagn>threshold)*2-1;

    curves = zerocrosscurves(Lvv, maskpic1);  % keep maxpoints
    curves = thresholdcurves(curves, maskpic2); % keep curves above threshold
   
    edgecurves = curves;
end