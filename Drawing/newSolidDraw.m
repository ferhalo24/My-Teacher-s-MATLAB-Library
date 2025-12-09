function draw_handle=newSolidDraw(solid_name,color)

global Solids
global SolidsNames

global updateDraws_automatic


frame_name=Solids(SolidsNames(solid_name)).Frame;
fv=Solids(SolidsNames(solid_name)).fv;
if nargin==1
    color=[1,1,0,1];
end
draw_handle=newFVDraw(frame_name,fv,color);
Solids(SolidsNames(solid_name)).draw_handle=draw_handle;
if updateDraws_automatic
    updateDraws;
end
end