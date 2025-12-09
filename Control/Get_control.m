function value=Get_control(control_name)
%GET_CONTROL Summary of this function goes here
%   Detailed explanation goes here
global control
switch control_name
    case 'update_draws_automatic'
        value=control.update_draws_automatic;
    case 'assembly_problem_automatic'
        value=control.assembly_problem_automatic;
    case 'assembly_problem_exported'
        value=control.assembly_problem_exported;
    case 'initial_assembly_problem_automatic'
        value=control.initial_assembly_problem_automatic;
    case 'initial_assembly_problem_exported'
        value=control.initial_assembly_problem_exported;
    case 'dyn_equations_type'
        value=control.dyn_equations_type;
    case 'direct_dynamics_problem_NE_exported'
        value=control.direct_dynamics_problem_NE_exported;
    case 'direct_dynamics_problem_VP_exported'
        value=control.direct_dynamics_problem_VP_exported;
    case 'equilibrium_problem_NE_exported'
        value=control.equilibrium_problem_NE_exported;
    case 'equilibrium_problem_VP_exported'
        value=control.equilibrium_problem_VP_exported;
    case 'eigen_problem_NE_exported'
        value=control.eigen_problem_NE_exported;
    case 'eigen_problem_VP_exported'
        value=veigen_problem_VP_exported;
    case 'perturbation_problem_NE_exported'
        value=control.perturbation_problem_NE_exported;
    case 'perturbation_problem_VP_exported'
        value=control.perturbation_problem_VP_exported;
    otherwise
        disp('Unknown control.')
end

end


