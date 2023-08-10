function names_scripts=create_atom_form_factor(main_dirr_isodistort,...
                                               main_dirr,file_name,...
                                               atom_type,aff_numbers,...
                                               atom_type_valence)

  code_01 = fileread([main_dirr_isodistort,'aux/aff_01.m']);
  code_02   = fileread([main_dirr_isodistort,'aux/aff_02.m']);
   
  ll = size(aff_numbers,1);
  names_scripts = cell(ll,1);
  for idx=1:ll
  	names_scripts{idx} = ['aff_',atom_type{idx},'_',file_name];
    func_name = ['function yy = ',names_scripts{idx},'(Q,aa,bb,cc)' newline];
    coef_code = [newline '% ',atom_type_valence{idx} newline ...
                 'coeffs = [',num2str(aff_numbers(idx,:)),'];' newline];
    
    full_code = [func_name,code_01,coef_code,code_02];
    
    full_name = [main_dirr,'atomic_form_factor/',names_scripts{idx},'.m'];
    fid = fopen(full_name, 'w');
    if fid < 0, error(['Cannot open file ',full_name]); end
    fwrite(fid,full_code);
    fclose(fid);
  end
end