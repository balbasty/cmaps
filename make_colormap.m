function cm = make_colormap(name, n)
% FORMAT cm = make_colormap(name, n)
% name - Name of a matplotlib colormap
% n    - Number of values [256]
%
% Blues BrBG BuGn BuPu GnBu Greens Greys Oranges OrRd PiYG PRGn PuBu
% PuBuGn PuOr PuRd Purples RdBu RdGy RdPu RdYlBu RdYlGn Reds Spectral
% YlGn YlGnBu YlOrBr YlOrRd Accent Dark2 Paired Pastel1 Pastel2 Set1 Set2
% Set3 gist_earth gist_ncar gist_rainbow coolwarm CMRmap wistia

if nargin < 2
    n = 256;
end

data = get_cm_data(name);
if iscell(data)
    cm = segmented_colormap(data, n);
else
    cm = interpolate_colormap(data, n);
end


function cm = interpolate_colormap(data, n)
% Linearly interpolate a colormap
% `data` should be a [Nx3] array

nd = size(data, 1);
cm = linspace(1, nd, n)';
cm_low = floor(cm);
cm_up = min(cm_low + 1, nd);
w = cm - cm_low;
cm = data(cm_low,:) .* (1 - w) + data(cm_up, :) .* w;


function cm = segmented_colormap(data, n)
% `data` should be a {3x1} cell of Nx3 array
cm = zeros(n, 3);
[r, g, b] = data{:};
cm(:,1) = segmented_colormap1(r, n);
cm(:,2) = segmented_colormap1(g, n);
cm(:,3) = segmented_colormap1(b, n);

function cm = segmented_colormap1(data, n)
% `data` should be a Nx3 array
idx = linspace(0, 1, n)';
d = idx - data(:,1)';
idx_low = max(floor(sum(d > 0, 2)), 1);
idx_up = min(idx_low+1, size(data, 1));
w_low = idx - data(idx_low, 1);
w_up = data(idx_up, 1) - idx;
w_sum = w_low + w_up;
w_low = w_low ./ w_sum;
w_up = w_up ./ w_sum;
cm = data(idx_low,3) .* w_up + data(idx_up,2) .* w_low;