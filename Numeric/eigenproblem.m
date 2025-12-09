%% Eigenvalue and Eigenvector Problem Solution
if (strcmp(dyn_equations_type,'Newton-Euler')) 
    %% Eigenvalue and Eigenvector Problem Solution for Newton-Euler
    Warning('Eigenproblem not defined for Newton-Euler formalism');
    
elseif (strcmp(dyn_equations_type,'Virtual_Power') || strcmp(dyn_equations_type,'Lagrange')) 
    %% Eigenvalue and Eigenvector Problem  Solution Udwadia and Kabala style
    %eigenproblem_UK;
    eigenproblem_VP_dz();
end