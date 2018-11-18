function fftwave2(u, v, fh, fhc, re, im, ab, ph, pl, width, sz)
    if (nargin < 8)
        error('Requires at least three input arguments.')
    end
    if (nargin == 10)
        sz = 128; 
    end
    
    % Construct Fhat
    Fhat = zeros(sz);
    Fhat(u, v) = 1;
    
    % Calculate the inverse discrete Fourier transform of Fhat
    F = ifft2(Fhat);
    Fabsmax = max(abs(F(:)));
    
    % Perform a centering operation
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
    
    % Calculate the wavelength 
    wavelength =sz/sqrt(vc^2+uc^2);
    % Calculate the amplitude - FFT is implemented using a factor 1 in the 
    % FFT-routine, and factor 1/N2 in the inverse.
    amplitude = abs(Fhat(u,v))/sz;
    
    % PLOT
    rows = 0;
    if (fh == 1)
        rows = rows + 1;
    end
    if (fhc == 1)
        rows = rows + 1;
    end
    if (re == 1)
        rows = rows + 1;
    end
    if (im == 1)
        rows = rows + 1;
    end
    if (ab == 1)
        rows = rows + 1;
    end
    if (ph == 1)
        rows = rows + 1;
    end
    if (pl == 1)
        rows = rows + 1;
    end
    
    rows = ceil(rows/width);
        
    counter = 1;
    if (fh == 1)
        subplot(rows, width, counter);
        counter = counter + 1;
        showgrey(Fhat);
        title({'Fhat',sprintf('(u, v) = (%d, %d)', u, v)})
    end
    if (fhc == 1)
        subplot(rows, width, counter);
        counter = counter + 1;
        showgrey(fftshift(Fhat));
        title({'Centered Fhat',sprintf('(uc, vc) = (%d, %d)', uc, vc)})
    end
    if (re == 1)
        subplot(rows, width, counter);
        counter = counter + 1;
        showgrey(real(F), 64, -Fabsmax, Fabsmax);
        title('real(F)')
    end
    if (im == 1)
        subplot(rows, width, counter);
        counter = counter + 1;
        showgrey(imag(F), 64, -Fabsmax, Fabsmax);
        title('imag(F)')
    end
    if (ab == 1)
        subplot(rows, width, counter);
        counter = counter + 1;
        showgrey(abs(F), 64, -Fabsmax, Fabsmax);
        title({'abs(F)',sprintf('amplitude = %f', amplitude)})
    end
    if (ph == 1)
        subplot(rows, width, counter);
        counter = counter + 1;
        showgrey(angle(F), 120, -pi, pi);
        title({'angle(F)',sprintf('wavelength = %f', wavelength)})
    end
    if (pl == 1)
        subplot(rows, width, counter);
        counter = counter + 1;
        if (vc == 0)
            plot([0,0], [-0.5 0.5], 'k');
        else
            x = [-0.5 0.5];
            plot(-x, uc/vc*x, 'k');
        end
        axis square
        axis([-0.5 0.5 -0.5 0.5])
        set(gca, 'xtick', [-1 1]);
        set(gca, 'ytick', [-1 1]);
        title('Direction')
    end
     
    suptitle(sprintf('(u, v) = (%d, %d). Centered: (uc, vc) = (%d, %d)', u, v, uc, vc))
end