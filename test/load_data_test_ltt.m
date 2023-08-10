function [Q,Iexp,sigIexp,Q0,Q1]=load_data_test_ltt

data = load('~/isodistort2matlab/test/peak_list_test.mat');
data = data.peak_list_test;

h = data(:,1);
k = data(:,2);
l = data(:,3);
Iexp = data(:,4);
sigIexp = data(:,5);

Q0 = [h(:),k(:),l(:)];

% Q1 = Q0;
% insert here supplementary transformations if applicable
% for example in LBCO, to go from HTT to LTT(parent) notation use:
Q1 = transpose([1 1 0; 1 -1 0; 0 0 1]*transpose(Q0));

% transformation from parent to superstrucure notation
basis = [0 -2  1; 0 -2 -1; 2  0  0];
Q = transpose(transpose(basis)*transpose(Q1));
end
