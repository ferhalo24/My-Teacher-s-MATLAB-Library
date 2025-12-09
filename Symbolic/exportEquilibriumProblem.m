function Export_Equilibrium_Problem(dyn_equations_type)

if nargin==0 || strcmp(dyn_equations_type,'Newton-Euler') || strcmp(dyn_equations_type,'All')
    %% Export Equilibrium problem "a la" Newton-Euler
    Export_Equilibrium_Problem_NE;
end

if nargin==0 || strcmp(dyn_equations_type,'Virtual_Power') || strcmp(dyn_equations_type,'Lagrange') || strcmp(dyn_equations_type,'All')
    %% Export Equilibrium problem "a la" Virtual Power or Lagrange
    Export_Equilibrium_Problem_VP;
end