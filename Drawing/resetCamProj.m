function resetCamProj()
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

cam_proj_use=false;

camproj(ax,'orthographic');

drawnow limitrate nocallbacks;
end
