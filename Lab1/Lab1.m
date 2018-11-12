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
    end
end