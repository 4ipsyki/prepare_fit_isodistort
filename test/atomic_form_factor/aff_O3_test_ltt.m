function yy = aff_O3_test_ltt(Q,aa,bb,cc)
% evaluates the atomic form factor for a given set of Q points [hkl],
% and lattice parameters aa,bb and cc [Angstroem]

xx = 1/2*sqrt((Q(:,1)/aa).^2 + (Q(:,2)/bb).^2 + (Q(:,3)/cc).^2);

% O2-
coeffs = [0.56217      33.4764      4.99863      9.04266      2.56533      32.9177      1.41569      0.43204      0.45629];

yy = coeffs(1).*exp(-coeffs(2).*xx.^2) + ...
     coeffs(3).*exp(-coeffs(4).*xx.^2) + ...
     coeffs(5).*exp(-coeffs(6).*xx.^2) + ...
     coeffs(7).*exp(-coeffs(8).*xx.^2) + coeffs(9);
 end

