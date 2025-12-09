function resetCamViewAngle()
%   This function sets the camera view angle to 60 degrees and updates the
%   camera settings accordingly.
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

cam_view_angle_use=false;
cam_view_angle=60;

camva(ax,'manual');

drawnow limitrate nocallbacks;
end
