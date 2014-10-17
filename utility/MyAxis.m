% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% MyAxis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculates tight axes for the input positions. Optionally, calculates the
% length of the domain populated by the input positions. 
function [my_axis, my_axis_length] = MyAxis(position)
position_min = min(position);
position_max = max(position);
my_axis = [position_min(1) position_max(1)...
           position_min(2) position_max(2)...
           position_min(3) position_max(3)];
if (nargout > 1)
    my_axis_length = position_max - position_min;
end