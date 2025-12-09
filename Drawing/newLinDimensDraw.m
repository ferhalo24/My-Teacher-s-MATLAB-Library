function newLinDimensDraw(Ox_name,Oxy_name,head_size,n_lines)
OOx=PosVect('O',Ox_name)
OOxy=PosVect('O',Oxy_name)
O=Expr_value(OOx.inBase('xyz').Value);
P=Expr_value(OOxy.inBase('xyz').Value);
if nargin<4
    n_lines=8;
end
if nargin<3
    head_size=0.1;
end
for i=1:n_lines+1
    OPi(i,:)=(O+(i-1)/n_lines*(P-O))';
end
line(OPi(:,1),OPi(:,2),OPi(:,3),'Color',[0,0,0]);
N=8; head_size=0.1;
[X,Y,Z] = cylinder2P([1/4*head_size,0],N,OPi(n_lines+1,:)+head_size*(OPi(n_lines,:)-OPi(n_lines+1,:))/norm(OPi(n_lines,:)-OPi(n_lines+1,:)),OPi(n_lines+1,:));
arrow_head_fv = surf2patch(X,Y,Z,3);
newFVDraw('abs',arrow_head_fv,[0,0,0]);
end