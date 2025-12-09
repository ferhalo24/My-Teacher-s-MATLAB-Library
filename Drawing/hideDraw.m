function hideDraw(obj)
global Draws
if not(isa(obj,'Draw3DClass'))
   obj=Draws(obj);
end

n_patchs=length(obj.patchs);
for k=1:n_patchs
set(obj.patchs(k),'visible','off');
end
end
