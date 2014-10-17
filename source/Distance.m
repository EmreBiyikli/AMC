% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% Distance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Efficiently calcluates the distances between every pair of positions, and 
% output these distances into a matrix.
function distance = Distance(position)
distance = sqrt(bsxfun(@plus,...
                       sum(position .^ 2, 2),...
                       sum(position .^ 2, 2)') - 2 * (position * position'));
end