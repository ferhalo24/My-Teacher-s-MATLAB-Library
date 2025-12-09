function newFrame(point_name_or_new_frame_name,base_name_or_point_name,new_frame_name_or_base_name)
global Bases
global BasesNames %We put frame names in BasesNames to get Frame Base
global Points
global PointsNames
global Frames
global FramesNames NamesFrames

if isKey(PointsNames,point_name_or_new_frame_name)
point_name=point_name_or_new_frame_name;
base_name=base_name_or_point_name;
new_frame_name=new_frame_name_or_base_name;
else
new_frame_name=point_name_or_new_frame_name;
point_name=base_name_or_point_name;
base_name=new_frame_name_or_base_name;  
end

if not(isKey(PointsNames,point_name))
    error('Point %s not defined',point_name);
elseif not(isKey(BasesNames,base_name)) 
    error('Base %s not defined',base_name);
elseif isKey(FramesNames,new_frame_name)
    error('Frame %s already defined', new_frame_name);
else
    n_Frames=length(Frames)+1;
    Frames(n_Frames).Point=point_name;
    Frames(n_Frames).Base=base_name;
    BasesNames(new_frame_name)=BasesNames(base_name);
    PointsNames(new_frame_name)=PointsNames(point_name);
    FramesNames(new_frame_name)=n_Frames;
    NamesFrames(n_Frames).Frame_name=new_frame_name;
end
