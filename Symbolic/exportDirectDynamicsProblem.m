function Export_Direct_Dynamics_Problem(dyn_equations_type)

%% Export Direct Dynamics Problem
if nargin==0 || strcmp(dyn_equations_type,'Newton-Euler') || strcmp(dyn_equations_type,'All')
    %% Export Direct Dynamics Problem Newton-Euler
    Export_Direct_Dynamics_Problem_NE()
end

if nargin==0 || strcmp(dyn_equations_type,'Virtual_Power') || strcmp(dyn_equations_type,'Lagrange')
    %% Export Direct Dynamics Problem "a la" Virtual Power or Lagrange
    Export_Direct_Dynamics_Problem_VP()
end