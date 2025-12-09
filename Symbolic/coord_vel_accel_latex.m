function coord_vel_accel_latex(file_name,replace_vector,replace_with_vector)
global q dq ddq
latex_code=sprintf('\\mathbf{q}=%s \n \\dot{\\mathbf{q}}= %s \n \\ddot{\\mathbf{q}}=%s \n', latex(q), latex(dq), latex(ddq));
%latex(q), latex(dq), latex(ddq)

latex_code=strrep(latex_code,'\mathrm',' ');
latex_code=strrep(latex_code,'\varphi','phi');

latex_code=strrep(latex_code,'\psi','psi');
latex_code=strrep(latex_code,'\theta','theta');
latex_code=strrep(latex_code,'\phi','phi');
latex_code=strrep(latex_code,'\varphi','varphi');
latex_code=strrep(latex_code,'\epsilon','epsilon');
latex_code=strrep(latex_code,'\delta','delta');
latex_code=strrep(latex_code,'\alpha','alpha');
latex_code=strrep(latex_code,'\beta','beta');
latex_code=strrep(latex_code,'\gamma','gamma')

for i=1:length(q)
    latex_code=strrep(latex_code,char(ddq(i)),['\ddot{',char(q(i)),'}']);
end;
for i=1:length(q)
    latex_code=strrep(latex_code,char(dq(i)),['\dot{',char(q(i)),'}']);
end;




latex_code=strrep(latex_code,'psi','\psi');
latex_code=strrep(latex_code,'theta','\theta');
latex_code=strrep(latex_code,'phi','varphi');
latex_code=strrep(latex_code,'varphi','\varphi');
latex_code=strrep(latex_code,'epsilon','\epsilon');
latex_code=strrep(latex_code,'delta','\delta');
latex_code=strrep(latex_code,'alpha','\alpha');
latex_code=strrep(latex_code,'beta','\beta');
latex_code=strrep(latex_code,'gamma','\gamma')
latex_code=strrep(latex_code,'\left(','\left[');
latex_code=strrep(latex_code,'\right)','\right]');

if nargin==3
    for i=1:length(replace_vector)
        latex_code=strrep(latex_code,replace_vector(i),replace_with_vector(i));
    end
end

latex_code

fid=fopen(file_name,'w');
fprintf(fid,'%s',latex_code);
fclose(fid);