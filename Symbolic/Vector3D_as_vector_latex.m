function Vector3D_as_vector_latex(expr,file_name,replace_vector,replace_with_vector)
global q dq ddq
global NamesBases
global Solids NamesSolids
base_name=[];
if isa(expr,'Vector3D')
    if isequal(expr.Base,0) || isempty(expr.Base)
        base_name='xyz'
    else
        base_name=NamesBases(expr.Base).Base_name;
    end
    expr=expr.Value;
end
syms eeexxx eeeyyy eeezzz
ebase=[eeexxx;
    eeeyyy;
    eeezzz];

latex_code=[];
for i=1:3
    if expr(i,1)~=0
      latex_code=[latex_code,sprintf('%s', [latex(expr(i,1)*ebase(i)),newline,'+\\'])];
    end
end

if isempty(latex_code)
    latex_code=[latex_code,'\mathbf{0}'];
else
    latex_code=eraseBetween(latex_code,length(latex_code)-2,length(latex_code));
    latex_code=['\begin{matrix*}[l]',latex_code,'\end{matrix*}'];
end

latex_code=strrep(latex_code,'eeexxx',['\mathbf{e}^{',base_name,'}_1']);
latex_code=strrep(latex_code,'eeeyyy',['\mathbf{e}^{',base_name,'}_2']);
latex_code=strrep(latex_code,'eeezzz',['\mathbf{e}^{',base_name,'}_3']);
latex_code=strrep(latex_code,'\mathrm','');
latex_code=strrep(latex_code,'\varphi','phi');
latex_code=strrep(latex_code,'\alpha','alpha');

for i=1:length(q)
    latex_code=strrep(latex_code,char(ddq(i)),['\ddot{',char(q(i)),'}']);
end
for i=1:length(q)
    latex_code=strrep(latex_code,char(dq(i)),['\dot{',char(q(i)),'}']);
end

latex_code=strrep(latex_code,char('ddpsi'),['\ddot{',char('psi'),'}']);
latex_code=strrep(latex_code,char('ddtheta'),['\ddot{',char('theta'),'}']);
latex_code=strrep(latex_code,char('ddphi'),['\ddot{',char('phi'),'}']);
latex_code=strrep(latex_code,char('ddalpha'),['\ddot{',char('alpha'),'}']);
latex_code=strrep(latex_code,char('dddelta'),['\ddot{',char('delta'),'}']);
latex_code=strrep(latex_code,char('ddepsilon'),['\ddot{',char('epsilon'),'}']);

latex_code=strrep(latex_code,char('dpsi'),['\dot{',char('psi'),'}']);
latex_code=strrep(latex_code,char('dtheta'),['\dot{',char('theta'),'}']);
latex_code=strrep(latex_code,char('dphi'),['\dot{',char('phi'),'}']);
latex_code=strrep(latex_code,char('dalpha'),['\dot{',char('alpha'),'}']);
latex_code=strrep(latex_code,char('ddelta'),['\dot{',char('delta'),'}']);
latex_code=strrep(latex_code,char('depsilon'),['\dot{',char('epsilon'),'}']);

latex_code=strrep(latex_code,'psi','\psi');
latex_code=strrep(latex_code,'theta','\theta');
latex_code=strrep(latex_code,'phi','varphi');
latex_code=strrep(latex_code,'varphi','\varphi');
latex_code=strrep(latex_code,'epsilon','\epsilon');
latex_code=strrep(latex_code,'delta','\delta');
latex_code=strrep(latex_code,'alpha','\alpha');
% latex_code=strrep(latex_code,'\left(','\left[');
% latex_code=strrep(latex_code,'\right)','\right]');

for i=1:length(Solids)
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'}}'],['^{',NamesSolids(i).Solid_name,'}']);
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'1}}'],['^{',NamesSolids(i).Solid_name,'}_{1}']);
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'2}}'],['^{',NamesSolids(i).Solid_name,'}_{2}']);
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'3}}'],['^{',NamesSolids(i).Solid_name,'}_{3}']);
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'11}}'],['^{',NamesSolids(i).Solid_name,'}_{11}']);
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'22}}'],['^{',NamesSolids(i).Solid_name,'}_{22}']);
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'33}}'],['^{',NamesSolids(i).Solid_name,'}_{33}']);
    
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'12}}'],['^{',NamesSolids(i).Solid_name,'}_{12}']);
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'13}}'],['^{',NamesSolids(i).Solid_name,'}_{13}']);
    latex_code=strrep(latex_code,['_{{',NamesSolids(i).Solid_name,'23}}'],['^{',NamesSolids(i).Solid_name,'}_{23}']);
end

if nargin==4
    for i=1:length(replace_vector)
        latex_code=strrep(latex_code,replace_vector(i),replace_with_vector(i));
    end
end

latex_code
fid=fopen(file_name,'w');
fprintf(fid,'%s',latex_code);
fclose(fid);