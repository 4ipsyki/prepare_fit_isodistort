
a=0.1;
b=0;
P=(2*Icalc+max(Iexp,0))/3;
w = 1/(sigIexp.^2 + (a*P).^2 + b*P);
wR2=sqrt( sum( w*(Iexp-Icalc).^2) / sum( w*Iexp.^2) );
npar=1; % numer of parameters
GooF = sqrt( sum(w*(Iexp-Icalc).^2)/(length(Iexp)-npar));

R1 = sum(abs(abs(sqrt(Iexp)) - abs(sqrt(Icalc))))/sum(abs(sqrt(Iexp)));

fprintf('Fit quality:  R1 = %8.5f    \n\t     wR2 = %8.5f\n\t    GooF = %8.5f\n',R1,wR2,GooF);

