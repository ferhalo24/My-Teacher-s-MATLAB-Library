function resetPointerRotationCenter()
% RESETPOINTERROTATIONCENTER Resets the pointer rotation center and updates the axes limits.
% This function sets the x, y, and z limits of the global axes and updates the drawing.
%
% Usage:
%   resetPointerRotationCenter()

global ax
global ax_Xlimit
global ax_Ylimit
global ax_Zlimit
global cam_target_use
global cam_pos_use
global cam_view_angle_use
global cam_view_angle
global cam_up_use
global cam_proj_use
global cam_proj_name


xlim(ax_Xlimit);
ylim(ax_Ylimit);
zlim(ax_Zlimit);

updateDraws;

drawnow limitrate nocallbacks;