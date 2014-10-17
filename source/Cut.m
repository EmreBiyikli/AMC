% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% Cut
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cuts the input tube, which is at tube_angle, by the planes at cut_angles from
% clockwise and counterclockwise directions. 
function cut_position = Cut(cut_angle, position, tube_angle)
  cut_position = position;
  cut_angle = mod(cut_angle + 360, 360);
  % Convert cartesian tube positions to cylindrical. 
  [angle, ~] = cart2pol(cut_position(:, 1), cut_position(:, 3));
  angle = mod(angle * 180 / pi + 360, 360);
  % Select the tube points to save
  if (cut_angle(1) < cut_angle(2))
    to_save = angle >= cut_angle(1) & angle <= cut_angle(2);  
  else
    to_save_1 = angle >= cut_angle(1) & angle <= 360;  
    to_save_2 = angle >= 0 & angle <= cut_angle(2); 
    to_save = to_save_1 | to_save_2;
  end
  cut_position = cut_position(to_save, :);
  % Further cut the tube by the axes with respect to its quadrant
  if (tube_angle == 0)
    to_cut = cut_position(:, 1) < 0;    
  elseif (tube_angle > 0 && tube_angle < 90)
    to_cut = cut_position(:, 1) < 0 & cut_position(:, 3) < 0;    
  elseif (tube_angle == 90)
    to_cut = cut_position(:, 3) < 0;    
  elseif (tube_angle > 90 && tube_angle < 180)
    to_cut = cut_position(:, 1) > 0 & cut_position(:, 3) < 0;    
  elseif (tube_angle == 180)
    to_cut = cut_position(:, 1) > 0;
  elseif (tube_angle > 180 && tube_angle < 270)
    to_cut = cut_position(:, 1) > 0 & cut_position(:, 3) > 0;    
  elseif (tube_angle == 270)
    to_cut = cut_position(:, 3) > 0;
  elseif (tube_angle > 270 && tube_angle < 360)
    to_cut = cut_position(:, 1) < 0 & cut_position(:, 3) > 0;
  end
  cut_position(to_cut, :) = [];
end