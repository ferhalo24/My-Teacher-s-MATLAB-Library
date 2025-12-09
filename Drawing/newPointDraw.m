function draw_handle=newPointDraw(Point_Name_or_Frame_name,drawing_size,color)

global Frames
global FramesNames
    
global t
       
global q
global dq
global ddq
global param

global t_value

global q_value
global dq_value
global ddq_value
global param_value

global Draws

global updateDraws_automatic

global characteristic_size

if nargin==1
    drawing_size=1;
    color=[0.5,0.5,0.5,1];
elseif nargin==2
    color=[0.5,0.5,0.5,1];
elseif nargin>3
    error('newFrameDraw max number of parameters is 3');
end

fv=sphere_patch(characteristic_size);
draw_handle=newFVDraw(Point_Name_or_Frame_name,fv,color,[drawing_size,drawing_size,drawing_size]/40);


if updateDraws_automatic
    updateDraws;
end
end
