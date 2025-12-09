function updateCam()
global Draws
global q_value t_value param_value
global ax
global cam_target_use
global cam_pos_use
global cam_view_angle_use
global cam_view_angle
global cam_up_use
global cam_proj_use
global cam_proj_name

if cam_target_use
    camtarget(ax,cam_target_(q_value,t_value,param_value));
end
if cam_pos_use
    campos(ax,cam_pos_(q_value,t_value,param_value))
end
if cam_up_use
    camup(ax,cam_up_(q_value,t_value,param_value))
end
if cam_view_angle_use==true
    camva(ax,cam_view_angle);
end
if cam_proj_use==true
    camproj(ax,cam_proj_name);
end

%drawnow limitrate nocallbacks;