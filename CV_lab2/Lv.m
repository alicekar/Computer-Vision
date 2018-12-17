function pixels = Lv(inpic, type, shape)
     if (nargin < 3)
       shape = 'same';
     end
     [dxmask, dymask] = difference(type);
     Lx = filter2(dxmask, inpic, shape);
     Ly = filter2(dymask, inpic, shape);
     pixels = Lx.^2 + Ly.^2;
end