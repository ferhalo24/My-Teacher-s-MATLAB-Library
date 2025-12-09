function setDrawCharacteristicSize(size,scene_length)
global ax
global characteristic_size
global characteristic_scene_length
global ax_Xlimit
global ax_Ylimit
global ax_Zlimit

characteristic_size=size;
% xlim(ax,characteristic_size*[-inf,+inf]);
% ylim(ax,characteristic_size*[-inf,+inf]);
% zlim(ax,characteristic_size*[-inf,+inf]);

xlim(ax,characteristic_size*ax_Xlimit);
ylim(ax,characteristic_size*ax_Ylimit);
zlim(ax,characteristic_size*ax_Zlimit);
 
if nargin==2
    characteristic_scene_length=scene_length;
end

camva(ax,atan(characteristic_scene_length/norm(camtarget(ax)-campos(ax)))*180/pi);

setAxes3DPanAndZoomStyle(zoom(ax),ax,'camera');
end