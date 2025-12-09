%% Perturbed Dynamic State Problem Solution
if strcmp(dyn_equations_type,'Newton-Euler')
    %% Perturbed Dynamic State Problem Newton-Euler
    perturbed_dynamic_state_problem_NE;
    
elseif strcmp(dyn_equations_type,'Virtual_Power') || strcmp(dyn_equations_type,'Lagrange')
    %% Perturbed Dynamic State Problem Virtual Power or Lagrange
    perturbed_dynamic_state_problem_VP;
    
end

updateDraws;