function Export_Perturbed_Dynamic_State_Problem(dyn_equations_type)

%% Export Perturbed Dynamic State problem "a la" Newton-Euler
if nargin==0 || strcmp(dyn_equations_type,'Newton-Euler')
    Export_Perturbed_Dynamic_State_Problem_NE()
end

%% Export Perturbed Dynamic State problem "a la" Virtual Power or Lagrange
if nargin==0 || strcmp(dyn_equations_type,'Virtual_Power') || strcmp(dyn_equations_type,'Lagrange')
    Export_Perturbed_Dynamic_State_Problem_VP()
end
