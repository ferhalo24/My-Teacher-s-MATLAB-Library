function orientation_diagram_latex(file_name)
global Bases NamesBases
global Solids NamesSolids
global Frames FramesNames
% latex_code=sprintf('\\begin{eqnarray}\n');
latex_code='';
for i=1:length(Bases)
    if i==1
        prev_base_name='xyz';
    else
        prev_base_name=NamesBases(Bases(i).prev).Base_name;
    end
    base_name=NamesBases(i).Base_name;
    latex_code=[latex_code,sprintf('%s  ',prev_base_name)];
    if sym(Bases(i).rot_angle)==sym(0)
        latex_code=[latex_code,sprintf('&  \\equiv & %s   \\\\ \n',base_name)];
    else
        if isequal(Bases(i).rot_vect_comp,sym([1,0,0]'))
            latex_code=[latex_code,sprintf('&\\xrightarrow{( \\mathbf{e}_1^{ %s } , %s )} & %s \\\\ \n',prev_base_name,Bases(i).rot_angle,base_name)];
        end
        if isequal(Bases(i).rot_vect_comp,sym([0,1,0]'))
            latex_code=[latex_code,sprintf('&\\xrightarrow{( \\mathbf{e}_2^{ %s } , %s )} & %s \\\\ \n',prev_base_name,Bases(i).rot_angle,base_name)];
        end
        if isequal(Bases(i).rot_vect_comp,sym([0,0,1]'))
            latex_code=[latex_code,sprintf('&\\xrightarrow{( \\mathbf{e}_3^{ %s } , %s )} & %s \\\\ \n',prev_base_name,Bases(i).rot_angle,base_name)];
        end
    end
end

for i=1:length(Solids)
        latex_code=[latex_code,sprintf(' %s &  \\equiv & %s   \\\\ \n',Frames(FramesNames(Solids(i).Frame)).Base,NamesSolids(i).Solid_name)]; 
end

latex_code=[latex_code(1:end-4)];
% latex_code=[latex_code,sprintf('\\end{eqnarray}\n')];

latex_code=strrep(latex_code,'psi','\psi');
latex_code=strrep(latex_code,'theta','\theta');
latex_code=strrep(latex_code,'phi','varphi');
latex_code=strrep(latex_code,'varphi','\varphi');
latex_code=strrep(latex_code,'epsilon','\epsilon');
latex_code=strrep(latex_code,'delta','\delta');
latex_code=strrep(latex_code,'alpha','\alpha');
latex_code=strrep(latex_code,'beta','\beta');
latex_code=strrep(latex_code,'gamma','\gamma');

latex_code

fid=fopen(file_name,'w');
fprintf(fid,'%s',latex_code);
fclose(fid);