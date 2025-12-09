function recolorDraws(obj,colors)
global Draws
if not(isa(obj,'Draw3DClass'))
   obj=Draws(obj);
end

if size(colors(1,:),2)==3
            colors=[colors,ones(size(colors,1),1)];
end

n_patchs=length(obj.patchs);
one_color=not(size(colors,1)==n_patchs);
for k=1:n_patchs
    if one_color
     obj.colors(k,1:size(colors,2))=colors(1,:);
    else
     obj.colors(k,:)=colors(k,:);
    end
end
obj.update;
end