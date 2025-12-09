function out=Twist(wrt_frame_name,solid_name)
global Points
global PointsNames
global Solids
global SolidsNames
global InertialFrame_name
if nargin==1
    solid_name=wrt_frame_name;
out=Vector6D(Omega(InertialFrame_name,solid_name),timederivative(Pos(InertialFrame_name,solid_name),InertialFrame_name),solid_name);
elseif nargin==2
out=Vector6D(Omega(wrt_frame_name,solid_name),timederivative(Pos(wrt_frame_name,solid_name),wrt_frame_name),solid_name);
end
end
