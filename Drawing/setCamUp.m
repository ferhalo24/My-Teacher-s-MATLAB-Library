function setCamUp(up_vector)
% SETCAMUP Set the camera up vector.
%   SETCAMUP(UP_VECTOR) sets the camera's up direction to the specified
%   UPVECTOR. UP_VECTOR should be a Vector3D representing the
%   direction in which the camera should point upwards.
%
%   Example:
%       e_3__Bphi=Vector3D([0,0,1],'Bphi')
%       setCamUp(e_3__Bphi) % Sets the up direction to the positive Y-axis.
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

cam_up=up_vector.inBase('xyz');
matlabFunction(cam_up.Value,'File','cam_up_','Vars',{q,t,param},'Optimize',true);
cam_up_use=true;

updateCam;

drawnow limitrate nocallbacks;
end