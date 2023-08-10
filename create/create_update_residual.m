function name_script=create_update_residual(main_dirr_isodistort,...
                                            main_dirr,file_name,...
                                            nm_res_script,idx_mode)
% stiches toghether the two calulate_residual_[file_name]_head and _tail
% scripts, and adding the pars variable which depends on the fixed
% parameters in the fit

name_script=['update_residual_',file_name];
func_name=['function reply=',name_script,'(fitpar0,tofit)' newline ...
           'reply = 0; % initializing the reply to not successful creation of residual script' newline];

head_code=[newline 'head_code=fileread(''',main_dirr,'aux_residual/',...
           nm_res_script,'_head.m'');' newline];

spacing_code=[newline 'spacer = {'' '';'' '';''new'';'];
for idx=1:size(idx_mode,1)
    for idy=1:idx_mode{idx}(2)
        if idy==idx_mode{idx}(2)
            spacing_code=strcat(spacing_code,'''new'';');
        else
            spacing_code=strcat(spacing_code,''' '';');
        end
    end
end
spacing_code=strcat(spacing_code,sprintf('};'));

code_01=fileread([main_dirr_isodistort,'aux/upres_01.m']);

tail_code=[newline 'tail_code=fileread(''',main_dirr,'aux_residual/',...
           nm_res_script,'_tail.m'');' newline];

combination_code=[newline 'full_code=[head_code,pars_code,tail_code];' newline newline ...
                  '% saving' newline ...
                  'full_name=[''',main_dirr,nm_res_script,'.m''','];' newline newline];

code_02=fileread([main_dirr_isodistort,'aux/upres_02.m']);

full_code=[func_name,head_code,spacing_code,code_01,tail_code,combination_code,code_02];

% saving
full_name=[main_dirr,'aux_residual/',name_script,'.m'];
fid = fopen(full_name, 'w');
if fid < 0, error(['Cannot open file ',full_name]); end
fwrite(fid,full_code);
fclose(fid);
end

