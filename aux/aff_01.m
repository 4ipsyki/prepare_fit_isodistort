% evaluates the atomic form factor for a given set of Q points [hkl],
% and lattice parameters aa,bb and cc [Angstroem]

xx = 1/2*sqrt((Q(:,1)/aa).^2 + (Q(:,2)/bb).^2 + (Q(:,3)/cc).^2);
