% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% XToLammpstrj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Converts 3 columns coordinates file format into LAMMPS input data file format.
% Replaces x.txt file with the new format.
clc, close all, clear all, delete *.asv
% Init filenames
input_file = 'x.txt';
output_file = 'x.txt';
% Read position
position = load(input_file);
% Delete input file
if(exist(input_file, 'file') == 2)
  delete(input_file);
end
% Calculate axes
[my_axis, my_axis_length] = MyAxis(position);
my_axis(1 : 2 : 5) = my_axis(1 : 2 : 5) - 0.5 * my_axis_length;
my_axis(2 : 2 : 6) = my_axis(2 : 2 : 6) + 0.5 * my_axis_length;
% Get atom number
atom_num = size(position, 1);
% Open output file
output_file_handle = fopen(output_file, 'w');
% Output atom number and types
to_write = '#\n\n';
fprintf(output_file_handle, to_write);
to_write = [num2str(atom_num) ' atoms\n\n'];
fprintf(output_file_handle, to_write);
fprintf(output_file_handle,'    2 atom types\n\n');
% Output axes
fprintf(output_file_handle, '%5d %5d xlo xhi\n', my_axis(1), my_axis(2));
fprintf(output_file_handle, '%5d %5d ylo yhi\n', my_axis(3), my_axis(4));
fprintf(output_file_handle, '%5d %5d zlo zhi\n\n', my_axis(5), my_axis(6));
% Output masses
fprintf(output_file_handle, 'Masses\n\n');
fprintf(output_file_handle, '1  12.0\n');
fprintf(output_file_handle, '2  1.0\n\n');
fprintf(output_file_handle, 'Atoms\n\n');
% Output positions
t1 = [(1:atom_num)' ones(atom_num,1) position];
dlmwrite(output_file,t1,'-append','delimiter',' ','newline','pc','precision',12)
% Close output file
fclose(output_file_handle);
%