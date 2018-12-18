function pixels = Lvvvtilde(inpic, shape)
     if (nargin < 2)
       shape = 'same';
     end
     % x is pointing downwards, y to the right
     dymask = [0,-1/2,0,1/2,0];
     dxmask = dymask';
     dxy_mask = conv2(dxmask,dymask,'same');
     dxx_mask = conv2(dxmask,dxmask,'same');
     dyy_mask = conv2(dymask,dymask,'same');
     
     Lx = conv2(inpic,dxmask, shape);
     Ly = conv2(inpic,dymask, shape);
     Lxx = conv2(inpic,dxx_mask, shape);
     Lxy = conv2(inpic,dxy_mask, shape);
     Lyy = conv2(inpic,dyy_mask, shape);
     
     Lxxx = conv2(Lxx, dxmask, shape);
     Lxxy = conv2(Lxx, dymask, shape);
     Lxyy = conv2(Lxy, dymask, shape);
     Lyyy = conv2(Lyy, dymask, shape);
     %{
     dxxx_mask = conv2(dxmask,dxx_mask,'same');
     dxxy_mask = conv2(dxx_mask,dymask,'same');
     dxyy_mask = conv2(dxmask,dyy_mask,'same');
     %dxyy_mask = conv2(dxy_mask,dymask,'same');
     dyyy_mask = conv2(dymask,dyy_mask,'same');
     
     Lx = conv2(inpic, dxmask, shape);
     Ly = conv2(inpic, dymask, shape);
     Lxxx = conv2(inpic, dxxx_mask, shape);
     Lxxy = conv2(inpic, dxxy_mask, shape);
     Lxyy = conv2(inpic, dxyy_mask, shape);
     Lyyy = conv2(inpic, dyyy_mask, shape);
     
     [x y] = meshgrid(-5:5, -5:5)
     filter2(dxxx_mask, x .^3, 'valid')
     filter2(dxx_mask, x .^3, 'valid')
     filter2(dxxy_mask, x .^2 .* y, 'valid')
     %}
     pixels = (Lx.^3).*Lxxx + 3.*(Lx.^2).*Ly.*Lxxy + 3.*Lx.*(Ly.^2).*Lxyy + (Ly.^3).*Lyyy;
end