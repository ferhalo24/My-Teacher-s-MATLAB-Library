function position_diagram_latex(file_name)
global Points NamesPoints
global Bases NamesBases
global NamesSolids

% latex_code=sprintf('\\begin{eqnarray}\n');
latex_code='';

for i=1:length(Points)
    
    if Points(i).prev==0
        prev_point_name='O';
    else
        prev_point_name=NamesPoints(Points(i).prev).Point_name;
    end
    point_name=NamesPoints(i).Point_name;
    latex_code=[latex_code,sprintf('%s  ',prev_point_name)];
    if sym(Points(i).prev_new.Value)==sym([0,0,0]')
        latex_code=[latex_code,sprintf('  & \\equiv & %s  \\\\ \n',point_name)];
    else
    latex_code=[latex_code,sprintf('&\\xrightarrow{')];
    first_noncero_comp=true;
    for j=1:3
        aux_code='';
        if sym(Points(i).prev_new.Value(j))~=sym(0)
            aux_code=sprintf('%s',expr_latex(simplify(Points(i).prev_new.Value(j))));
            if length(children(Points(i).prev_new.Value(j)))>1 && length(children(-Points(i).prev_new.Value(j)))>1
                 aux_code=['(',aux_code,')'];
            end
            if Points(i).prev_new.Base==0
                aux_code=sprintf('%s \\mathbf{e}_{ %d }^{ %s }  ',aux_code,j,'xyz');
            else
                aux_code=sprintf('%s \\mathbf{e}_{ %d }^{ %s }  ',aux_code,j,NamesBases(Points(i).prev_new.Base).Base_name);
            end
            if not(first_noncero_comp) && aux_code(1)~='+' && aux_code(1)~='-'
                aux_code=['+',aux_code];
            end;
            latex_code=[latex_code,aux_code];
            first_noncero_comp=false;
        end;
    end
    latex_code=[latex_code,sprintf('} & %s \\\\ \n',point_name)];
    end
end
i=length(Points)
if Points(i).prev==0
    prev_point_name='O';
else
    prev_point_name=NamesPoints(Points(i).prev).Point_name;
end
latex_code=[latex_code(1:end-4)];
% latex_code=[latex_code,sprintf('\\end{eqnarray}\n')]

for i=1:length(NamesSolids)
    
    latex_code=strrep(latex_code,['_',NamesSolids(i).Solid_name,'1'],['_{',NamesSolids(i).Solid_name,'1}']);
    latex_code=strrep(latex_code,['_',NamesSolids(i).Solid_name,'2'],['_{',NamesSolids(i).Solid_name,'2}']);
    latex_code=strrep(latex_code,['_',NamesSolids(i).Solid_name,'3'],['_{',NamesSolids(i).Solid_name,'3}']);
    latex_code=strrep(latex_code,['_',NamesSolids(i).Solid_name],['_{',NamesSolids(i).Solid_name,'}']);
end;

latex_code=strrep(latex_code,'\psi','psi');
latex_code=strrep(latex_code,'\theta','theta');
latex_code=strrep(latex_code,'\phi','phi');
latex_code=strrep(latex_code,'\varphi','varphi');
latex_code=strrep(latex_code,'\epsilon','epsilon');
latex_code=strrep(latex_code,'\delta','delta');
latex_code=strrep(latex_code,'\alpha','alpha');
latex_code=strrep(latex_code,'\beta','beta');
latex_code=strrep(latex_code,'\gamma','gamma')

latex_code=strrep(latex_code,'psi','\psi');
latex_code=strrep(latex_code,'theta','\theta');
latex_code=strrep(latex_code,'phi','\phi');
latex_code=strrep(latex_code,'varphi','\varphi');
latex_code=strrep(latex_code,'epsilon','\epsilon');
latex_code=strrep(latex_code,'delta','\delta');
latex_code=strrep(latex_code,'alpha','\alpha');
latex_code=strrep(latex_code,'beta','\beta');
latex_code=strrep(latex_code,'gamma','\gamma')


fid=fopen(file_name,'w');


fprintf(fid,'%s',latex_code);
fclose(fid);