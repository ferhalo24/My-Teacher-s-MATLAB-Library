function [mass_s,mass_n,param_s,param_n]=round_mass(mass,mass_name)

global round_mass_tol

if mass<round_mass_tol
 mass_s=sym(0);
 param_s=sym([]);
 mass_n=mass;
 param_n=[];
else
 mass_s=sym(mass_name,'real');
 param_s=mass_s;
 mass_n=mass;
 param_n=mass_n;
end


end


