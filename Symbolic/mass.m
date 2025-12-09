function mass_out=mass(solid_name)
global Solids
global SolidsNames 

if not(isKey(SolidsNames,solid_name))
    error('Solid %s not defined', new_solid_name);
else
    mass_out=Solids(SolidsNames(solid_name)).mass;
end