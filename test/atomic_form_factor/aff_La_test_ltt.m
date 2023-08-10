function yy = aff_La_test_ltt(Q,aa,bb,cc)
% evaluates the atomic form factor for a given set of Q points [hkl],
% and lattice parameters aa,bb and cc [Angstroem]

xx = 1/2*sqrt((Q(:,1)/aa).^2 + (Q(:,2)/bb).^2 + (Q(:,3)/cc).^2);

% La3+
coeffs = [20.2489       2.9207      19.3763     0.250698      11.6323      17.8211     0.336048      54.9453       2.4086];

yy = coeffs(1).*exp(-coeffs(2).*xx.^2) + ...
     coeffs(3).*exp(-coeffs(4).*xx.^2) + ...
     coeffs(5).*exp(-coeffs(6).*xx.^2) + ...
     coeffs(7).*exp(-coeffs(8).*xx.^2) + coeffs(9);
 end

