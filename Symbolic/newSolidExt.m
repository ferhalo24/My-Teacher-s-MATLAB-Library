function Solid=newSolidExt(new_solid_name,frame_name,stl_file_name)

global Bases
global BasesNames %We put frame names in BasesNames to get Frame Base
global Points
global PointsNames
global Frames
global FramesNames
global Solids n_Solids
global SolidsNames NamesSolids

global param
global param_value

if not(isKey(FramesNames,frame_name))
    error('Frame %s not defined',frame_name);
elseif isKey(SolidsNames,new_solid_name)
    error('Solid %s already defined', new_solid_name);
else
    if FramesNames(frame_name)==0
        base_name='xyz';
        point_name='O';
    else
        base_name=Frames(FramesNames(frame_name)).Base;
        point_name= Frames(FramesNames(frame_name)).Point;
    end
    
    BasesNames(new_solid_name)=BasesNames(base_name);
    
    PointsNames(new_solid_name)=PointsNames(point_name);
    FramesNames(new_solid_name)=FramesNames(frame_name);

    n_Solids=length(Solids)+1;
    Solids(n_Solids).Frame = frame_name;
    stl_constructor=[];
    if nargin==3
        if ischar(stl_file_name)
            stl_file_name=stl_file_name;
            stl_constructor=[];
        else
            stl_constructor=stl_file_name;
            stl_file_name=stl_file_name.stl_file_name;
        end
        fv = stlRead(stl_file_name);
        Solids(n_Solids).fv = fv;
    end




    SolidsNames(new_solid_name)=n_Solids;

    Solids(n_Solids).isExt=true;
    Solids(n_Solids).stl_constructor=stl_constructor;
    Solid=Solids(n_Solids);
    NamesSolids(n_Solids).Solid_name=new_solid_name;
    BasesNames(new_solid_name)=BasesNames(base_name);
    PointsNames(new_solid_name)=PointsNames(point_name);
    FramesNames(new_solid_name)=FramesNames(frame_name);
       
end
