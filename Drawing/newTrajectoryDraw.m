function line_handle=newTrajectoryDraw(Frame_name,point_name,extended_state_series,color)

%global Graphical_Output
global optimize_matlabFunction
global t q dq ddq epsilon lambda lambda_aux param
global Frames  FramesNames
global Points PointsNames

if ischar(Frame_name) && isKey(FramesNames,Frame_name)
    Frame_number=FramesNames(Frame_name);
    if Frame_number==0
        origin_point_name='O';
        frame_base_name='xyz';
    else
        origin_point_name=Frames(Frame_number).Point;
        frame_base_name=Frames(Frame_number).Base;
    end
elseif ischar(Frame_name) && isKey(PointsNames,Frame_name)
    origin_point_name=NamesPoints(PointsNames(Frame_name));
    frame_base_name='xyz';
else
    error('First Parameter is a Frame name');
end

func_name=[origin_point_name,point_name,'_traj'];
OC__frame_base_name=Pos(origin_point_name,point_name);
OC__frame_base_name=OC__frame_base_name.inBase(frame_base_name);
matlabFunction(OC__frame_base_name.Value','file',func_name,'Vars',{[t,q',dq',ddq',epsilon',lambda',lambda_aux',param']},'Optimize',optimize_matlabFunction);
fhandle = str2func(func_name);
for k=1:size(extended_state_series,1)
    OC__frame_base_name_series(k,:)=fhandle(extended_state_series(k,:));
end
%figure(Graphical_Output);
lv(1).vertices=OC__frame_base_name_series;
if nargin==4
    line_handle=newLVDraw(Frame_name,lv,color);
    %line(OC__xyz_series(:,1),OC__xyz_series(:,2),OC__xyz_series(:,3),'Color',color);
elseif nargin==3
    color=[1,1,1,1];
    line_handle=newLVDraw(Frame_name,lv,color)
    %line(OC__xyz_series(:,1),OC__xyz_series(:,2),OC__xyz_series(:,3),'Color','blue');
else
    error('wrong number of parameters');
end
