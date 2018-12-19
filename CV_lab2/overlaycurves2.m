function overlaycurves2(image, curves, line_width)
if nargin<3
    line_width = 1;
end
% OVERLAYCURVES(IMAGE, CURVES)
%
% Displays CURVES overlayed on IMAGE
%
% The format of these curves is the same as for CONTOURC

showgrey(image);

insize = size(curves, 2);
trypointer = 1;

hold on;

while trypointer <= insize
  polylength = curves(2, trypointer);

  plot(curves(1, (trypointer+1):(trypointer+polylength)), ...
       curves(2, (trypointer+1):(trypointer+polylength)),'LineWidth',line_width);
  hold on;
  trypointer = trypointer + 1 + polylength;
end

hold off;
