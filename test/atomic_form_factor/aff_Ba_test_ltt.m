function yy = aff_Ba_test_ltt(Q,aa,bb,cc)
% evaluates the atomic form factor for a given set of Q points [hkl],
% and lattice parameters aa,bb and cc [Angstroem]

xx = 1/2*sqrt((Q(:,1)/aa).^2 + (Q(:,2)/bb).^2 + (Q(:,3)/cc).^2);

% Ba2+
coeffs = [20.1807      3.21367      19.1136      0.28331      10.9054      20.0558      0.77634       51.746      3.02902];

yy = coeffs(1).*exp(-coeffs(2).*xx.^2) + ...
     coeffs(3).*exp(-coeffs(4).*xx.^2) + ...
     coeffs(5).*exp(-coeffs(6).*xx.^2) + ...
     coeffs(7).*exp(-coeffs(8).*xx.^2) + coeffs(9);
 end

