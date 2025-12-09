function lines=newLVDraw(Frame_name,lv,color,vector_z,vector_z_name)
global Frames
global FramesNames
global Points
global PointsNames

global t

global q
global dq
global ddq
global param

global t_value

global q_value
global dq_value
global ddq_value
global param_value

global Draws

global optimize_matlabFunction

if isequal(size(color),[1,3]) 
    color=[color,1];
end
if isequal(size(color),[1,4])
    for i=2:length(lv)
        color=[color;color];
    end
end
transform_function_name=strcat(Frame_name,'_transform');

if exist(transform_function_name)~=2
    if ischar(Frame_name) && isKey(FramesNames,Frame_name)
        Frame_number=FramesNames(Frame_name);
        if Frame_number==0
            Point=0;
            Base=0;
        else
            Point=Frames(Frame_number).Point;
            Base=Frames(Frame_number).Base;
        end
    elseif ischar(Frame_name) && isKey(PointsNames,Frame_name)
        Point=PointsNames(Frame_name);
        Base=0;  
    else
        error('First Parameter is a Frame name');
    end
    OC=Pos('O',Point);
    if not(isempty(OC.Base) || OC.Base==0)
        
        OC.Value=BasMatr('xyz',OC.Base)*OC.Value;
        OC.Base=0;
    end
    
    if nargin==5
        matlabFunction(vector_z,'File',vector_z_name,'Vars',{q,dq,ddq,t,param},'Optimize',optimize_matlabFunction);
    end
    matlabFunction(sym(OC.Value),sym(BasMatr('xyz',Base)'),'File',transform_function_name,'Vars',{q,dq,ddq,t,param},'Outputs',{'translation','rotation'},'Optimize',optimize_matlabFunction);
end
n_Draws=length(Draws);
n_Draws=n_Draws+1;

if n_Draws==1
    Draws=Draw3DClass(Frame_name,[],lv,color,transform_function_name);
else
    Draws(n_Draws)=Draw3DClass(Frame_name,[],lv,color,transform_function_name);
end
lines=Draws(n_Draws);
 