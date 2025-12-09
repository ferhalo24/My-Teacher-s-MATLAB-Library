function initial_assembly_problem()

% INITIAL_ASSEMBLY_PROBLEM (lib_3D_MEC_MATLAB):
%
% Solves the Initial Assembly Problem
%
% Example:
%   initial_assembly_problem()
%
% This problem adds initial conditions at the coordinate
% and velocity level, PhiInit and dPhiInit, to the Assembly Problem.
% To that end these eqs are solved together with the coordinate and
% velocity constraint equations, Phi and dPhi,respectively.
%
% Note that auxiliar constraints, PhiAux amd dPhiAux (as those arising
% when using general Euler or Angle+Axis parameters for rotations) , if
% present, are included as well.
%
% Requires: Export_Initial_Assembly_Problem Export_Assembly_Problem
% See also ASSEMBLY_PROBLEM NEWPHIINIT NEWDPHIINIT
% EXPORT_INITIAL_ASSEMBLY_PROBLEM EXPORT_ASSEMBLY_PROBLEM

global t_value q_value dq_value param_value
global updateDraws_automatic
global Geom_Eq_init_tol Geom_Eq_init_relax
global has_my_piezewise_functions_in_Phi

% Initial Assembly Problem (Coordinate Level)
if has_my_piezewise_functions_in_Phi
    %e. g. piezewise function like a spline of order 3, is defined a 
    %polynomial of involving 3 parameters, to reflect the particular
    %polynomial stretch. Therefore, this function will be defined to change
    %the value of these parameters (in param_value) as a function of the state.
    my_piezewise_functions_in_Phi();
end
function_num=[Phi_(q_value,t_value,param_value);
    PhiInit_(q_value,t_value,param_value);
    PhiAux_(q_value,t_value,param_value)];
while norm(function_num)> Geom_Eq_init_tol
    jacobian_num=[Phi_q_(q_value,t_value,param_value);
        PhiInit_q_(q_value,t_value,param_value);
        PhiAux_q_(q_value,t_value,param_value)];
    q_value = q_value - Geom_Eq_init_relax * pinv( jacobian_num ) * function_num;
    if has_my_piezewise_functions_in_Phi
        my_piezewise_functions_in_Phi();
    end
    function_num=[Phi_(q_value,t_value,param_value);
        PhiInit_(q_value,t_value,param_value);
        PhiAux_(q_value,t_value,param_value)];
end

% Initial Assembly Problem (Velocity Level)
jacobian_num=[dPhi_dq_(q_value,t_value,param_value);
    dPhiInit_dq_(q_value,t_value,param_value);
    dPhiAux_dq_(q_value,t_value,param_value)];
beta_num=[beta_(q_value,t_value,param_value);
    betaInit_(q_value,t_value,param_value);
    betaAux_(q_value,t_value,param_value)];
dq_value = dq_value + pinv( jacobian_num ) * ( beta_num - jacobian_num * dq_value );


if updateDraws_automatic
    updateDraws;
end
setControl('initial_assembly_problem_solved',true);