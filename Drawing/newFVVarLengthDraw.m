function draw_handle=newFVVarLengthDraw(Point_name,fvc,vector_z_name,vector_z_scale,color)
global Frames
global FramesNames
global Points
global PointsNames


global t
       
global q
global dq
global ddq
global param
global epsilon

global t_value

global q_value
global dq_value
global ddq_value
global param_value
global epsilon_value

global Draws

global optimize_matlabFunction

if not(isKey(PointsNames,Point_name))
 error('Parameter Point_name, must be a point name');
end

n_patchs=length(fvc);

if ischar(vector_z_name)
if ismember(vector_z_name,evalin('base','who'))
    vector_z=evalin('base',vector_z_name);
    if not(isa(vector_z,'Vector3D'))
        error('vector_z_name, ', vector_z_name,' must a variable of Vector3D type or a string with its name');
    end
end
elseif isa(vector_z_name,'Vector3D')
    vector_z=vector_z_name;
    vector_z_name=['vector_',num2str(length(Draws)+1)];
else
    error('vector_z_name, ', vector_z_name,' is not a Vector3D nor the name of a variable');
end

if nargin<5
    Default_Color=[1,1,0,1];
    color=Default_Color;
    if isequal(size(color),[1,4])
        for i=2:n_patchs
            color=[color;color];
        end
    end
    
    if isequal(size(vector_z_scale),[1,1]) && vector_z_scale>=0
        vector_z_scale=[-1,-1,vector_z_scale];
    elseif not(isequal(size(vector_z_scale),[1,3]))
      error('vector_z_scale is a vector of size [1,1] or [1,3]');  
    end
end

if nargin<4
vector_z_scale=[-1,-1,1];
end

if isequal(size(color),[1,3])
    color=[color,1];
end
if isequal(size(color),[1,4])
    for i=2:n_patchs
        color=[color;color];
    end
end

Base_name='xyz';


vector_z=vector_z.inBase(Base_name);

vector_z_function_name=strcat(vector_z_name,'_vector');

if exist(vector_z_function_name)~=2
    if not(isempty(epsilon))
       matlabFunction(vector_z.Value,'File',vector_z_function_name,'Vars',{q,dq,ddq,t,param,epsilon},'Optimize',optimize_matlabFunction);
    else
       matlabFunction(vector_z.Value,'File',vector_z_function_name,'Vars',{q,dq,ddq,t,param,sym('empty_epsilon','real')},'Optimize',optimize_matlabFunction);
    end
end

Frame_name=strcat(Point_name,Base_name);

if not(isKey(FramesNames,Frame_name))
    newFrame(Point_name,Base_name,Frame_name);
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
    OC=Pos('O',Point);
    OC=OC.inBase(Base_name);
    matlabFunction(sym(OC.Value),sym(BasMatr('xyz',OC.Base)'),'File',transform_function_name,'Vars',{q,dq,ddq,t,param},'Outputs',{'translation','rotation'},'Optimize',optimize_matlabFunction);
 else
    error('First Parameter is a Frame name');
 end
end
n_Draws=length(Draws);
n_Draws=n_Draws+1;
 
if n_Draws==1
    Draws=Draw3DClass(Frame_name,fvc,[],color,transform_function_name,vector_z_scale,vector_z_function_name);
else
    Draws(n_Draws)=Draw3DClass(Frame_name,fvc,[],color,transform_function_name,vector_z_scale,vector_z_function_name);
end
draw_handle=Draws(n_Draws);
