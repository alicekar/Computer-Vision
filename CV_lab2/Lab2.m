classdef Lab2
    methods(Static)
        function Q1()
            close all;
            tools = few256;
            type = ["central","sobel"];
            pos = 1;
            figure()
            for i = 1:2
                [deltax, deltay] = difference(type(i));
                dxtools = conv2(tools, deltax, 'valid');
                dytools = conv2(tools, deltay, 'valid');
                subplot(2,3,pos)
                showgrey(tools)
                title('tools')
                subplot(2,3,pos+1)
                showgrey(dxtools)
                title(sprintf('dxtools, %s',type(i)))
                subplot(2,3,pos+2)
                showgrey(dytools)
                title(sprintf('dytools, %s',type(i)))
                pos = 4;
            end
            size(dxtools)
            size(tools)
        end
        
        function Q2()
            close all;
            % No pre smoothing
            tools = few256;
            house = godthem256;
            
            figure()
            pixels = Lv(tools,'sobel');
            gradmagntools = sqrt(pixels);
            subplot(1,2,1)
            showgrey(gradmagntools)
            title('Gradient magnitudes, tools')
            subplot(1,2,2)
            histogram(gradmagntools,255)
            title('Corresponding histogram')
  
            figure()
            pixels = Lv(house,'sobel');
            gradmagnhouse = sqrt(pixels);
            subplot(1,2,1)
            showgrey(gradmagnhouse)
            title('Gradient magnitudes, house')
            subplot(1,2,2)
            histogram(gradmagnhouse,255)
            title('Corresponding histogram')
            
            thresholds = [30,100,140,200];
            figure()
            for i=1:length(thresholds)
                subplot(2,2,i)
                showgrey((gradmagntools - thresholds(i)) > 0)
                title(sprintf('Threshold: %i',thresholds(i)))
            end
            
            thresholds = [50,120,165,300];
            figure()
            for i=1:length(thresholds)
                subplot(2,2,i)
                showgrey((gradmagnhouse - thresholds(i)) > 0)
                title(sprintf('Threshold: %i',thresholds(i)))
            end
        end
        
        function Q3()
            close all;
            % Pre smoothing
            tools = few256;
            house = godthem256;
            
            var = [1,2,4];
            
            figure()
            pixels = Lv(tools,'sobel');
            gradmagntools = sqrt(pixels);
            subplot(2,2,1)
            showgrey(gradmagntools)
            title('No smoothing')
            for j = 1:length(var)
                smooth_tools = gaussfft(tools, var(j));
                pixels = Lv(smooth_tools,'sobel');
                gradmagntools = sqrt(pixels);
                subplot(2,2,j+1)
                showgrey(gradmagntools)
                title(sprintf('Smooth, variance: %i',var(j)))
            end
            
            var = [1,2,4];
            figure()
            pixels = Lv(house,'sobel');
            gradmagnhouse = sqrt(pixels);
            subplot(2,2,1)
            showgrey(gradmagnhouse)
            title('No smoothing')
            for j = 1:length(var)
                smooth_house = gaussfft(house, var(j));
                pixels = Lv(smooth_house,'sobel');
                gradmagnhouse = sqrt(pixels);
                subplot(2,2,j+1)
                showgrey(gradmagnhouse)
                title(sprintf('Smooth, variance: %i',var(j)))
            end
            
            % Final variance
            var_tools = 1;
            var_house = 1;
            
            smooth_tools = gaussfft(tools, var_tools);
            pixels = Lv(smooth_tools,'sobel');
            gradmagntools = sqrt(pixels);
            
            smooth_house = gaussfft(house, var_house);
            pixels = Lv(smooth_house,'sobel');
            gradmagnhouse = sqrt(pixels);
            %{
            figure()
            subplot(1,2,1)
            showgrey(gradmagntools)
            title('Gradient magnitudes, tools')
            subplot(1,2,2)
            histogram(gradmagntools,255)
            title('Corresponding histogram')
            
            figure()
            subplot(1,2,1)
            showgrey(gradmagnhouse)
            title('Gradient magnitudes, house')
            subplot(1,2,2)
            histogram(gradmagnhouse,255)
            title('Corresponding histogram')
            %}
            thresholds = [20,90,120];
            figure()
            subplot(2,2,1)
            showgrey(gradmagntools)
            title(sprintf('Smooth, variance: %i',var_tools))
            for i=1:length(thresholds)
                subplot(2,2,i+1)
                showgrey((gradmagntools - thresholds(i)) > 0)
                title(sprintf('Threshold: %i',thresholds(i)))
            end
            
            thresholds = [30,70,110];
            figure()
            subplot(2,2,1)
            showgrey(gradmagnhouse)
            title(sprintf('Smooth, variance: %i',var_house))
            for i=1:length(thresholds)
                subplot(2,2,i+1)
                showgrey((gradmagnhouse - thresholds(i)) > 0)
                title(sprintf('Threshold: %i',thresholds(i)))
            end
        end
        
        function Q4()
            close all;
            house = godthem256;
            scales = [0.0001, 1, 4, 16, 64];
           
            figure()
            for i = 1:length(scales) 
                subplot(2,3,i)
                contour(Lvvtilde(discgaussfft(house, scales(i)), 'same'), [0 0]) 
                axis('image')
                axis('ij')
                title(sprintf('Scale: %0.2d',scales(i)))
            end
        end
        
        function Q5()
            close all;
            tools = few256;
            scales = [0.0001, 1, 4, 16, 64];
           
            figure()
            for i = 1:length(scales) 
                subplot(2,3,i)
                showgrey(Lvvvtilde(discgaussfft(tools, scales(i)), 'same') < 0)
                title(sprintf('Scale: %0.2d',scales(i)))
            end
        end
        
        function Q7(s_tools, t_tools, s_house, t_house)
            close all;
            tools = few256;
            house = godthem256; 
            
            warning('off','all')
            
            curves_tools = extractedge(tools, s_tools, t_tools);
            curves_house = extractedge(house, s_house, t_house);
            
            figure()
            subplot(1,2,1)
            overlaycurves2(tools, curves_tools)
            title(sprintf('Scale: %0.2d, threshold: %0.2d',s_tools, t_tools))
            subplot(1,2,2)
            overlaycurves2(house, curves_house)
            title(sprintf('Scale: %0.2d, threshold: %0.2d',s_house, t_house))
        end
        
        function Q89(pic, scale, threshold, nrho, ntheta, nlines, dt_bin, K_bin, verbose)
            % Compute a line for each one of the strongest responses in the accumulator
            % Overlay these curves on the gradient magnitude image 
            tic;
            [linepar, ~] = houghedgeline(pic, scale, threshold, ...
                     nrho, ntheta, nlines, dt_bin, K_bin, verbose);
            toc;
            gen_lines(linepar,pic);
            %linepar
        end
        
        function time()
            close all;
            pic = few256;
            n_points = 41;
            rounds = 10;
            
            %N_thetas = round(linspace(10,210,n_points));
            N_thetas = zeros(1,n_points)+80;
            N_rho = round(linspace(100,2100,n_points));
            times = zeros(rounds, n_points);
            N_cells = [];
            for r = 1:rounds
                for i = 1:length(N_rho)
                    tic;
                    [~, ~] = houghedgeline(pic, 0.5, 80, ...
                         N_rho(i), N_thetas(i), 10, 0, 0, 0);
                    t = toc
                    times(r,i) = t;
                    if r == 1
                        N_cells = [N_cells, N_rho(i)*N_thetas(i)];
                    end
                    %gen_lines(linepar,pic);
                end
            end
            figure()
            plot(mean(times,1),N_cells)
            title('Computational time due to size of accumulator')
            xlabel('Computational time')
            ylabel('Number of cells')
        end
        
        function Q10(pic, scale, threshold, nrho, ntheta, nlines, dt_bin, K_bin, verbose, power)
            tic;
            [linepar, ~] = houghedgeline(pic, scale, threshold, ...
                     nrho, ntheta, nlines, dt_bin, K_bin, verbose, power);
            toc;
            gen_lines(linepar,pic);
        end
        
    end
end