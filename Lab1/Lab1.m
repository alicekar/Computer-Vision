% Author: Alice Karnsund

classdef Lab1
    methods (Static)
        function question1()
            close all;
            p = [5,9,17,17,5,125];
            q = [9,5,9,121,1,1];
            for i=1:length(p)
                figure()
                fftwave(p(i),q(i),3)
                %pause(2)
            end
        end
        
        function question2()
            close all;
            u = [1,1,2,64];
            v = [128,64,2,64];
            for i = 1:length(u)
                figure()
                fftwave(u(i),v(i),2);
            end    
        end
        
        function question5()
            close all;
            u = [100,64];
            v = [64,100];
            for i = 1:length(u)
                figure()
                fftwave(u(i),v(i),1);
            end  
        end
        
        function question7()
            close all;
            F = [zeros(56, 128); ones(16, 128); zeros(56, 128)];  
            G = F';
            H = F+2*G;
            figs = zeros(128,128,3);
            figs(:,:,1) = F;
            figs(:,:,2) = G;
            figs(:,:,3) = H;
            names = ['Fhat';'Ghat';'Hhat'];
            places = [1,4,7];
            
            figure()
            hold on;
            for i = 1:3
                subplot(3,3,places(i))
                showgrey(figs(:,:,i));
                title(sprintf('%s', names(i,1)))
                
                image_hat = fft2(figs(:,:,i));
                
                subplot(3,3,places(i)+1)
                showgrey(log(1 + abs(image_hat)));
                title(sprintf('%s', names(i,:)))
                
                subplot(3,3,places(i)+2)
                showgrey(log(1 + abs(fftshift(image_hat))));   %showfs(Hhat)
                title(sprintf('Centered %s',names(i,:)))
            end
            
            Hhat = fft2(H);
            A = abs(Hhat);

            figure()
            showgrey(fftshift(A))
            title('|Hhat| with fftshift command')
            
            figure()
            showgrey(log(1 + abs(fftshift(Hhat))));   %showfs(Hhat)
            title('Hhat with fftshift command and constant = 1')
            
            figure()
            showgrey(log(0.00001 + abs(fftshift(Hhat))));
            title('Hhat with fftshift command and constant = 0.00001')
        end
        
        function question10()
            close all;
            F = [zeros(56, 128); ones(16, 128); zeros(56, 128)];  
            G = F';
            Fhat = fft2(F);
            Ghat = fft2(G);
            
            % This operation uses padding which results in a matrix of size 
            % 255 x 255, thus we take out the relevant center part, 128x128
            FC = conv2(fftshift(Fhat),fftshift(Ghat),'same');
            FC = fftshift(FC);
            
            % Each new element value is the sum of 128x128 new values,
            % therefore we must normalize the new matrix
            FC = FC/(128^2);
            
            figure()
            showgrey(F .* G);
            title('Image FG')
            
            figure()
            showfs(fft2(F .* G));
            title('Fourier transform of FG, F(FG)')
            
            % Covolved F(F)*F(G)
            figure()
            showfs(FC);
            title('Convolution of F(F) and F(G), F(F)*F(G)')
        end
        
        function question11()
            close all;
            F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
                [zeros(128, 48) ones(128, 32) zeros(128, 48)];
            Fhat = fft2(F);
             
            figure()
            showgrey(F);
            title('Image F')
             
            figure()
            showfs(Fhat);
            title('Fourier spectra of F, Fhat')
        end
        
        function question12(angles)
            close all;
            F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
                [zeros(128, 48) ones(128, 32) zeros(128, 48)];
            Fhat = fft2(F);
            alpha = 30;
            G = rot(F, alpha); 
            Ghat = fft2(G);
            Hhat = rot(fftshift(Ghat), -alpha);
            
            figure()
            showfs(Fhat);
            title('Fourier spectra of F, Fhat')
            
            figure()
            showgrey(G)
            axis on
            title('Image G = F rotated 30 degrees')
            
            figure()
            showfs(Ghat)
            title('Fourier spectra of G, Ghat')
            
            figure()
            showgrey(log(1 + abs(Hhat)))
            title('Fourier spectra of G rotated back 30 degrees')
            
            figure()
            for i = 1:length(angles)
                alpha = angles(i);
                G = rot(F, alpha); 
                Ghat = fft2(G);
                Hhat = rot(fftshift(Ghat), -alpha);
                
                subplot(length(angles),3,1+3*(i-1))
                showgrey(G);
                title(sprintf('G rot. %d', alpha))
                
                subplot(length(angles),3,2+3*(i-1))
                showfs(Ghat)
                title('Ghat')
                
                subplot(length(angles),3,3+3*(i-1))
                showgrey(log(1 + abs(Hhat)))
                title(sprintf('Spec. rot.back %d', alpha))
            end
        end
        
        function question13()
            close all;
            pics = zeros(128,128,3);
            pics(:,:,1) = phonecalc128;
            pics(:,:,2) = few128;
            pics(:,:,3) = nallo128;
            alpha = 10e-10;
            
            figure()
            for i = 1:3
                subplot(3,3,1+3*(i-1));
                showgrey(pics(:,:,i))
                
                %img_hat = fft2(pics(:,:,i));
                %figure()
                %showfs(img_hat)
                
                pow = pow2image(pics(:,:,i), alpha);
                subplot(3,3,2+3*(i-1));
                showgrey(pow)
                
                rand = randphaseimage(pics(:,:,i));
                subplot(3,3,3+3*(i-1));
                showgrey(rand)
            end
        end    
    end
end