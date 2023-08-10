function R1=calulate_residual_test_ltt(xx)
% xx = [scale En extpar ampl_modes];

% load and convert the data
[Q,Iexp,sigIexp,Q0,~] = load_data_test_ltt;
% supercell lattice parameters
aa = 26.4000;
bb = 15.1321;
cc = 7.5660;


pars = [xx(1) 1.016000e+02 2.000000e-04...
xx(2) xx(3) xx(4) xx(5) xx(6) xx(7) xx(8) xx(9) xx(10) xx(11) xx(12) xx(13) xx(14) xx(15)...
xx(16) xx(17) xx(18) xx(19) xx(20)...
0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00...
0.000000e+00 0.000000e+00 0.000000e+00...
0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00...
];

occ = [0.87500  1.00000  1.00000  1.00000  1.00000  0.12500  ];
Icalc = evaluate_intensity_test_ltt(Q,aa,bb,cc,occ,pars(1),pars(2),pars(3),pars(4:end));

a=0.1;
b=0;
P=(2*Icalc+max(Iexp,0))/3;
w = 1/(sigIexp.^2 + (a*P).^2 + b*P);
wR2=sqrt( sum( w*(Iexp-Icalc).^2) / sum( w*Iexp.^2) );
npar=1; % numer of parameters
GooF = sqrt( sum(w*(Iexp-Icalc).^2)/(length(Iexp)-npar));

R1 = sum(abs(abs(sqrt(Iexp)) - abs(sqrt(Icalc))))/sum(abs(sqrt(Iexp)));

fprintf('Fit quality:  R1 = %8.5f    \n\t     wR2 = %8.5f\n\t    GooF = %8.5f\n',R1,wR2,GooF);

%% real-time plotting. comment to increase the speed of the fit
% plot_title = ['test_ltt --- R1 = $',sprintf('%5.3f',R1*100),'\%$'];
% saveflag = 0; % not saving figures as default
% plot_test_ltt(Q0,Iexp,Icalc,pars,aa,bb,cc,plot_title,saveflag);

