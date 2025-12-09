function [mass_s,first_moment_of_mass_s,inertia_tensor_s,mass_n,first_moment_of_mass_n,inertia_tensor_n,param_s,param_n]=round_inert_prop(fv,rho,solid_name)

param_s=sym([]);
param_n=[];

try
    [mass,center_of_mass,inertia_tensor]=inert_prop(fv,rho);
catch ME
    switch ME.identifier
        case 'StlInertia:Volume_is_zero'
            error('Frames Vertex structure volume of solid %s is <=0!.\n It makes no sense for a Frames Vertex structure defining a proper solid',solid_name);
            retrow(ME);
    end
end

[mass_s,mass_n,param_aux_s,param_aux_n]=round_mass(mass,strcat('m_',solid_name));
param_s=[param_s; param_aux_s];
param_n=[param_n; param_aux_n];

[center_of_mass_s,center_of_mass_n,param_aux_s,param_aux_n]=round_center_of_mass(center_of_mass,strcat('d_',solid_name));
first_moment_of_mass_s=mass_s*center_of_mass_s;
first_moment_of_mass_n=mass_n*center_of_mass_n;
param_s=[param_s; param_aux_s];
param_n=[param_n; param_aux_n];

[inertia_tensor_s,inertia_tensor_n,param_aux_s,param_aux_n]=round_inertia_tensor(inertia_tensor,strcat('i_',solid_name));
param_s=[param_s; param_aux_s];
param_n=[param_n; param_aux_n];

end