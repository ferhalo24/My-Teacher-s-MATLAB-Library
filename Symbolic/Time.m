function out=Time(t_in);
global t t_value;
if nargin==1
    t_value=t_in;
    %warning('lib_3D_MEC global time variable has been set');
end
out=t_value;