% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% Rotate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Converts cartesian tube positions into cylindrical, rotates by angles, and
% converts back to cartesian positions. 
function rotated_position = Rotate(position, rotation_angle)
  rotated_position = position;
  [angle, length] = cart2pol(rotated_position(:, 1), rotated_position(:, 3));
  angle = angle + rotation_angle * pi / 180;
  [x, z] = pol2cart(angle, length);
  rotated_position = [x rotated_position(:, 2) z];
end