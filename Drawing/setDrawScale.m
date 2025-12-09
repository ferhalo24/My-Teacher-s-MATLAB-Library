function setDrawScale(obj,vector_z_scale)
global Draws
if not(isa(obj,'Draw3DClass'))
    obj=Draws(obj);
end

n_patchs=length(obj.patchs);
if size(vector_z_scale,1)==1
    vector_z_scales=zeros(n_patchs,size(vector_z_scale,2));
    for i=1:n_patchs
        vector_z_scales(i,:)=vector_z_scale;
    end
else
    vector_z_scales=vector_z_scale;
end

if isempty(obj.vector_z_name)
    for k=1:n_patchs
        if size(vector_z_scales,2)==1
            obj.vector_z_scale(k,:)=vector_z_scales(k)*[1,1,1];
        end
    end
else
    for k=1:n_patchs
        if size(vector_z_scales,2)==1
            obj.vector_z_scale(k,:)=[-1,-1,vector_z_scales(k)];
        elseif size(vector_z_scales,2)==2
            obj.vector_z_scale(k,:)=[-vector_z_scales(k,1),-vector_z_scales(k,1),vector_z_scales(k,2)];
        elseif size(vector_z_scales,2)==3
            obj.vector_z_scale(k,:)=vector_z_scales(k,:);
        end
    end
end
obj.update;
end