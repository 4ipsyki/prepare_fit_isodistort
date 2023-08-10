function name_script=create_plot(main_dirr_isodistort,...
                                 main_dirr,file_name,...
                                 nm_atpos_scripts,...
                                 idx_mode,atom_type,...
                                 atom_size,atom_color)

name_script=['plot_',file_name];
func_name=['function ',name_script,'(Q0,Iexp,Icalc,pars,aa,bb,cc,plot_title,saveflag)' newline newline ...
           '% saveflag = 0; ===> figures are not saved automatically' newline ...
           '% saveflag = 1; ===> figures are saved automatically (if saving line is uncommented)' newline ...
           'if nargin == 7' newline ...
           '    plot_title = ''',file_name,''';' newline ...
           '    saveflag = 0;' newline ...
           'elseif nargin == 8' newline ...
           '    saveflag = 0;' newline ...
           'end' newline newline ...
           'plot_name = plot_title; % master file name for figures' newline ...
           'plot_fullpath = ''',main_dirr,'plots/'';' newline];

code_01=fileread([main_dirr_isodistort,'aux/plot_01.m']);

% preparation for supercell plotting
size_code=[newline '%% supercell plot' newline ...
           '% atoms ionic size' newline ...
           'asz = [',num2str(atom_size(:)'),'];' newline];
color_code=[newline '% atoms color in RGB/255' newline 'cl = ['];
scell0_code=newline;
scell_code=newline;
ll=length(nm_atpos_scripts);
i_start=1;
for idx=1:ll
    i_stop=i_start-1+idx_mode{idx}(2);
    if size(idx_mode{idx},2)==3
        scell0_code=[scell0_code,'% ',atom_type{idx} newline '% '];
        scell_code=[scell_code,'% ',atom_type{idx} newline '% '];
                
    else
        scell0_code=[scell0_code,'% ',atom_type{idx}, newline];
        scell_code=[scell_code,'% ',atom_type{idx}, newline];
    end
    scell0_code=[scell0_code,'pos0{',num2str(idx),'} = ',...
                 nm_atpos_scripts{idx},'(zeros(1,',...
                 num2str(i_stop-i_start+1),'));' newline];
    scell_code=[scell_code,'pos{',num2str(idx),'} = ',...
                nm_atpos_scripts{idx},'(pars(',...
                num2str(3+i_start),':',num2str(3+i_stop),...
                '));' newline];
    i_start=i_stop+1;
    if idx==ll
        color_code=[color_code,'    ',num2str(atom_color(idx,:)),'];' newline];
    elseif idx==1
        color_code=[color_code,num2str(atom_color(idx,:)),';' newline];
    else
        color_code=[color_code,'    ',num2str(atom_color(idx,:)),';' newline];
    end
end

legend_code=[newline 'leg = {'];
for idx=1:size(atom_type,1)
    if size(idx_mode{idx},2)==3
        legend_code = strrep(legend_code,atom_type{idx_mode{idx}(3)},[atom_type{idx_mode{idx}(3)},'/',atom_type{idx}]);
    else
        legend_code = strcat(legend_code,['''',atom_type{idx},''' ;']);
    end
end
legend_code = strcat(legend_code,['''a_{super}'';''b_{super}'';''c_{super}''};' newline newline]);

code_02=fileread([main_dirr_isodistort,'aux/plot_02.m']);

full_code=[func_name,code_01,...
           size_code,color_code,scell0_code,scell_code,legend_code,code_02];

% saving
full_name=[main_dirr,name_script,'.m'];
fid = fopen(full_name, 'w');
if fid < 0, error(['Cannot open file ',full_name]); end
fwrite(fid,full_code);
fclose(fid); 
end