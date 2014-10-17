% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% LammpstrjToX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reads LAMMPS output file, which is in lammpstrj format, extracts the 
% positions from the last step, and writes them to "x.txt" file in 3 columns.
clc, close all, clear all, delete *.asv
% Init filenames and scale switch
input_file = 'dump.lammpstrj';
output_file = 'x.txt';
is_scaled = 1;
% Delete output file
if (exist(output_file, 'file') == 2)
  delete(output_file);
end
% Open input file
input_file_handle = fopen(input_file, 'r');
% Read step-by-step
step_num = 0;    
while (step_num < 1e6)
  % Increase step number
  step_num = step_num + 1;
  % Check if EOF
  line = fgetl(input_file_handle);
  if (line == -1); break; end;
  % Get step
  step = str2double(fgetl(input_file_handle));
  fgetl(input_file_handle);
  % Get atom number
  line = fgetl(input_file_handle);
  temp_atom_num = str2double(line);
  fgetl(input_file_handle);
  % Get axes
  my_axis = zeros(1, 6);
  my_axis_length = zeros(1, 3);
  for i = 1 : 3
    line = fgetl(input_file_handle);
    space = find(line == ' ', 1);
    my_axis_lo = str2double(line(1 : space - 1));
    my_axis_hi = str2double(line(space + 1 : end));
    my_axis(1 + 2 * (i - 1) : 2 * i) = [my_axis_lo my_axis_hi];
    my_axis_length(i) = abs(my_axis_lo - my_axis_hi);
  end
  % Get position
  fgetl(input_file_handle);
  temp_position = zeros(temp_atom_num, 4);
  for i = 1 : temp_atom_num
    line = fgetl(input_file_handle);
    space = find(line == ' ');
    line_part = str2double(line(1 : (space(1) - 1)));
    temp_position(i, 1) = line_part;
    for j = 1 : 3
      if (j < 3)
        line_part = str2double(line(space(j + 1) + 1 : space(j + 2) - 1));
      elseif (j == 3)
        line_part = str2double(line(space(j + 1) + 1 : end));
      end
      if (is_scaled)
        temp_position(i, j + 1) = ...
            my_axis(1 + 2 * (j - 1)) + my_axis_length(j) * line_part;
      else
        temp_position(i, j + 1) = line_part;
      end
    end
  end
  % Display status
  if (step_num == 1)
    fprintf('Reading steps:\n');
  end
  fprintf('%.0f\n', step_num);
end   
% Close input file
fclose(input_file_handle);
% Sort position
temp_position = sortrows(temp_position, 1);
temp_position = temp_position(:, 2 : 4);
% Output position
dlmwrite(output_file, temp_position, 'delimiter', '\t', 'precision', '%16.8f');
%