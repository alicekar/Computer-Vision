function psf = gaussfft(pic, t)
    [szx,szy] = size(pic);
    
    if mod(szx,2)==0
        lastx = (szx/2)-1;
    else
        lastx = (szx/2);
    end   
    if mod(szy,2)==0
        lasty = (szy/2)-1;
    else
        lasty = (szy/2);
    end  
    [X,Y]=meshgrid(-(szx/2):1:lastx,-(szy/2):1:lasty);
    
        
    % Gauss
    g = (1/(2*pi*t)) * exp(-(X.^2+Y.^2)/(2*t));
    
    % Fourier
    gHat = fft2(g);
    picHat = fft2(pic);
    
    % Multiplication in Fourier domain = convolution in spatial
    cHat = gHat.*picHat;
    
    psf = fftshift(ifft2(cHat));  
end