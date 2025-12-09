function setCamTarget(point_name)
% SETCAMTARGET Set the camera target point.
%   SETCAMTARGET(TARGETPOINT) sets the camera's target point to the
%   specified TARGETPOINT. TARGETPOINT should be already defined Point.
%
%   Example:
%       setCamTarget(point_name) % Sets the camera target to the origin.
%
%   See also RESETCAMVIEWANGLE, RESETCAMUP, RESETCAMPOS, RESETCAMTARGET,
%   RESETCAMPROJ, SETCAMVIEWANGLE, SETCAMUP,SETCAMPOS, SETCAMTARGET, SETCAMPROJ

global q t param
global q_value t_value param_value
global ax
global cam_target_use
global cam_pos_use
global cam_view_angle_use
global cam_view_angle
global cam_up_use
global cam_proj_use
global cam_proj_name

cam_target=Pos('O',point_name).inBase('xyz');
matlabFunction(cam_target.Value,'File','cam_target_','Vars',{q,t,param},'Optimize',true);
cam_target_use=true;

updateCam;

drawnow limitrate nocallbacks;
end