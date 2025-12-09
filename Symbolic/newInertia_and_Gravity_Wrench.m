function Wrench=newInertia_and_Gravity_Wrench(action_solid_name,wrt_point_name)

global Solids SolidsNames
global Frames  FramesNames

if nargin==1
    wrt_point_name=Frames(FramesNames(action_solid_name)).Point;
end

[FIG_Sol,MIG_Sol_wrt_point,wrt_point_name]=newInertia_and_Gravity_Force_Moment(action_solid_name, wrt_point_name);

Wrench=Vector6D(FIG_Sol,MIG_Sol_wrt_point,wrt_point_name);

if Solids(SolidsNames(action_solid_name)).isExt==false
    if not(isfield(Solids,'IActions'))
        n_IActions=0;
    else
    n_IActions=length(Solids(SolidsNames(action_solid_name)).IActions);
    end
    if n_IActions==0
        Solids(SolidsNames(action_solid_name)).IActions=Wrench;
    else
        Solids(SolidsNames(action_solid_name)).IActions(n_IActions+1)=Wrench;
    end
end
end