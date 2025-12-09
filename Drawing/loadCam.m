function loadCam(arg1,arg2)
global ax
if nargin==2
    filename=arg2;
else
    filename=arg1;
end

try
    load(filename);
    camproj(ax,cam.proj);
    camtarget(ax,cam.tarjet);
    campos(ax,cam.pos);
    camva(ax,cam.va);
    camup(ax,cam.up);
    xlim(ax,cam.Xlim);
    xlim(ax,cam.Ylim);
    xlim(ax,cam.Zlim);
catch
    warning('The file %s, does not exists. Use save_cam(file_name) first to create a cam file\n', filename);
end

end