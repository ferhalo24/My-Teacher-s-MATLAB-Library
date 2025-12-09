function setControl(control_name,value)
%setControl Summary of this function goes here
%   Detailed explanation goes here
global control
switch control_name
    case 'update_draws_automatic'
        control.update_draws_automatic=value;
    case 'assembly_problem_automatic'
        control.assembly_problem_automatic=value;
    case 'assembly_problem_exported'
        control.assembly_problem_exported=value;
    case 'assembly_problem_solved'
        control.assembly_problem_solved=value;
    case 'initial_assembly_problem_automatic'
        control.initial_assembly_problem_automatic=value;
    case 'initial_assembly_problem_exported'
        control.initial_assembly_problem_exported=value;
    case 'initial_assembly_problem_solved'
        control.initial_assembly_problem_solved=value;
    case 'dyn_equations_type'
        control.dyn_equations_type=value;
    case 'direct_dynamics_solver'
        control.dyn_equations_type=value;
    case 'direct_dynamics_problem_NE_exported'
        control.direct_dynamics_problem_NE_exported=value;
    case 'direct_dynamics_problem_VP_exported'
        control.direct_dynamics_problem_VP_exported=value;
    case 'direct_dynamics_problem_solved'
        control.direct_dynamics_problem_solved=value;
    case 'equilibrium_problem_NE_exported'
        control.equilibrium_problem_NE_exported=value;
    case 'equilibrium_problem_VP_exported'
        control.equilibrium_problem_VP_exported=value;
    case 'equilibrium_problem_solved'
        control.equilibrium_problem_solved=value;
    case 'eigen_problem_NE_exported'
        control.eigen_problem_NE_exported=value;
    case 'eigen_problem_VP_exported'
        control.eigen_problem_VP_exported=value;
    case 'eigen_problem_solved'
        control.eigen_problem_solved=value;
    case 'perturbation_problem_NE_exported'
        control.perturbation_problem_NE_exported=value;
    case 'perturbation_problem_VP_exported'
        control.perturbation_problem_VP_exported=value;
    otherwise
        disp('Unknown control.')
end

end

