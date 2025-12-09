function constructor=scad2stl(scad_file_name,stl_file_name, varargin)

global stl_dir




if not(ispc)
    openscad='env LD_LIBRARY_PATH='''' openscad';
else
    openscad='openscad';
end
% has_scad=contains(scad_file_name,'.scad');
% if not(has_scad)
%     if isfile([scad_file_name,'.scad'])
%         scad_file_name=[scad_file_name,'.scad'];
%     elseif isfile([scad_file_name,'.SCAD'])
%         scad_file_name=[scad_file_name,'.SCAD'];
%     end
% end
% --- START MODIFICATION ---

% Check for file with or without .scad extension on the path
full_scad_file_name = which(scad_file_name);
if isempty(full_scad_file_name) % File not found as-is
    full_scad_file_name = which([scad_file_name,'.scad']);
end
if isempty(full_scad_file_name) % File not found, try uppercase extension
    full_scad_file_name = which([scad_file_name,'.SCAD']);
end

if not(isempty(full_scad_file_name))
    % % Update scad_file_name to its full path if found
    % scad_file_name = full_scad_path;
    
    % --- END MODIFICATION ---
has_stl=contains(stl_file_name,'.stl');
if not(has_stl)
    stl_file_name=[stl_file_name,'.stl'];
end
if isfile(full_scad_file_name)
    constructor.command=openscad;
    constructor.scad_file_name=scad_file_name;
    constructor.stl_file_name=stl_file_name;
    command=[constructor.command,' -o "', fullfile(stl_dir,stl_file_name),'" "', full_scad_file_name,'"'];
    for i = 1:2:nargin-2
        constructor.params(1+(i-1)/2)=string(varargin{i});
        constructor.expressions(1+(i-1)/2)=sym(varargin{i+1});
        command=[command,' -D "',char(constructor.params(1+(i-1)/2)),'=',num2str(getValue(constructor.expressions(1+(i-1)/2))),'"'];
    end
    if not(ispc)
        constructor.error=system([command,' 2> /dev/null']);
    else
        constructor.error=system([command]);
    end
    if not(constructor.error==0)
        Warning(['It seems that you can not execute program "openscad".',newline,...
            'Have you installed OpenScad and put the binary "opescad" containing directory in your system''s PATH environment variable?', newline,...
            'http://www.openscad.org/downloads.html']);
    end
else
    error(['File ', [scad_file_name], ' does not exists' ])
end
end