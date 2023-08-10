%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is a file creating the neccessary scripts to perform a fit to the
% structure factor data by using ISODISTORT. The file specified in
% file_isodist, is a text file containing all atoms and displacement
% vectors for the superstructure. It can be obtaioned by saving the
% information given in "Complete modes details".
%
% NOTE that the directories, file names and other variables have to be
% adjusted before running this code.
%
% ISODISTORT: https://stokes.byu.edu/iso/isodistort.php
%
% O. Ivashko, DESY, April.2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% main directory for these isodistort scripts
main_dirr_isodistort = '~/isodistort2matlab/';

% main directory for the experiment
main_dirr='~/isodistort2matlab/test/';
% main file name
file_name='test_ltt';

% direcory and file name for the "Complete modes details" output from ISODISTORT
dirr_isodist='~/isodistort2matlab/test/';
% file_isodist='complete_mode_test';
file_isodist='isod_ltt_test.txt';

% full path for the experimental data
data_fullpath=[main_dirr,'peak_list_test.mat'];

% UNCOMMENT and CHANGE the ### OPTIONAL substituent addition ### part if
% neccessary, i.e. in case the substituent is not included in the initial
% cif file. 
% NOTE1: When there is a substituent, there will also be two version of
% "intensity" function: evaluate_intensity_[file_name].m and
% evaluate_intensity_[file_name]_IS.m. In the latter case, the substituent
% is threated as an independent atom, thus it's position can be refined
% independently. To do so one needs to modify accordingly the
% main_fit_[file_name].m and plot_[file_name].m scripts.
% NOTE2: if the substituent is already included in the initial cif file,
% one might need to do the opposite and remove/modify some parts from the
% previously mentioned scripts.

% CHECK "occ_factors" variable. The following is ordered in the same way as
% the "atom_type" (same applies to "atom_type_valence").

% %%% CHANGE valence %%% ("atom_type_valence" variable below) for each atom
% if neccessary (default is neutral atom)

% CHANGE the conversion matrix (from Q0 into Q1) in load_data_[file_name].m if necessary

% Note that the residual function is dinamical. It is updated based on the
% fixed fit parameters in main_fit_[file_name].m by means of
% update_residual_[file_name].m. The following loads
% calulate_residual_[file_name]_head.m and
% calulate_residual_[file_name]_tail.m (all three are inside aux_residual
% folder). Thus, in order to have permanent modifications to the residual
% function, one needs to modify one of these scripts. For example,
% uncommenting the plot function in the calulate_residual_[file_name]_tail.m

%% creating the neccessary directories
if ~exist(main_dirr, 'dir'); mkdir(main_dirr); end
if ~exist([main_dirr,'atomic_form_factor/'], 'dir'); mkdir([main_dirr,'atomic_form_factor/']); end
if ~exist([main_dirr,'atomic_positions/'], 'dir'); mkdir([main_dirr,'atomic_positions/']); end
% if ~exist([main_dirr,'atomic_intensity/'], 'dir'); mkdir([main_dirr,'atomic_intensity/']); end
if ~exist([main_dirr,'aux_residual/'], 'dir'); mkdir([main_dirr,'aux_residual/']); end
if ~exist([main_dirr,'plots/'], 'dir'); mkdir([main_dirr,'plots/']); end

% addidng directories to MATLAB path
addpath(main_dirr_isodistort);
addpath([main_dirr_isodistort,'aux/']);
addpath([main_dirr_isodistort,'create/']);
addpath(main_dirr);
addpath([main_dirr,'atomic_form_factor/']);
addpath([main_dirr,'atomic_positions/']);
% addpath([main_dirr,'atomic_intensity/']);
addpath([main_dirr,'aux_residual/']);
addpath([main_dirr,'plots/']);
%% reading "Complete modes details" ISODISTORT output (saved as a .txt file)
[parent,superstructure,distortion]=get_isodistort(dirr_isodist,file_isodist);

%% preparing the necessary variables. CHANGE valence (atom_type_valence) for each atom if neccessary (default is 0 valence)
parent_info=parent.spacegroup; parent_info{1,3}=parent.lattice;
model_name=superstructure.name;   % ISODISTORT model description

