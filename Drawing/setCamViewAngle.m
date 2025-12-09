function setCamViewAngle(view_angle)
% SETCAMVIEWANGLE Set the camera view angle.
%   SETCAMVIEWANGLE(ANGLE) sets the camera's view angle to the specified
%   ANGLE in degrees. The angle determines the extent of the observable
%   world seen from the camera's perspective.
%
%   Example:
%       setCamViewAngle(45) % Sets the camera view angle to 45 degrees.
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

cam_view_angle_use=true;
cam_view_angle=view_angle;

updateCam;

drawnow limitrate nocallbacks;
end