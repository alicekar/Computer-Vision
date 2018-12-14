classdef Lab3
    methods(Static)
        function Q2(I,K,L,scale_factor,image_sigma,iters)
            close all;
            I = imresize(I, scale_factor);
            Iback = I;
            d = 2*ceil(image_sigma*2) + 1;
            h = fspecial('gaussian', [d d], image_sigma);
            I = imfilter(I, h);

            % Iterate to get conv plots
            all_errors = zeros(iters,L+1);
            conv_points = [];
            for i = 1:iters
                tic
                [ segm, centers, conv, error] =kmeans_segm2(I, K, L, 0,0,'3D');
                conv_points = [conv_points, conv];
                all_errors(i,:) = error;
                toc
            end
            conv_points
            figure()
            histogram(conv_points);
            xlim([0 L]) %0 max(conv_points)])
            xlabel('Iteration')
            ylabel('Counts')
            title('Histogram for Convergence')
            
            figure()
            plot(1:L+1,mean(all_errors,1))
            axis([0 L 0.6 1])
            xlabel('Iterations')
            ylabel('Mean Error Normalized')
            title('Mean Error over Iterations')
            
            Inew = mean_segments(Iback, segm);
            I = overlay_bounds(Iback, segm);
            
            figure()
            subplot(1,2,1)
            imshow(Inew)
            title('Segmentation')
            subplot(1,2,2)
            imshow(I)
            title('Overlay Bounds')
            
        end
        
        function Q3(K,diff)
            close all;
            I = imread('orange.jpg');
            L = 15;              % number of iterations
            scale_factor = 1.0;  % image downscale factor
            image_sigma = 1.0;   % image preblurring scale
            
            I = imresize(I, scale_factor);
            Iback = I;
            d = 2*ceil(image_sigma*2) + 1;
            h = fspecial('gaussian', [d d], image_sigma);
            I = imfilter(I, h);
            
            % Calc for K-1 to show difference
            tic
            [ segm, centers, conv, error] =kmeans_segm2(I, K-diff, L, 0,0,'3D');
            toc
            Inew1 = mean_segments(Iback, segm);
            I1 = overlay_bounds(Iback, segm);
            
            % Show simulation for K
            tic
            [ segm, centers, conv, error] =kmeans_segm2(I, K, L, 1,0,'3D');
            toc
            Inew2 = mean_segments(Iback, segm);
            I2 = overlay_bounds(Iback, segm);
            
            figure()
            subplot(2,2,1)
            imshow(Inew1)
            title(sprintf('Segmentation K = %i', K-diff))
            subplot(2,2,2)
            imshow(I1)
            title(sprintf('Overlay Bounds K = %i', K-diff))
            subplot(2,2,3)
            imshow(Inew2)
            title(sprintf('Segmentation K = %i', K))
            subplot(2,2,4)
            imshow(I2)
            title(sprintf('Overlay Bounds K = %i', K))
        end
        
        function Q4(K1, K2)
            close all;
            I = imread('tiger1.jpg');
            L = 25;              % number of iterations
            scale_factor = 1.0;  % image downscale factor
            image_sigma = 1.0;   % image preblurring scale
            
            I = imresize(I, scale_factor);
            Iback = I;
            d = 2*ceil(image_sigma*2) + 1;
            h = fspecial('gaussian', [d d], image_sigma);
            I = imfilter(I, h);
            
            % Calc for K1
            tic
            [ segm, centers, conv, error] =kmeans_segm2(I, K1, L, 0,0,'3D');
            toc
            Inew1 = mean_segments(Iback, segm);
            I1 = overlay_bounds(Iback, segm);
            
            % Calc for K2
            tic
            [ segm, centers, conv, error] =kmeans_segm2(I, K2, L, 1,0,'3D');
            toc
            Inew2 = mean_segments(Iback, segm);
            I2 = overlay_bounds(Iback, segm);
            
            figure()
            subplot(2,2,1)
            imshow(Inew1)
            title(sprintf('Segmentation K = %i', K1))
            subplot(2,2,2)
            imshow(I1)
            title(sprintf('Overlay Bounds K = %i', K1))
            subplot(2,2,3)
            imshow(Inew2)
            title(sprintf('Segmentation K = %i', K2))
            subplot(2,2,4)
            imshow(I2)
            title(sprintf('Overlay Bounds K = %i', K2))
       
        end
        
        function Q5(s_band, c_band, I)
            close all;
            scale_factor = 0.5;       % image downscale factor
            spatial_bandwidth = s_band; %10.0;  % spatial bandwidth
            colour_bandwidth = c_band; %5.0;   % colour bandwidth
            num_iterations = 40;      % number of mean-shift iterations
            image_sigma = 1.0;        % image preblurring scale

            I = imresize(I, scale_factor);
            Iback = I;
            d = 2*ceil(image_sigma*2) + 1;
            h = fspecial('gaussian', [d d], image_sigma);
            I = imfilter(I, h);

            segm = mean_shift_segm(I, spatial_bandwidth, colour_bandwidth, num_iterations);
            Inew = mean_segments(Iback, segm);
            I = overlay_bounds(Iback, segm);
            subplot(1,2,1); 
            imshow(Inew);
            title('Segmentation')
            subplot(1,2,2); 
            imshow(I);
            title('Overlay Bounds')
        end
        
        function Q7(ncuts_thresh, min_area, max_depth, colour_bandwidth, I)
            %close all;
            radius = 3;              % maximum neighbourhood distance
            scale_factor = 0.4;      % image downscale factor
            image_sigma = 2.0;       % image preblurring scale
            
            I = imresize(I, scale_factor);
            Iback = I;
            d = 2*ceil(image_sigma*2) + 1;
            h = fspecial('gaussian', [d d], image_sigma);
            I = imfilter(I, h);

            segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
            Inew = mean_segments(Iback, segm);
            I = overlay_bounds(Iback, segm);
            %imwrite(Inew,'result/normcuts1.png')
            %imwrite(I,'result/normcuts2.png')
            subplot(1,2,1); 
            imshow(Inew);
            title('Segmentation')
            subplot(1,2,2); 
            imshow(I);
            title('Overlay Bounds')

        end
        
        function Q10(ncuts_thresh, min_area, max_depth, colour_bandwidth, I, r)
            %close all;
            radius = r;              % maximum neighbourhood distance
            scale_factor = 0.4;      % image downscale factor
            image_sigma = 2.0;       % image preblurring scale
            
            I = imresize(I, scale_factor);
            Iback = I;
            d = 2*ceil(image_sigma*2) + 1;
            h = fspecial('gaussian', [d d], image_sigma);
            I = imfilter(I, h);

            segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
            Inew = mean_segments(Iback, segm);
            I = overlay_bounds(Iback, segm);
            %imwrite(Inew,'result/normcuts1.png')
            %imwrite(I,'result/normcuts2.png')
            subplot(1,2,1); 
            imshow(Inew);
            title('Segmentation')
            subplot(1,2,2); 
            imshow(I);
            title('Overlay Bounds')
        end
        
        function Q11(scale_factor, area, K, alpha, sigma)
            close all;
            I = imread('tiger1.jpg');
            I = imresize(I, scale_factor);
            Iback = I;
            area = int16(area*scale_factor);
            [ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

            Inew = mean_segments(Iback, segm);
            I = overlay_bounds(Iback, segm);
            subplot(2,2,1); imshow(Inew);
            subplot(2,2,2); imshow(I);
            subplot(2,2,3); imshow(prior);

        end
    end
end