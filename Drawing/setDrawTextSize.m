function setDrawTextSize(size)
global ax
htxt = findobj(ax,'Type','text');
for i=1:length(htxt)
set(htxt(i),'FontUnits','normalized')   
set(htxt(i),'FontSize',size)
end