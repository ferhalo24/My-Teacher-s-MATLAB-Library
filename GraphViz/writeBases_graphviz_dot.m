function writeBases_graphviz_dot(dot_file_name)
global Bases NamesBases
if nargin==0
    dot_file_name='base_diagram.dot';
end
fid = fopen(dot_file_name,'w');

fprintf(fid,"/*---------begin  Graphviz dot output---------*/\n");
fprintf(fid,"digraph G { \n node [shape=circle]\n");


for i=1:length(Bases)
    if (i == 1)
        fprintf(fid,"xyz");
    else

        s1=NamesBases(Bases(i).prev).Base_name;
        fprintf(fid, s1) ;
    end
    fprintf(fid,[' -> "', NamesBases(i).Base_name, '"']);
    fprintf(fid,' [label=\"[' );
    % Bases[i]->get_Rotation_Tupla ( )(0,0) << ";" <<
    % Bases[i]->get_Rotation_Tupla ( )(1,0) << ";" <<
    % Bases[i]->get_Rotation_Tupla ( )(2,0) << ";" <<
    % Bases[i]->get_Rotation_Angle ( ) << "]" <<
    fprintf(fid,'"]\');

end
fprintf(fid,"}\n");
fprintf(fid,"/*---------end  Graphviz dot output---------*/\n");
fclose(fid);
end
