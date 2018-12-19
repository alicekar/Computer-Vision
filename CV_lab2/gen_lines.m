function outcurves = gen_lines(linepar, pic)
    outcurves = zeros(2,size(linepar,2)*4);
    
    for idx = 1:size(linepar,2)
        rho = linepar(1,idx);
        theta = linepar(2,idx);
        x0 = rho*cos(theta);
        y0 = rho*sin(theta);
        dx = -100*y0;
        dy = 100*x0;
        outcurves(1, 4*(idx-1) + 1) = 0; % level, not significant
        outcurves(2, 4*(idx-1) + 1) = 3; % number of points in the curve
        outcurves(2, 4*(idx-1) + 2) = x0-dx;
        outcurves(1, 4*(idx-1) + 2) = y0-dy;
        outcurves(2, 4*(idx-1) + 3) = x0;
        outcurves(1, 4*(idx-1) + 3) = y0;
        outcurves(2, 4*(idx-1) + 4) = x0+dx;
        outcurves(1, 4*(idx-1) + 4) = y0+dy;
    end
    figure()
    overlaycurves2(pic, outcurves,2);
    axis([0, size(pic,1), 0, size(pic,2)])
end