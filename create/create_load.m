function name_script=create_load(main_dirr_isodistort,...
                                 main_dirr,file_name,...
                                 data_fullpath,basis)

name_script=['load_data_',file_name];
func_name=['function [Q,Iexp,sigIexp,Q0,Q1]=',name_script newline newline];

load_code=['data = load(''',data_fullpath,''');' newline];

code_01 = fileread([main_dirr_isodistort,'aux/load_01.m']);

conversion_code=['% transformation from parent to superstrucure notation' newline ...
           'basis = [',num2str(basis(1,:)),'; ',...
                       num2str(basis(2,:)),'; ',...
                       num2str(basis(3,:)),'];' newline ...
           'Q = transpose(transpose(basis)*transpose(Q1));' newline ...
           'end' newline];

full_code=[func_name,load_code,code_01,conversion_code];

% saving
full_name=[main_dirr,name_script,'.m'];
fid = fopen(full_name, 'w');
if fid < 0, error(['Cannot open file ',full_name]); end
fwrite(fid,full_code);
fclose(fid);
end