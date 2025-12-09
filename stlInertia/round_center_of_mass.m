
function [out_s,out_n,param_s,param_n]=round_center_of_mass(center_of_mass,center_of_mass_name)
% syms a b c ap bp cp real
param_s=sym([]);
param_n=[];

global round_center_of_mass_tol1 round_center_of_mass_tol2

norm_center_of_mass=norm(center_of_mass);

for i=1:3
    if norm_center_of_mass<round_center_of_mass_tol1
        out_s(i,1)=sym(0);
        out_n(i,1)=0;
    else
        if abs((center_of_mass(i,1))/norm_center_of_mass) < round_center_of_mass_tol2
            out_s(i,1)=sym(0);
            out_n(i,1)=0;
        else
            out_s(i,1)=sym(strcat(center_of_mass_name,int2str(i)),'real');
            out_n(i,1)=center_of_mass(i,1);
            param_s=[param_s;out_s(i,1)];
            param_n=[param_n;out_n(i,1)];
        end
    end
end
