function draw_handle=newFrameDraw(Frame_name,drawing_size,color)

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

global characteristic_size

global updateDraws_automatic

if nargin==1
    drawing_size=1;
    color=[[1,0,0,1];[0,1,0,1];[0,0,1,1];[0.5,0.5,0.5,1];[1,1,1,1];[1,1,1,1];[1,1,1,1]];
elseif nargin==2
    color=[[1,0,0,1];[0,1,0,1];[0,0,1,1];[0.5,0.5,0.5,1];[1,1,1,1];[1,1,1,1];[1,1,1,1]];
elseif nargin==3
    if size(color,1)==1
        if size(color,2)==3, color=[color,1]; end
        color=[[1,0,0,1];[0,1,0,1];[0,0,1,1];color;[1,1,1,1];[1,1,1,1];[1,1,1,1]];
    elseif size(color,1)==2
        if size(color,2)==3, color=[color,ones(size(color,1),1)]; end
        color=[[1,0,0,1];[0,1,0,1];[0,0,1,1];color(1,:);color(2,:);color(2,:);color(2,:)];
    else
        error('A maximum of two colors can be specified');
    end
elseif nargin==4
    error('newFrameDraw max number of parameters is 3');
end

fv=frame_patch(characteristic_size);

draw_handle=newFVDraw(Frame_name,fv,color,[drawing_size,drawing_size,drawing_size]);

if updateDraws_automatic
    updateDraws;
end
end
