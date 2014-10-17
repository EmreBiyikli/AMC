% Distributed for academic research purposes only.
% See COPYING.txt for details.
% Author: Emre Biyikli (biyikli.emre@gmail.com)

% Generate Tube
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate tube positions separated by input bond length. The tube is at input 
% angle. The length and chirality are the other inputs. The tube tip is first
% located at the origin, then the tube is translated along the tube logitude 
% through the origin by the tube radius. The reason for this translation is to 
% overlap the tubes before the cut. 
function position = GenerateTube(angle, bond_length, length, m, n)
  diameter = 0.783 * sqrt(m * m + n * n + m * n);
  translation = diameter / 2;
  position = TubeModeler(bond_length, length, m, n);  
  position = Rotate(position, angle);
  position = Translate(angle, position, translation);
end