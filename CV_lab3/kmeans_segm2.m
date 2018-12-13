function [ segmentation, centers, conv, error] = kmeans_segm2(image, K, L, showImg, showConv, type) 
    %Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).

    % Use 2D matrix instead of 3D
    if strcmpi('3D',type)
        [H,W,c] = size(image);
        I_flat = reshape(image,H*W,c);
        I_flat = double(I_flat);
    elseif strcmpi('2D',type)
        H = size(image,1);
        W = 1;
        I_flat = double(image);
    end
    %  Randomly initialize the K cluster centers
    r_idx = randperm(size(I_flat,1),K);
    centers = I_flat(r_idx, :);

    %  Compute all distances between pixels and cluster centers
    D = pdist2(I_flat, centers);
    
    % Collect errors
    error = zeros(1,L+1);
    
    %  Iterate L times
    conv = 0;
    for i = 1:L
        %     Assign each pixel to the cluster center for which the distance is minimum
        [Y,segmentation] = min(D,[],2);
        error(i) = sum(Y(:));
        for j=1:K
            idx = find(segmentation==j);
            pixel_cluster = I_flat(idx,:);
            %     Recompute each cluster center by taking the mean of all pixels assigned to it
            mean_vals = mean(pixel_cluster,1);
            centers(j,:) = mean_vals;
            %     Recompute all distances between pixels and cluster centers 
            D = pdist2(I_flat, centers);
        end
        if showImg == 1
            Inew = mean_segments(image,segmentation);
            imshow(Inew)
            drawnow
            title(sprintf('K = %i', K))
            pause(1/i);
        end
        
        if i>4 && round(error(i)./max(error(:)),2)==round(error(i-4)./max(error(:)),2) && conv==0
            conv = i;
        end
    end
    [Y,segmentation] = min(D,[],2);
    error(i+1) = sum(Y(:));
    error = error./max(error(:));
    if showConv == 1
        figure()
        plot(1:L+1,error)
    end
    centers = single(centers);
    segmentation = reshape(segmentation,H,W);
    used_classes = unique(segmentation);
    %disp('Converged after')
    conv; 
end