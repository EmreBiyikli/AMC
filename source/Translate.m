% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% Translate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Translates the tube along its longitude through the origin by its radius.
% After calculating the unit vector from the tube to the origin, it multiplies 
% the unit vector by the translation length, and simply adds it to current
% positions, hence translated. 
function translated_position = Translate(angle, position, translation_length)
  vector = -[cosd(angle) sind(angle)];
  unit_vector = vector / norm(vector);
  translation_vector = translation_length * unit_vector;
  translated_position = position;
  translated_position(:, 1) = translated_position(:, 1) + translation_vector(1);
  translated_position(:, 3) = translated_position(:, 3) + translation_vector(2);
end