function updateDraws()
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

for i=1:length(Draws)
%     update(Draws(i).Draw3Dobject);
    update(Draws(i));
end
updateCam();
drawnow limitrate nocallbacks;