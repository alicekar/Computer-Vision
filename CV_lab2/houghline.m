function [linepar, acc] = houghline(curves, magnitude, nrho, ntheta,... 
                           threshold, nlines, verbose)
    % Check if input appear to be valid
    % Allocate accumulator space
    acc = zeros(nrho,ntheta);
    
    % Define a coordinate system in the accumulator space
    thetas = linspace(-pi/2, pi/2,ntheta);
    [x_D,y_D] = size(magnitude);
    D = sqrt(x_D^2+y_D^2);
    rhos = linspace(-D,D,nrho);
    
    % curves = [level1 x1 x2 x3 ... level2 x2 x2 x3 ...;
    %            pairs1 y1 y2 y3 ... pairs2 y2 y2 y3 ...]  
    
    % Loop over all the input curves (cf. pixelplotcurves)
    insize = size(curves, 2);
    trypointer = 1;
    numcurves = 0;
    
    % For each point on each curve
    while trypointer <= insize
        polylength = curves(2, trypointer);
        numcurves = numcurves + 1;
        trypointer = trypointer + 1;
        
        for polyidx = 1:polylength
            x = curves(2, trypointer);
            y = curves(1, trypointer);
            
            % Loop over a set of theta values
            for i = 1:length(thetas)
                theta = thetas(i);
                % Compute rho for each theta valu
                rho = x*cos(theta)+y*sin(theta);
                % Compute index values in the accumulator space
                rho_max = rhos(find((rho<rhos),1));
                rho_min = rhos(rho>rhos);
                rho_min = rho_min(end);
                if abs(rho_max-rho)<abs(rho_min-rho)
                   rho_idx = find((rho<rhos),1);
                else
                   rho_idx = find(rho>rhos);
                   rho_idx = rho_idx(end);
                end   
                % Update the accumulator, adding votes
                acc(rho_idx,i) = acc(rho_idx,i)+1;    
            end
            trypointer = trypointer + 1;
        end
    end      
    
    % Smooth accumulator
    acc = binsepsmoothiter(acc, 0.1, 20);
    if verbose > 0 
        figure()
        showgrey(acc)
        title('Hough space')
        ax = gca;
        axis(ax,'off')
        xlabel(ax,'\theta')
        set(get(ax,'Xlabel'),'Visible','on')
        ylabel(ax, '\rho')
        set(get(ax,'Ylabel'),'Visible','on')
        axis off;
        hold on;
    end
    
    % Extract local maxima from the accumulator
    [pos, value] = locmax8(acc);
    [~, indexvector] = sort(value);
    nmaxima = size(value, 1);
    
    linepar = [];
    for idx = 1:nlines
        rhoidxacc = pos(indexvector(nmaxima - idx + 1), 1);
        thetaidxacc = pos(indexvector(nmaxima - idx + 1), 2);
        rho = rhos(rhoidxacc);
        theta = thetas(thetaidxacc);
        linepar = [linepar [rho,theta]'];
        if verbose > 1
            plot(thetaidxacc,rhoidxacc,'ro')
        end
    end
end
