%% Dynamic Equilibrium Problem Solution
if strcmp(dyn_equations_type,'Newton-Euler')
    %% Equilibrium Problem Newton-Euler
    dynamic_equilibrium_problem_NE;
    
elseif strcmp(dyn_equations_type,'Virtual_Power') || strcmp(dyn_equations_type,'Lagrange')
    %% Equilibrium Problem Virtual Power or Lagrange
    dynamic_equilibrium_problem_VP;
    
end
