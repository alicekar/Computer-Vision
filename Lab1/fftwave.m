function fftwave(u, v, rows, sz)
    if (nargin < 3)
        error('Requires at least three input arguments.')
    end
    if (nargin == 3)
        sz = 128; 
    end
    if(rows <= 0)||(rows > 3)
        error('rows must be either 1,2 or 3')
    end
    Fhat = zeros(sz);
    Fhat(u, v) = 1;
    
    % Inverse discrete Fourier transform
    F = ifft2(Fhat);
    Fabsmax = max(abs(F(:)));
    
    % What is done by these instructions?
    if (u <= sz/2)
        uc = u - 1; 
    else
        uc = u - 1 - sz;
    end
    if (v <= sz/2)
        vc = v - 1;
    else
        vc = v - 1 - sz;
    end
    wavelength =sz./(sqrt(vc^2+uc^2));
    
    % FFT is implemented using a factor 1 in the FFT-routine, and factor 1/N2 in the inverse.
    amplitude = 1/(sz^2);%*sum(sum(abs(F)));
    %amplitude = abs(Fhat(u,v)/(sz^2))%
    
    subplot(rows, 2, 1);
    showgrey(Fhat);
    title(sprintf('Fhat: (u, v) = (%d, %d)', u, v))
    
    subplot(rows, 2, 2);
    % fftshift(X) swaps the first and third quadrants and the second and 
    % fourth quadrants
    showgrey(fftshift(Fhat));
    title(sprintf('centered Fhat: (uc, vc) = (%d, %d)', uc, vc))
    
    if(rows == 2||rows == 3)
        subplot(rows, 2, 3);
        showgrey(real(F), 64, -Fabsmax, Fabsmax);
        title('real(F)')

        subplot(rows, 2, 4);
        showgrey(imag(F), 64, -Fabsmax, Fabsmax);
        title('imag(F)')
    end
    if(rows==3)
        subplot(rows, 2, 5);
        showgrey(abs(F), 64, -Fabsmax, Fabsmax);
        title(sprintf('abs(F) (amplitude %f)', amplitude))

        subplot(rows, 2, 6);
        showgrey(angle(F), 64, -pi, pi);
        title(sprintf('angle(F) (wavelength %f)', wavelength))
    end
end