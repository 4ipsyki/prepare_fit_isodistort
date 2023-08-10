function R1=calulate_residual_test_ltt(xx)
% xx = [scale En extpar ampl_modes];

% load and convert the data
[Q,Iexp,sigIexp,Q0,~] = load_data_test_ltt;
% supercell lattice parameters
aa = 26.4000;
bb = 15.1321;
cc = 7.5660;

