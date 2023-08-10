h = data(:,1);
k = data(:,2);
l = data(:,3);
Iexp = data(:,4);
sigIexp = data(:,5);

Q0 = [h(:),k(:),l(:)];

Q1 = Q0;
% insert here supplementary transformations if applicable
% for example in LBCO, to go from HTT to LTT(parent) notation use:
% Q1 = transpose([1 1 0; 1 -1 0; 0 0 1]*transpose(Q0));

