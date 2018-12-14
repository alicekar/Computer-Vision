function prob = mixture_prob(image, K, L, mask)
    %  Let I be a set of pixels and V be a set of K Gaussian components in 3D (R,G,B).
    %  Store all pixels for which mask=1 in a Nx3 matrix
    
    % Reshape to 2D and keep only masked pixels
    [H,W,c] = size(image);
    Ivec = im2double(reshape(image, H*W, c));
    Mvec = Ivec(find(mask), :);
    N = size(Mvec,1);
    
    %  Randomly initialize the K components using masked pixels
    [seg, mu] = kmeans_segm2(Mvec, K, 100, 0,0,'2D');
    
    cov = cell(K,1);
    cov(:) = {0.05 *  eye(c)};%{eye(c)+0.1};
   
    w = zeros(1,K);
    for i = 1:K
        w(i) = length(find(seg==i))/N;
    end

    % Matrices for holding w_k*g_k(c_i) and p_ik
    wg = zeros(N,K);
    p = zeros(N, K);
   
    %  Iterate L times
    for j = 1:L
        % Expectation: Compute probabilities P_ik using masked pixels
        for k = 1:K
            wg(:,k) = w(k)*mvnpdf(Mvec,mu(k,:),cov{k});
        end
        
        for k = 1:K
            p(:,k) = wg(:,k)./sum(wg,2);
        end
  
        % Maximization: Update weights, means and covariances using masked pixels
        for k = 1:K
            w(k) = sum(p(:,k),1)/N;
            mu(k,:) = (p(:,k)' * Mvec)/sum(p(:,k),1);

            diff = bsxfun(@minus, Mvec, mu(k,:));
            top = diff' *(diff .* repmat(p(:,k),[1 3]));
            cov{k} = top / sum(p(:,k),1);
        end
    end
    pos = zeros(size(Ivec,1),K);
    
    %  Compute probabilities p(c_i) in Eq.(3) for all pixels I.
    for k = 1:K
        pos(:,k) = w(k)*mvnpdf(Ivec,mu(k,:),cov{k});
        pos(:,k) = pos(:,k)/sum(pos(:,k),1);
    end
    pos = sum(pos,2);
    prob = reshape(pos,H,W,1);

end