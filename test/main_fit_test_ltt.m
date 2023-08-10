%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main script for fitting the experimental data to the model
% from ISODISTORT. Here the initial parameters for the fit can be specified
% (A0, M1, M2, ...). Any of these fit parameters can be fixed in B0, P1,
% P2, ...
% NOTE that the calculate_residual needs to be opened and adjusted
% accordingly where needed (hkl conversion, plotting, ...)
% 
% O. Ivashko, Mar.2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The original (parent) structure is:
% space group #138 - P4_2/ncm
% a, b, c, alpha, beta, gamma = 5.35         5.35         13.2           90           90           90

% The superstructure in question is:
% 66 Cccm, basis={(0,0,2),(-2,-2,0),(1,-1,0)}, origin=(1,0,1), s=4, i=8, k-active= (1/4,1/4,1/2)
% For further details look into the specific subscripts

% addidng directories to the top of MATLAB path
addpath('~/isodistort2matlab/test/');
addpath(['~/isodistort2matlab/test/','atomic_form_factor/']);
addpath(['~/isodistort2matlab/test/','atomic_positions/']);
% addpath(['~/isodistort2matlab/test/','atomic_intensity/']);
addpath(['~/isodistort2matlab/test/','aux_residual/']);
addpath(['~/isodistort2matlab/test/','plots/']);

%% 
% starting values for the fit
A0 = [1 101.6 2e-4]; % [global_scaling_factor photon_energy_keV extinction_parameter]
% La/Ba modes
M1 = [0  0  0  0  0  0  0  0  0  0  0  0  0  0]*1e-2;
% M1 = ((rand(1,14)>0.5)*2-1).*rand(1,14)*1e-2;
% Cu modes
M2 = [0  0  0  0  0]*1e-2;
% M2 = ((rand(1,5)>0.5)*2-1).*rand(1,5)*1e-2;
% O1 modes
M3 = [0  0  0  0  0  0  0  0]*1e-2;
% M3 = ((rand(1,8)>0.5)*2-1).*rand(1,8)*1e-2;
% O2 modes
M4 = [0  0  0]*1e-2;
% M4 = ((rand(1,3)>0.5)*2-1).*rand(1,3)*1e-2;
% O3 modes
M5 = [0  0  0  0  0  0  0  0  0  0  0  0  0  0]*1e-2;
% M5 = ((rand(1,14)>0.5)*2-1).*rand(1,14)*1e-2;

% allowed parameters to vary in the fit: 0 - fixed; 1 - variable
B0 = [1 0 0];
% La/Ba modes
P1 = [1  1  1  1  1  1  1  1  1  1  1  1  1  1]*1;
% Cu modes
P2 = [1  1  1  1  1]*1;
% O1 modes
P3 = [1  1  1  1  1  1  1  1]*0;
% O2 modes
P4 = [1  1  1]*0;
% O3 modes
P5 = [1  1  1  1  1  1  1  1  1  1  1  1  1  1]*0;

fitpar0 = [A0,M1,M2,M3,M4,M5];
tofit = logical([B0,P1,P2,P3,P4,P5]);

update_residual_test_ltt(fitpar0,tofit);
pars=fitpar0(logical(tofit));
disp(['performing fit with ',num2str(sum(tofit(:))),' free parameter(s)'])

%% fit
% options = optimset('PlotFcns',@optimplotfval,'MaxFunEvals',1e5,'MaxIter',1e5);
options = optimset('PlotFcns',@optimplotfval);
[x,R1] = fminsearch(@calulate_residual_test_ltt,pars,options);
% recovering the full structure of the fitting parameters variable
fitpar = fitpar0; fitpar(tofit) = x;

%% plotting
% load and convert the data
[Q,Iexp,sigIexp,Q0,~] = load_data_test_ltt;
% supercell lattice parameters
aa = 26.4000;
bb = 15.1321;
cc = 7.5660;

occ = [0.87500  1.00000  1.00000  1.00000  1.00000  0.12500  ];

% evaluate the fit intensity
Icalc = evaluate_intensity_test_ltt(Q,aa,bb,cc,occ,fitpar(1),fitpar(2),fitpar(3),fitpar(4:end));

% plot
plot_title = ['test_ltt --- R1 = $',sprintf('%5.3f',R1*100),'\%$'];
saveflag = 1; % 0 - not saving; 1 - saving figures (if proper part uncommented)
plot_test_ltt(Q0,Iexp,Icalc,fitpar,aa,bb,cc,plot_title,saveflag);

