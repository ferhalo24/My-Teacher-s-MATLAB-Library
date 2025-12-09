function handle=newRefLineDraw(Ox_name,vector,opt,head_size,n_lines)
%opt 1 -1 or 0

global ax

if nargin<5
    n_lines=8;
end
if nargin<4
    head_size=0.1;
end
if nargin<3
    opt=0;
end

if opt==1
    OOx=Pos('O',Ox_name);
    OOxy=Pos('O',Ox_name)+vector;
    O=getValue(OOx.inBase('xyz').Value);
    P=getValue(OOxy.inBase('xyz').Value);    
end
if opt==-1
    OOx=Pos('O',Ox_name);
    OOxy=Pos('O',Ox_name)-vector;
    O=getValue(OOx.inBase('xyz').Value);
    P=getValue(OOxy.inBase('xyz').Value); 
end
if opt==0
    OOx=Pos('O',Ox_name)+vector;
    OOxy=Pos('O',Ox_name)-vector;
    O=getValue(OOx.inBase('xyz').Value);
    P=getValue(OOxy.inBase('xyz').Value);
end

OPi=zeros(n_lines+1,3);
for i=1:n_lines+1
    OPi(i,:)=(O+(i-1)/n_lines*(P-O))';
end
handle=line(ax, OPi(:,1), OPi(:,2), OPi(:,3), 'Color', [0,0,0], 'LineStyle', ':');
end