function name_script=create_residual(main_dirr_isodistort,...
                                     main_dirr,file_name,...
                                     nm_inteval_script,...
                                     nm_load_script,nm_plot_script,...
                                     latpar,occ_factors)
% two codes are saved calulate_residual_[file_name]_head.m and 
% calulate_residual_[file_name]_tail.m. These are used to create the final
% calculate_residual_[file_name].m script which is used for the fit. In
% between the "head" and "tail" is inserted the part of the code which
% links the xx and pars variables based on the fixed parameters for the
% fit, i.e. pars will be a number for fixed ones and xx(idx) for variable.

name_script=['calulate_residual_',file_name];
func_name=['function R1=',name_script,'(xx)' newline ...
           '% xx = [scale En extpar ampl_modes];' newline];

load_code=[newline '% load and convert the data' newline ...
           '[Q,Iexp,sigIexp,Q0,~] = ',nm_load_script,';' newline ...
           '% supercell lattice parameters' newline ...
           'aa = ',sprintf('%6.4f',latpar(1)),';' newline ...
           'bb = ',sprintf('%6.4f',latpar(2)),';' newline ...
           'cc = ',sprintf('%6.4f',latpar(3)),';' newline newline];

head_code=[func_name,load_code];

% saving first (head) part
full_name=[main_dirr,'aux_residual/',name_script,'_head.m'];
fid = fopen(full_name, 'w');
if fid < 0, error(['Cannot open file ',full_name]); end
fwrite(fid,head_code);
fclose(fid);

int_code = [newline 'occ = [',sprintf('%6.5f  ',occ_factors),'];' newline ...
            'Icalc = ',nm_inteval_script,...
            '(Q,aa,bb,cc,occ,pars(1),pars(2),pars(3),pars(4:end));' newline];

code_01 = fileread([main_dirr_isodistort,'aux/resi_01.m']);

plot_code =['%% real-time plotting. comment to increase the speed of the fit' newline ...
            '% plot_title = [''',file_name,' --- R1 = $'',sprintf(''%5.3f'',R1*100),''\%$''];' newline ...
            '% saveflag = 0; % not saving figures as default' newline ...
            '% ',nm_plot_script,'(Q0,Iexp,Icalc,pars,aa,bb,cc,plot_title,saveflag);' newline newline];

tail_code=[int_code,code_01,plot_code];

% saving second (tail) part
full_name=[main_dirr,'aux_residual/',name_script,'_tail.m'];
fid = fopen(full_name, 'w');
if fid < 0, error(['Cannot open file ',full_name]); end
fwrite(fid,tail_code);
fclose(fid);
end

