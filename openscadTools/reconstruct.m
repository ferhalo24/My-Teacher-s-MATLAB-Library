function reconstruct(constructor)

global stl_dir

command=[constructor.command,' -o "', fullfile(stl_dir,constructor.stl_file_name),'" "', which(constructor.scad_file_name),'"'];
for i = 1:length(constructor.params)
    command=[command,' -D "',char(constructor.params(i)),'=',num2str(getValue(constructor.expressions(i))),'"'];
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
end