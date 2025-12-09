function [q_value,dq_value]=constraint_projection_problem(q_value, dq_value, t_value, param_value )

% Constraint_PROJECTION_PROBLEM (lib_3D_MEC_MATLAB):
%
% Solves the Constraint Projection Problem, also known as Correction Problem or
% Assembly Problem or Constraint Stabilization Problem
%
% Example:
%   constraint_projection_problem(q_value, dq_value, t_value, param_value )
%
% This problem solves coordinate and velocity constraint equations, Phi
% and dPhi, respectively. dPhi eqs are solved using a minimum norm solution 
% for the diference dq-dq_{-}. 
% Phi eqs are solved using a Newton-Raphson procedure. In each
% iteration of the Newton-Raphson procedure the tangent eqution
% is solved such that q-q_{-} has minimum norm. Usually this takes a
% single iteration, so the solutions for Phi and dPhi are in effect a
% minimum norm correction (variation of q and dq) for Phi and dPhi
%
% Note that auxiliar constraints, PhiAux and dPhiAux (as those arising
% when using general Euler or Angle+Axis parameters for rotations), if
% present, are solved separately using the same algorithm.
% Ideally they should be solved toguether but in MBSD
% the auxiliar equations are essentially decoupled from the constraint
% equations as they are used to correct short deviations of the
% coordinates, q, and velocities, dq, from values that otherwise would
% satisfy contraint and auxiliary constraint equations, so this approach
% adds efficiency.
%
% Requires:  exportConstraintProjectionProblem
% See also NEWPHI NEWDPHI

global updateDraws_automatic
global Geom_Eq_tol Geom_Eq_relax
global has_my_piezewise_functions_in_Phi

if has_my_piezewise_functions_in_Phi
    my_piezewise_functions_in_Phi();
end

% Auxiliar Asembly Problem (Coordinate Level)
PhiAux_num=PhiAux_(q_value,t_value,param_value);
q_value = q_value - Geom_Eq_relax * pinv( PhiAux_q_(q_value,t_value,param_value) ) * PhiAux_num;
PhiAux_num = PhiAux_(q_value,t_value,param_value);
while norm(PhiAux_num)> Geom_Eq_tol
    q_value = q_value - Geom_Eq_relax * pinv( PhiAux_q_(q_value,t_value,param_value) ) * PhiAux_num;
    PhiAux_num = PhiAux_(q_value,t_value,param_value);
end

% Asembly Problem (Coordinate Level)
Phi_num=Phi_(q_value,t_value,param_value);
q_value = q_value - Geom_Eq_relax * pinv( Phi_q_(q_value,t_value,param_value) ) * Phi_num;
Phi_num = Phi_(q_value,t_value,param_value);
while norm(Phi_num)> Geom_Eq_tol
    q_value = q_value - Geom_Eq_relax * pinv( Phi_q_(q_value,t_value,param_value) ) * Phi_num;
    Phi_num = Phi_(q_value,t_value,param_value);
end

% Auxiliar Asembly Problem (Velocity Level)
dPhiAux_dq_num=dPhiAux_dq_(q_value,t_value,param_value);
dq_value=dq_value + pinv( dPhiAux_dq_num ) * (betaAux_(q_value,t_value,param_value) - dPhiAux_dq_num * dq_value);

% Asembly Problem (Velocity Level)
dPhi_dq_num=dPhi_dq_(q_value,t_value,param_value);
dq_value=dq_value + pinv( dPhi_dq_num ) * (beta_(q_value,t_value,param_value) - dPhi_dq_num * dq_value);

if updateDraws_automatic
    updateDraws;
end