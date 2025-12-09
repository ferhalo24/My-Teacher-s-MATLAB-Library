function setDirectDynamicsSolver(direct_dynamics_solver_name)
global dyn_equations_type

if strcmp(direct_dynamics_solver_name,'Newton-Euler')
    dyn_equations_type='Newton-Euler';
    path=fileparts(mfilename('fullpath') );
    origin=fullfile(path,'solveDirectDynamicsProblemNE.m');
    destination=fullfile(path,'solveDirectDynamicsProblem.m');
    copyfile (origin, destination);
    rehash;
elseif strcmp(direct_dynamics_solver_name,'Virtual_Power') || strcmp(direct_dynamics_solver_name,'Lagrange')
    dyn_equations_type='Virtual_Power';
    path=fileparts(mfilename('fullpath') );
    origin=fullfile(path,'solveDirectDynamicsProblemVP.m');
    destination=fullfile(path,'solveDirectDynamicsProblem.m');
    copyfile (origin, destination);
    rehash;
elseif strcmp(direct_dynamics_solver_name,'Virtual_Power_indep')
    dyn_equations_type='Virtual_Power';
    path=fileparts(mfilename('fullpath') );
    origin=fullfile(path,'solveDirectDynamicsProblemVP_indep.m');
    destination=fullfile(path,'solveDirectDynamicsProblem.m');
    copyfile (origin, destination);
    rehash;
elseif strcmp(direct_dynamics_solver_name,'Virtual_Power_UK')
    dyn_equations_type='Virtual_Power';
    path=fileparts(mfilename('fullpath') );
    origin=fullfile(path,'solveDirectDynamicsProblemVP_UK.m');
    destination=fullfile(path,'solveDirectDynamicsProblem.m');
    copyfile (origin, destination);
    rehash;
else
    error('Direct Dynamics Solver not available');
end

% %% Direct Dynamics Problem
% function direct_dynamics_problem()
% 
% %This funtion is a place holder to choose the solver of Eq_Dyn_eq for ddq epsilon and
% %lambda
% global dyn_equations_type has_my_contact_forzes updateDraws_automatic
% global t_value q_value dq_value ddq_value epsilon_value lambda_value param_value
% 
% if has_my_contact_forzes==true
%     my_contact_forzes();
% end
% 
% if strcmp(dyn_equations_type,'Newton-Euler')
% 
%     %% ddq lambda and epsilon from Newton-Euler Naive Method
%     [ddq_value,epsilon_value]=ddq_epsilon_from_Newton_Euler_Naive(q_value, dq_value, t_value, param_value);
% 
% elseif strcmp(dyn_equations_type,'Virtual_Power') || strcmp(dyn_equations_type,'Lagrange')
% 
%     %% ddq lambda and epsilon from Lagrange Naive
%     [ddq_value,epsilon_value,lambda_value]=ddq_lambda_epsilon_from_Lagrange_Naive(q_value, dq_value, t_value);
%     %% ddq lambda and epsilon from Lagrange Udwadia & Kabala
%     %    ddq_lambda_epsilon_from_Lagrange_UK();
%     %% ddq lambda and epsilon from Lagrange Indep Coord
%     %    [ddq_value,epsilon_value,lambda_value]=ddq_lambda_epsilon_from_Lagrange_dz(q_value, dq_value, t_value);
% end
% 
% 
% if updateDraws_automatic
%     updateDraws;
% end

