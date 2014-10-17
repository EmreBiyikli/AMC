% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% Merge
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Runs a loop until all atoms are far enough. In every step, picks one atom
% that is too close to some other atoms. It replaces the position of the
% atom by the mean of positions of the atom and the close atoms. Then, the
% close atoms are removed and the loop proceeds to the next step. 
function merged_position = Merge(merge_distance, position)
  merged_position = position;
  atom_num = size(position, 1);
  while (true)
    distance = Distance(merged_position);
    distance = distance + 1e3 * eye(atom_num);
    [i, j] = find(distance < merge_distance, 1);
    if (isempty(i)); break; end;
    merged_position(i, :) = mean(merged_position([i j], :));
    merged_position(j, :) = [];
    atom_num = size(merged_position, 1);
  end
end