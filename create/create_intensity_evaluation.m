function name_script=create_intensity_evaluation(main_dirr_isodistort,...
                                                 main_dirr,file_name,idx_mode,...
                                                 nm_atpos_scripts,nm_atff_scripts)

if length(nm_atpos_scripts) ~= length(nm_atff_scripts)
    error('The number of atomic-position and atomic-form-factor scripts is not the same.')
end

name_script=['evaluate_intensity_',file_name];
func_name=['function yy = ',name_script,'(Q,aa,bb,cc,occ,scale,En,extpar,modepar)' newline];

code_01 = fileread([main_dirr_isodistort,'aux/int_01.m']);

% structure factor part
F_code_IS='';
ll=length(nm_atpos_scripts);
i_start=1; i_stop=i_start-1+idx_mode{1}(2);
F_code=[newline 'F = sum(occ(1)*repmat(',nm_atff_scripts{1},'(Q,aa,bb,cc),1,',num2str(idx_mode{1}(1)),')',...
                ' .* exp(-2*pi*1i * Q*transp(',nm_atpos_scripts{1},...
                '(modepar(',num2str(i_start),':',num2str(i_stop),')))),2)'];
i_start=i_stop+1;
for idx=2:ll
    i_stop=i_start-1+idx_mode{idx}(2);
    if size(idx_mode{idx},2)==3
        idx_atpos=idx_mode{idx}(3);
        if isempty(F_code_IS)
            F_code_IS=F_code;
        end
        i_start_n=1;
        if ~idx_mode{idx}(3)==1
            for ii=1:idx_mode{idx}(3)-1
                i_start_n=i_start_n+idx_mode{ii}(2);
            end
        end
        i_stop_n=i_start_n-1+idx_mode{idx_atpos}(2);
    else
        idx_atpos=idx;
        i_start_n=i_start;
        i_stop_n=i_stop;
    end
    F_code=[F_code,'+ ...' newline '    '...
                   'sum(occ(',num2str(idx),')*repmat(',nm_atff_scripts{idx},'(Q,aa,bb,cc),1,',num2str(idx_mode{idx}(1)-idx_mode{idx-1}(1)),')',...
                   ' .* exp(-2*pi*1i * Q*transp(',nm_atpos_scripts{idx_atpos},...
                   '(modepar(',num2str(i_start_n),':',num2str(i_stop_n),')))),2)'];
    if ~isempty(F_code_IS)
        F_code_IS=[F_code_IS,'+ ...' newline '    '...
                             'sum(occ(',num2str(idx),')*repmat(',nm_atff_scripts{idx},'(Q,aa,bb,cc),1,',num2str(idx_mode{idx}(1)-idx_mode{idx-1}(1)),')',...
                             ' .* exp(-2*pi*1i * Q*transp(',nm_atpos_scripts{idx},...
                             '(modepar(',num2str(i_start),':',num2str(i_stop),')))),2)'];
    end
    i_start=i_stop+1;
end
F_code=[F_code,';' newline];

code_02   = fileread([main_dirr_isodistort,'aux/int_02.m']);

full_code = [func_name,code_01,F_code,code_02];

% saving
full_name=[main_dirr,name_script,'.m'];
fid = fopen(full_name, 'w');
if fid < 0, error(['Cannot open file ',full_name]); end
fwrite(fid,full_code);
fclose(fid);

if ~isempty(F_code_IS)
    func_name=['function yy = ',name_script,'_IS(Q,aa,bb,cc,occ,scale,En,extpar,modepar)' newline ...
               '% This is an alternative version of the intensity evaluation.' newline ...
               '% Here the substituents positions are independent of the sustituted and thus can be fitted.' newline];

    full_code = [func_name,code_01,F_code_IS,code_02];

    % saving
    full_name=[main_dirr,name_script,'_IS.m'];
    fid = fopen(full_name, 'w');
    if fid < 0, error(['Cannot open file ',full_name]); end
    fwrite(fid,full_code);
    fclose(fid);
end
end