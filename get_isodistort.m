function [parent,superstructure,distortion]=get_isodistort(dirr,file)
% function [parent,superstructure,distortion]=get_isodistort(dirr,file)
% GET_ISODISTORT reads the ascii file containing the "Complete modes
% details".
% The extracted parameters are:
% a. parent structure
%       - parent.spacegroup
%       - parent.lattice ============> lattice parameters and angles
%       - parent.occupation =========> atom type - occupation factors pairs
% b. undistorted superstructure
%       - superstructure.name
%       - superstructure.spacegroup
%       - superstructure.lattice
%       - superstructure.basis
%       - superstructure.origin
%       - superstructure.qvector
% d. distortion modes for EACH atom in the superstructure
%       - distortion.label
%       - distortion.atom ===========> list of all atom labels for each mode
%       - distortion.type ===========> type of atom
%       - distortion.mode ===========> mode label
%       - distortion.position =======> position of each atom in
%                                      superstructure fractional coordinates
%                                      for each mode
%       - distortion.normfactor =====> scaling factor for each mode
%       - distortion.displacement ===> displacement for each mode
% 
% distortion.normfactor is a matrix of (#atoms,#modes). The #modes is not
% the same for each atom. Thus each row is padded with zeros accordingly.
% All fields in distortion, except for normfactor and label, are a cell
% matrix of {#atoms,#modes}. Each row is padded with empty matrix accordingly.
% 
% The position of an atom "i" subjected to a mode "j" is evaluated as:
%   pos_ij = distortion.position{i,j} +
%            distortion.normfactor(i,j) * distortion.displacement{i,j}
%
% The following rule applies:
%  superstructure.lattice(1)*distortion.normfactor(i,j)*abs(distortion.displacement{i,j}(1))=1
%   if distortion.displacement{i,j}(1) is non-null
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

if size(split(file,'.'),1)==1; file=[file,'.txt']; end

fid = fopen([dirr,file]);
if fid==-1
    disp('File not found')
    disp([dirr,file])
    return
end

% reading the first line of the file
dataline=fgetl(fid);

% extracting the parent-lattice structure information
mys='Parent structure';
ok=1;
while ok
    if strncmp(dataline,mys,length(mys))
        ok=0;
        %space group
        temp=split(dataline,{'(',')',' '});
        parent.spacegroup{1}=str2double(temp{4});
        parent.spacegroup{2}=temp{5};

        %lattice parameters
        dataline=fgetl(fid);
        temp=split(dataline,{',','='});
        parent.lattice=str2double({temp{2},temp{4},temp{6},temp{8},temp{10},temp{12}});

        fgetl(fid); % skipping a line
        
        % occupation factors
        idx=1;
        dataline=fgetl(fid);
        while ~isempty(dataline)
            temp1=split(dataline);
            parent.occupation{idx,1}=temp1{1};
            parent.occupation{idx,2}=temp1{6};
            dataline=fgetl(fid);
            idx=idx+1;
        end
    else
        dataline=fgetl(fid);
    end
end

% extracting the supercell structure information
mys='Subgroup details';
ok=1;
while ok
    if strncmp(dataline,mys,length(mys))
        ok=0;
        dataline=fgetl(fid);

        %isodistort output
        superstructure.name=dataline;

        %space group
        temp=split(dataline);
        superstructure.spacegroup{1}=str2double(temp{1});
        superstructure.spacegroup{2}=temp{2}(1:end-1);

        %basis [a,b,c]
        temp1=split(temp{3},{'{','}'});
        temp2=split(temp1{2},{'),(','(',')'});
        superstructure.basis(:,1)=str2double(split(temp2{2},','));
        superstructure.basis(:,2)=str2double(split(temp2{3},','));
        superstructure.basis(:,3)=str2double(split(temp2{4},','));

        %origin
        temp1=split(temp{4},{'=(','),'});
        superstructure.origin(1,:)=str2double(split(temp1{2},','));

        %q vector of the superstructure in parent representation
        temp2=split(temp{8}(2:end-1),{'(',',',')'});
        idl=1; ide=0;
        for idx=1:size(temp2,1)
            if ~isempty(temp2{idx})
                ide=ide+1;
                superstructure.qvector{idl,ide}=temp2{idx};
                if ide==3
                    ide=0;
                    idl=idl+1;
                end
            end
        end
    else
        dataline=fgetl(fid);
    end
end
mys='Undistorted superstructure';
ok=1;
while ok
    if strncmp(dataline,mys,length(mys))
        ok=0;

        %lattice parameters
        dataline=fgetl(fid);
        temp=split(dataline,{',','='});
        superstructure.lattice=str2double({temp{2},temp{4},temp{6},temp{8},temp{10},temp{12}});

        % structure label for the structure table
        idx=1;
        dataline=fgetl(fid);
        while isempty(dataline)
            superstructure.structurelabel{idx}=split(dataline);
            dataline=fgetl(fid);
        end
    else
        dataline=fgetl(fid);
    end
end

% extracting position  and displacive modes for each atom in supercell
mys='Displacive mode definitions'; % starting line with mode(s) details
ok=1;

mysmode='Displacive mode amplitudes'; % stoping line with mode(s) details
modeok=1;
while ok % finding the starting line
    if strncmp(dataline,mys,length(mys))
        ok=0;
    else
        dataline=fgetl(fid);
    end
end

        dataline=fgetl(fid); % reading next line until a non-empty one is found
        while isempty(dataline)
            dataline=fgetl(fid);
        end
        distortion.label=dataline; % the very fist line explains the 
                                   % order and meaning of each collumn

        dataline=fgetl(fid); % first mode header

        % initializzation of the fields (i.e. first mode)
        mode=dataline;
        temp=split(dataline,'=');
        normfactor=str2double(temp{2}); % last number is the normalization
                                        % factor for the current mode
        dataline=fgetl(fid); % reading next line where the position and 
                             % displacements for the first atom are indicated.
                             % the first collumn of the first line indiates the atom.
                             % if the atom is still the same, the label is skipped
                             % on the next lines, until a new atom
        temp=split(dataline);
        atom=temp{1};
        at=1; cl=0; % at is atom, i.e. row number; cl is the mode, i.e. the collumn number
        distortion.atom{at,cl+1}=atom; temptype=split(atom,'_');
        distortion.type{at,cl+1}=temptype{1};
        distortion.mode{at,cl+1}=mode;
        distortion.normfactor(at,cl+1)=normfactor;
        distortion.position{at,cl+1}(1:3)=str2double(temp(2:4));
        distortion.displacement{at,cl+1}(1:3)=str2double(temp(5:7));

        newmode=0; % this is used to ditinguish the very first mode from successives
        dataline=fgetl(fid);
        while modeok
            if strncmp(dataline,mysmode,length(mysmode))
                modeok=0;
            else
                % new mode check and update of the normfactor and mode
                % parameters
                if newmode
                    mode=dataline; % mode header
                    temp=split(dataline,'=');
                    normfactor=str2double(temp{2});
                    dataline=fgetl(fid);
                end
                % going through the current mode
                while ~isempty(dataline) % each mode is separated by an empty line
                    temp=split(dataline);
                    % checking if the line contains ainformation about atom
                    if ~isempty(temp{1})
                        atom=temp{1}; % update atom
                        % checking if atom is already present in the list
                        found=0;
                        for idx=1:size(distortion.atom,1)
                            if strcmp(distortion.atom{idx,1},atom)
                                found=1;
                                break
                            end
                        end
                        % updating at and cl parameters
                        if found
                            at=idx;
                            % cl is either the index of the last
                            % element for the current line or the last
                            % non-empty element index, since the matrix
                            % is padded with zeros once a new element
                            % is added on a new collumn on a different line
                            for idxcl=1:size(distortion.normfactor(at,:),2)
                                cl=idxcl;
                                if distortion.normfactor(at,idxcl)==0
                                    cl=idxcl-1;
                                    break
                                end
                            end
                        else % first entry of completely new atom
                           at=idx+1;
                           cl=0;
                        end
                    else % atom is not changed from the previous loop
                        at=at+1; % row number is gradually increased
                        % updating cl based on the case if it's the
                        % very first entry for the current atom or if
                        % it already had an entry for a previous mode
                        if size(distortion.normfactor(:,1),1)<at
                            cl=0;
                        else
                            for idxcl=1:size(distortion.normfactor(at,:),2)
                                cl=idxcl;
                                if distortion.normfactor(at,idxcl)==0
                                    cl=idxcl-1;
                                    break
                                end
                            end
                        end
                    end
                    % adding details on the updated at and cl coordinates
                    distortion.atom{at,cl+1}=atom; temptype=split(atom,'_');
                    distortion.type{at,cl+1}=temptype{1};
                    distortion.mode{at,cl+1}=mode;
                    distortion.normfactor(at,cl+1)=normfactor;
                    distortion.position{at,cl+1}(1:3)=str2double(temp(2:4));
                    distortion.displacement{at,cl+1}(1:3)=str2double(temp(5:7));
                    
                    % going onto the next line to check if the current
                    % mode was added completely. Each mode is separated
                    % by an empty line
                    dataline=fgetl(fid);
                end
                % after the very first mode is added, the mode details
                % need to be updated each time
                newmode=1;
            end
            % since the current mode was added, the current line is an
            % empty one. Thus the next line is either the stop-string
            % or a new-mode header
            dataline=fgetl(fid);
        end
% closing the file
fclose(fid);
end