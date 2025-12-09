function saveCam(arg1,arg2)
global ax
if nargin==2
    filename=arg2;
else
    filename=arg1;
end

cam.proj=camproj(ax);
cam.tarjet=camtarget(ax);
cam.pos=campos(ax);
cam.va=camva(ax);
cam.up=camup(ax);
cam.Xlim=xlim(ax);
cam.Ylim=ylim(ax);
cam.Zlim=zlim(ax);
save(filename,'cam');
end