ln=size(parent.occupation,1);
atom_type=cell(ln,1);             % atom types present in the supercell, e.g. La1
atom_kind=cell(ln,1);             % atom kinds present in the supercell, e.g. La
occ_factors=zeros(1,ln);          % occupation factors for each atom type
for idx=1:ln
    atom_type{idx}=parent.occupation{idx,1};
    atom_kind{idx}=atom_type{idx};
    while ~isnan(str2double(atom_kind{idx}(end))) % removing numeric labels from atoms
        atom_kind{idx}(end)='';
    end
    occ_factors(idx)=str2double(parent.occupation{idx,2});
end

latpar=superstructure.lattice;    % supercell lattice parameters
basis=superstructure.basis;       % supercell basis: hkl_super = basis' * hkl_parent
undist=distortion.position;       % supercell complete unit cell atom positions

modes=distortion.mode;            % mode header
normf=distortion.normfactor;      % normalization factor for each atom in the supercell and mode
displace=distortion.displacement; % displacement vector for each atom in the supercell and mode
% counting the number of atoms in the supercell and the number of modes for each atom type
fullatoms=distortion.type;
idx_mode=cell(ln,1); % idx_mode{atom_type_index}=[[#atoms+#prev_atoms in supercell] [#modes]]
for ida=1:ln
    for idx=1:size(fullatoms,1)
        for idy=1:size(fullatoms,2)
            if ~isempty(fullatoms{idx,idy})
                if fullatoms{idx,idy}==atom_type{ida,1}
                    idx_mode{ida}(1)=idx;
                    idx_mode{ida}(2)=idy;
                end
            end
        end
    end
end

%##########################################################################
%##################### OPTIONAL substituent addition ######################
%### if more than one atom has to be added, ln0 variable has to be updated
%### to "ln0=ln0+1;" (instead of "ln0=size(parent.occupation,1);") after ##
%### the first addition. ##################################################
% substituent atom type
sub_type='Ba'; sub_kind=sub_type; while ~isnan(str2double(sub_type(end))); sub_kind(end)=''; end
% atom type to be replaced
sub_replace_type='La'; sub_replace_kind=sub_replace_type;
% substituent fraction (0-1)
sub_fraction=1/8;

ln0=size(parent.occupation,1);
% finding indices
for idx=1:ln0
    if strcmp(atom_type{idx},sub_replace_type)
        sub_idx=idx;
        if idx==1
            sub_id1=1;
        else
            sub_id1=idx_mode{idx-1}(1)+1;
        end
        sub_id2=idx_mode{idx}(1);
        sub_modes=idx_mode{idx}(2);
        sub_start=idx_mode{ln0}(1);
        break
    end
    if idx==ln0
        error(['No ',sub_replace_type,' atom type is found in the current structure.' newline ...
              'See the variable idx_mode for a complete list of atom types.'])
    end
end

% adding (replicating) substituent information for the neccessary parameters
atom_type{ln0+1}=sub_type;
atom_kind{ln0+1}=sub_kind;
idx_mode{ln0+1}(1)=idx_mode{ln0}(1)+(sub_id2-sub_id1+1);
idx_mode{ln0+1}(2)=idx_mode{sub_idx}(2);
idx_mode{ln0+1}(3)=sub_idx; % saving substituted index to create two versions of intensity_evaluation_[file_name].m
occ_factors(sub_idx)=1-sub_fraction; occ_factors(ln0+1)=sub_fraction;
add_line=1;
for idx=sub_id1:sub_id2
    for idy=1:sub_modes
        undist{sub_start+add_line,idy}=undist{idx,idy};
        modes{sub_start+add_line,idy}=modes{idx,idy};
        displace{sub_start+add_line,idy}=displace{idx,idy};
        normf(sub_start+add_line,idy)=normf(idx,idy);
    end
    add_line=add_line+1;
end
% updating ln
ln=ln0+1;
%##########################################################################
%##########################################################################

% loading the parameters for atomic form factor evaluation given a certain valence for each atom type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% CHANGE VALENCE HERE %%%%%%%%%%%%%%%%%%%%%%%%%%%
atom_type_valence=atom_kind;
% atom_type_valence={'La3+','Cu2+','O2-','O2-','O2-','Ba2+'};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(atom_type_valence{1})
    error(['atom_type_valence not complete. ',...
           'Specify the valence for each atom in atom_type.'])
end
aff_coefs_table=readtable([main_dirr_isodistort,'aux/form_factor_coefficients.csv']);
aff_atoms=table2array(aff_coefs_table(:,1));
aff_coefs=table2array(aff_coefs_table(:,2:10));
aff_line=zeros(1,ln);
for num_atom=1:ln
    notcomplete=1;
    at=atom_type_valence{num_atom};
    for idx=1:size(aff_coefs,1)
        if strcmp(aff_atoms{idx},at)
            aff_line(num_atom)=idx;
            notcomplete=0;
            break
        end
    end
    if notcomplete
        error([at,' atom not found on the list.',newline,'See aff_atoms for options'])
    end
end
aff_numbers=aff_coefs(aff_line,:);

% creating atoms size and color for plotting
atom_size_table=readtable([main_dirr_isodistort,'aux/atomic_radius.csv']);
atom_names_all=table2array(atom_size_table(:,2));
atom_size_all=table2array(atom_size_table(:,4));
atom_size=ones(1,ln);
atom_color=ones(ln,3);
for num_atom=1:ln
    notcomplete=1;
    for idx=1:size(atom_size_all,1)
        if strcmp(atom_names_all{idx},atom_kind{num_atom})
            if isnan(atom_size_all(idx))
                atom_size(num_atom)=100;
            else
                atom_size(num_atom)=atom_size_all(idx);
            end
            atom_color(num_atom,:)=rand(1,3);
            notcomplete=0;
            break
        end
    end
    if notcomplete
        error([atom_kind{num_atom},' atom not found on the list.',newline,'See atom_names_all for options'])
    end
end
%% create atomic form factor evaluation script(s)
nm_atff_scripts=create_atom_form_factor(main_dirr_isodistort,...
                                        main_dirr,file_name,...
                                        atom_type,aff_numbers,...
                                        atom_type_valence);
disp(['created atomic-form-factor scripts in:',newline,'   ',main_dirr,'atomic_form_factor/'])
%% create atom-position evaluation script(s)
nm_atpos_scripts=create_atom_positions(main_dirr_isodistort,...
                                       main_dirr,file_name,...
                                       atom_type,modes,idx_mode,normf,...
                                       undist,displace);
disp(['created atomic-position scripts in:',newline,'   ',main_dirr,'atomic_positions/'])
%% create intensity evaluation script
nm_inteval_script=create_intensity_evaluation(main_dirr_isodistort,...
                                              main_dirr,file_name,idx_mode,...
                                              nm_atpos_scripts,nm_atff_scripts);
disp(['created intensity-evaluation script:',newline,'   ',main_dirr,nm_inteval_script,'.m'])
%% create plotting script
nm_plot_script=create_plot(main_dirr_isodistort,...
                           main_dirr,file_name,...
                           nm_atpos_scripts,...
                           idx_mode,atom_type,...
                           atom_size,atom_color);
disp(['created plotting script: ',newline,'   ',main_dirr,nm_plot_script,'.m'])
%% create data load and conversion script
nm_load_script=create_load(main_dirr_isodistort,...
                           main_dirr,file_name,...
                           data_fullpath,basis);
disp(['created load-data script: ',newline,'   ',main_dirr,nm_load_script,'.m'])
%% create residual calculation scripts
nm_res_script=create_residual(main_dirr_isodistort,...
                              main_dirr,file_name,...
                              nm_inteval_script,...
                              nm_load_script,nm_plot_script,...
                              latpar,occ_factors);
disp(['created residual-evaluation scripts: ',newline,'   ',...
    main_dirr,'aux_residual/',nm_res_script,'_head.m',newline,'   ',...
    main_dirr,'aux_residual/',nm_res_script,'_tail.m'])
%% create update residual calculation script
nm_upres_script=create_update_residual(main_dirr_isodistort,...
                                       main_dirr,file_name,...
                                       nm_res_script,idx_mode);
disp(['created update-residual script: ',newline,'   ',main_dirr,'aux_residual/',nm_upres_script,'.m'])
%% create fit intensity script
nm_main_fitint_script=create_fit_intensity(main_dirr_isodistort,...
                                           main_dirr,file_name,...
                                           atom_type,idx_mode,model_name,parent_info,...
                                           latpar,occ_factors,nm_inteval_script,...
                                           nm_plot_script,nm_load_script,...
                                           nm_res_script,nm_upres_script);
disp(['created main script: ',newline,'   ',main_dirr,nm_main_fitint_script,'.m'])

