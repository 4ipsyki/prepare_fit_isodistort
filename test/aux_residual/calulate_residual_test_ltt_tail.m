
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

