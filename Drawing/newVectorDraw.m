function draw_handle=newVectorDraw(Point_name,vector_z_name,vector_z_scale,colors)

global characteristic_size

global updateDraws_automatic

if nargin==1 
    error('Min number of arguments is 1');
elseif nargin==2
    colors=[[1,0,0,1];[1,0,0,1]];
    vector_z_scale=[-1,-1,1];
elseif nargin==3
    if length(vector_z_scale)==1
        vector_z_scale(3)=vector_z_scale(1);
        vector_z_scale(1)=-1;
        vector_z_scale(2)=-1;
    elseif length(vector_z_scale)==2
        vector_z_scale(3)=vector_z_scale(2);
        vector_z_scale(1)=-vector_z_scale(1);
        vector_z_scale(2)=-vector_z_scale(1);
    end
    colors=[[1,0,0,1];[1,0,0,1]];
elseif nargin==4
    if length(vector_z_scale)==1
        vector_z_scale(3)=vector_z_scale(1);
        vector_z_scale(1)=-1;
        vector_z_scale(2)=-1;
    elseif length(vector_z_scale)==2
        vector_z_scale(3)=vector_z_scale(2);
        vector_z_scale(2)=-vector_z_scale(1);
        vector_z_scale(1)=-vector_z_scale(1);
    end
    if size(colors,2)==3
        colors=[colors,ones(size(colors,1),1)];
    end
elseif nargin>4
    error('Min number of arguments is 1');
end
fv=arrow_patch(1,8);
draw_handle=newFVVarLengthDraw(Point_name,fv,vector_z_name,vector_z_scale,colors);

if updateDraws_automatic
    updateDraws;
end
end
