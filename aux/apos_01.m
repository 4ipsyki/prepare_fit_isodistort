% Function to calculate the position of each atom in the unit cell by
% knowing the undistorted coordinates, the distortion-mode amplitude xx,
% and the distortion modes.
% The position is expressed in the fractional coordinates of the supercell.
% The matrixes are orginized as:
% undist = #atoms x (x,y,z)
% xx = 1 x #modes
% dist = #atoms x (x,y,z)
% In the script, each row of dist is expressed as a sum of the modes for
% each atom in the unit cell. The normalization factor for each mode is
% directly expressed as a number.
