function handle=newLinDimenDraw(Ox_name,Oxy_name,head_size,n_lines)
global characteristic_size
global ax

OOx=Pos('O',Ox_name);
OOxy=Pos('O',Oxy_name);
O=getValue(OOx.inBase('xyz').Value);
P=getValue(OOxy.inBase('xyz').Value);
if nargin<4
    n_lines=8;
end
if nargin<3
    head_size=characteristic_size/10;
end
OPi=zeros(n_lines+1,3);
for i=1:n_lines+1
    OPi(i,:)=(O+(i-1)/n_lines*(P-O))';
end
handle(1)=line(ax,OPi(:,1),OPi(:,2),OPi(:,3),'Color',[0,0,0]);
N=8;
[X,Y,Z] = cylinder2P([1/4*head_size,0],N,OPi(n_lines+1,:)+head_size*(OPi(n_lines,:)-OPi(n_lines+1,:))/norm(OPi(n_lines,:)-OPi(n_lines+1,:)),OPi(n_lines+1,:));
arrow_head_fv = surf2patch(X,Y,Z,3);
%handle(2)=newFVDraw('abs',arrow_head_fv,[0,0,0]);
% arrow_head_fv = surf2patch(X,Y,Z,3);
handle(2)=patch(ax,arrow_head_fv,'FaceColor',[0,0,0]);
end