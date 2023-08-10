function name_scripts=create_atom_positions(main_dirr_isodistort,...
                                            main_dirr,file_name,...
                                            atom_type,modes,idx_mode,normf,...
                                            undist,displace)

code_01 = fileread([main_dirr_isodistort,'aux/apos_01.m']);
code_02   = fileread([main_dirr_isodistort,'aux/apos_02.m']);

ll=size(idx_mode,1);
name_scripts = cell(ll,1);
atstart=1;
for idx=1:ll
    name_scripts{idx} = ['atomic_positions_',atom_type{idx},'_',file_name];
    func_name = ['function yy=',name_scripts{idx},'(xx)' newline];
    
    undistorted_code = [newline 'undist = [' newline];
    modes_code = [newline '% The following modes are considered:' newline];
    distorted_code = [newline 'dist = [' newline];
    atend=idx_mode{idx}(1,1);
    modeend=idx_mode{idx}(1,2);
    for ii=atstart:atend
        undistorted_code=[undistorted_code,sprintf('%9.6f',undist{ii,1}),';' newline];
        for jj=1:modeend
            temp_code=['xx(',num2str(jj),') * ',sprintf('%9.6f',normf(ii,jj)),...
                       ' * [',sprintf('%9.6f',displace{ii,jj}(1)),' ',...
                            sprintf('%9.6f',displace{ii,jj}(2)),' ',...
                            sprintf('%9.6f',displace{ii,jj}(3)),']'];
            distorted_code = [distorted_code,temp_code];
            if ii==atstart
                modes_code = [modes_code,'% ',modes{ii,jj} newline];
            end
            if jj<modeend
                distorted_code = [distorted_code,' + '];
            end
        end
        distorted_code = [distorted_code,';' newline];
    end
    undistorted_code = [undistorted_code,'];' newline];
    distorted_code = [distorted_code,'];' newline];
    atstart=atend+1;
    
    full_code = [func_name,code_01,undistorted_code,modes_code,distorted_code,code_02];
    
    full_name = [main_dirr,'atomic_positions/',name_scripts{idx},'.m'];
    fid = fopen(full_name, 'w');
    if fid < 0, error(['Cannot open file ',full_name]); end
    fwrite(fid,full_code);
    fclose(fid);
end
end