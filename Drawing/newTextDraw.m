function handle=newTextDraw(point_name,latex_str,disp_pos,size)
global ax

aux_pos=Pos('O',point_name);
if nargin>=3
   aux_pos=aux_pos+disp_pos;
end
if nargin<4
    size=0.033;
end

aux_pos=getValue(aux_pos,'xyz');
handle=text(ax,aux_pos(1,1),aux_pos(2,1),aux_pos(3,1),latex_str,'Interpreter','latex');
set(handle,'FontUnits','normalized')   
set(handle,'FontSize',size)
