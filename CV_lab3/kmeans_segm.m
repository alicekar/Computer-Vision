function [ segmentation, centers ] = kmeans_segm(image, K, L, seed) 
    %Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
    %  Randomly initialize the K cluster centers
    centers = randi([0 255],K,3);

    % Use 2D matrix instead of 3D
    H = size(image,1);
    W = size(image,2);
    I_flat = reshape(image,H*W,3);
    I_flat = double(I_flat);
    %  Compute all distances between pixels and cluster centers
    D = pdist2(I_flat, centers);
    
    %  Iterate L times
    for i = 1:L
        %     Assign each pixel to the cluster center for which the distance is minimum
        [Y,segmentation] = min(D,[],2);
        for j=1:K
            idx = find(segmentation==j);
            pixel_cluster = I_flat(idx,:);
            %     Recompute each cluster center by taking the mean of all pixels assigned to it
            mean_vals = mean(pixel_cluster,1);
            centers(j,:) = mean_vals;
            %     Recompute all distances between pixels and cluster centers 
            D = pdist2(I_flat, centers);
        end
    end
    centers = uint8(centers);
    segmentation = reshape(segmentation,H,W);
end