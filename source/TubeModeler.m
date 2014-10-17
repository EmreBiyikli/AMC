% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% TubeModeler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generates tube positions with respect to the input bond length, tube length,
% and chirality. 
function position = TubeModeler(bond_length, length, m, n)
% Vectors
vec_1 = bond_length * [1; 0];
vec_2 = bond_length * [cos(pi / 3); sin(pi / 3)];
% Chiral vector
chi_vec = n * vec_1 + m * vec_2;
unit_chi_vec = chi_vec / norm(chi_vec);
unit_chi_vec_ort = [unit_chi_vec(2); -unit_chi_vec(1)];
if (det([unit_chi_vec unit_chi_vec_ort]) < 0)
  unit_chi_vec_ort = -unit_chi_vec_ort; 
end
% Cell vector
mn_gcd = gcd(2 * m + n, 2 * n + m);   
cell_vec = (n + 2 * m) / mn_gcd * vec_1 - (m + 2 * n) / mn_gcd * vec_2;
% More vectors
vecs = [vec_1 vec_2];
if (chi_vec' * vecs(:, 1) < 0); vecs = -vecs; end;
if (cell_vec' * vecs(:, 2) == 0); vecs = [vecs(:,2) vecs(:, 1)]; end;
% Lattice
lattice = [];
for i = 0 : (floor(norm(chi_vec) / (unit_chi_vec' * vecs(:, 1)) + 1e-3) + 1)
    temp_1 = -i * unit_chi_vec_ort' * vecs(:, 1);
    temp_2 = unit_chi_vec_ort' * vecs(:, 2);
    temp_3 = ceil(temp_1 / temp_2);
    temp_4 = floor((length + temp_1) / temp_2);
    temp_5 = min([temp_3 temp_4]);
    temp_6 = max([temp_3 temp_4]);
    new_lattice = [i * ones(1, temp_6 - temp_5 + 1); temp_5 : temp_6];
    lattice = cat(2, lattice, new_lattice);
end
lattice = vecs * lattice;
% Lattice atoms
atom = bond_length * [cos(pi / 6); sin(pi / 6)];
lattice_atom = [lattice(1, :) + atom(1); lattice(2, :) + atom(2)];
% Rotate & transform s.t. (x, y) -> (z, theta)
rotation_mat = [unit_chi_vec unit_chi_vec_ort]';
rotated_lattice_atom = rotation_mat * lattice_atom;   
tube_radius = norm(chi_vec) / (2 * pi);
% Atom positions
x = rotated_lattice_atom(2, :);
y = tube_radius * sin(rotated_lattice_atom(1, :) / tube_radius);
z = tube_radius * cos(rotated_lattice_atom(1, :) / tube_radius);
position = [x; y; z]';
position = unique(round(1e6 * position) / 1e6, 'rows');
end