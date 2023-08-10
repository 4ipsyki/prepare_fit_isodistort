function yy = aff_Cu_test_ltt(Q,aa,bb,cc)
% evaluates the atomic form factor for a given set of Q points [hkl],
% and lattice parameters aa,bb and cc [Angstroem]

xx = 1/2*sqrt((Q(:,1)/aa).^2 + (Q(:,2)/bb).^2 + (Q(:,3)/cc).^2);

% Cu2+
coeffs = [11.8168      3.37484      7.11181     0.244078      5.78135       7.9876      1.14523       19.897      1.14431];

yy = coeffs(1).*exp(-coeffs(2).*xx.^2) + ...
     coeffs(3).*exp(-coeffs(4).*xx.^2) + ...
     coeffs(5).*exp(-coeffs(6).*xx.^2) + ...
     coeffs(7).*exp(-coeffs(8).*xx.^2) + coeffs(9);
 end

