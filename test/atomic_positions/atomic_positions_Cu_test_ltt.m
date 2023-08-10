function yy=atomic_positions_Cu_test_ltt(xx)
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

undist = [
 0.000000 0.750000 0.500000;
 0.000000 0.250000 0.500000;
 0.500000 0.750000 0.500000;
 0.500000 0.250000 0.500000;
 0.000000 0.250000 0.000000;
 0.000000 0.750000 0.000000;
 0.500000 0.250000 0.000000;
 0.500000 0.750000 0.000000;
 0.000000 0.000000 0.000000;
 0.500000 0.500000 0.000000;
 0.000000 0.000000 0.500000;
 0.500000 0.500000 0.500000;
 0.000000 0.500000 0.000000;
 0.500000 0.000000 0.000000;
 0.000000 0.500000 0.500000;
 0.500000 0.000000 0.500000;
 0.750000 0.375000 0.250000;
 0.750000 0.625000 0.750000;
 0.750000 0.875000 0.250000;
 0.750000 0.125000 0.750000;
 0.250000 0.375000 0.250000;
 0.250000 0.625000 0.750000;
 0.250000 0.875000 0.250000;
 0.250000 0.125000 0.750000;
 0.750000 0.125000 0.250000;
 0.750000 0.375000 0.750000;
 0.750000 0.625000 0.250000;
 0.750000 0.875000 0.750000;
 0.250000 0.125000 0.250000;
 0.250000 0.375000 0.750000;
 0.250000 0.625000 0.250000;
 0.250000 0.875000 0.750000;
];

% The following modes are considered:
% P4_2/ncm[1/4,1/4,1/2]S1(a,0;0,0)[Cu:d:dsp]Bu_1(a) normfactor = 0.03304
% P4_2/ncm[1/4,1/4,1/2]S1(a,0;0,0)[Cu:d:dsp]Bu_2(a) normfactor = 0.04673
% P4_2/ncm[1/4,1/4,1/2]S1(a,0;0,0)[Cu:d:dsp]Bu_3(a) normfactor = 0.01894
% P4_2/ncm[1/4,1/4,1/2]S1(a,0;0,0)[Cu:d:dsp]Bu_4(a) normfactor = 0.01339
% P4_2/ncm[1/2,1/2,0]M2(0,a)[Cu:d:dsp]Au(a) normfactor = 0.02336

dist = [
xx(1) *  0.033040 * [ 0.000000 -1.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [ 1.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  1.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [-1.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  1.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [-1.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000 -1.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [ 1.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  1.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [ 1.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000 -1.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [-1.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000 -1.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [-1.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  1.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [ 1.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [-0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [-0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [-0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000 -0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000 -0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [-0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000 -0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  0.000000] + xx(3) *  0.018940 * [-0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 0.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  0.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [-1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000 -1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [-1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000 -1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000 -1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000 -1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000 -1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000 -1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000 -1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [-1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000 -1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [-1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000 -1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [-1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000 -1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000 -1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [-1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000 -1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000 -1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [-1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000 -1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000  1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [ 1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000  1.000000  0.000000];
xx(1) *  0.033040 * [ 0.000000  0.000000  0.000000] + xx(2) *  0.046730 * [ 0.000000  0.000000 -1.000000] + xx(3) *  0.018940 * [ 0.000000  0.000000  0.000000] + xx(4) *  0.013390 * [-1.000000  0.000000  0.000000] + xx(5) *  0.023360 * [ 0.000000 -1.000000  0.000000];
];

yy = undist + dist;

end