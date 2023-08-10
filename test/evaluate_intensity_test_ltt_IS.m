function yy = evaluate_intensity_test_ltt_IS(Q,aa,bb,cc,occ,scale,En,extpar,modepar)
% This is an alternative version of the intensity evaluation.
% Here the substituents positions are independent of the sustituted and thus can be fitted.

% Function calculating the intesity for a given lattice aa,bb,cc with
% occupation occ for each atom, a distortion information modepar on 
% reciprocal space points given in Q. For extinction correction, the energy
% En [keV] and the extinction parameter extpar are used. The resulting
% intensity is multiplied to the scale factor to match the experiment.


F = sum(occ(1)*repmat(aff_La_test_ltt(Q,aa,bb,cc),1,64) .* exp(-2*pi*1i * Q*transp(atomic_positions_La_test_ltt(modepar(1:14)))),2)+ ...
    sum(occ(2)*repmat(aff_Cu_test_ltt(Q,aa,bb,cc),1,32) .* exp(-2*pi*1i * Q*transp(atomic_positions_Cu_test_ltt(modepar(15:19)))),2)+ ...
    sum(occ(3)*repmat(aff_O1_test_ltt(Q,aa,bb,cc),1,32) .* exp(-2*pi*1i * Q*transp(atomic_positions_O1_test_ltt(modepar(20:27)))),2)+ ...
    sum(occ(4)*repmat(aff_O2_test_ltt(Q,aa,bb,cc),1,32) .* exp(-2*pi*1i * Q*transp(atomic_positions_O2_test_ltt(modepar(28:30)))),2)+ ...
    sum(occ(5)*repmat(aff_O3_test_ltt(Q,aa,bb,cc),1,64) .* exp(-2*pi*1i * Q*transp(atomic_positions_O3_test_ltt(modepar(31:44)))),2)+ ...
    sum(occ(6)*repmat(aff_Ba_test_ltt(Q,aa,bb,cc),1,64) .* exp(-2*pi*1i * Q*transp(atomic_positions_Ba_test_ltt(modepar(45:58)))),2)
modsF = (abs(F)).^2;

lambda = 12.3984/En;
theta = asind(lambda./2*sqrt((Q(:,1)/aa).^2+(Q(:,2)/bb).^2+(Q(:,3)/cc).^2));
extinction = (1+1e-3*extpar*modsF*lambda^3./sind(2*theta)).^(-1/2);

yy = scale * extinction .* modsF;

end

