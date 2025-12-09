# Export Direct Dynamics Problem. Virtual Power or *Lagrange* Formalisms
To solve VP Dynamics equations along with constraint equations at the acceleration level. Estructure with constraint unknowns
$&dollar&;\\mathbf{e}^{D y n, VP}=\\mathbf{M}\_{\\dot{\\mathbf{q}} \\dot{\\mathbf{q}}} \\ddot{\\mathbf{q}}-\\mathbf{f}\_{\\dot{\\mathbf{q}} \\epsilon}^C \\mathbf{\\epsilon}-\\mathbf{\\delta}\_{\\dot{\\mathbf{q}}}=\\mathbf{0}&dollar&;$
Structure with lagrange multipliers
$&dollar&;\\mathbf{e}^{D y n, VP}=\\mathbf{M}\_{\\dot{\\mathbf{q}} \\dot{\\mathbf{q}}} \\ddot{\\mathbf{q}}+\\dot{\\mathbf{\\phi}}^T\_{\\dot{\\mathbf{q}}} \\mathbf{\\lambda}-\\mathbf{\\delta}\_{\\dot{\\mathbf{q}}}=\\mathbf{0}&dollar&;$
Solvable along with constraint equations at the acceleration level
$&dollar&;\\ddot{\\phi}(\\mathbf{q}, \\dot{\\mathbf{q}}, \\ddot{\\mathbf{q}}, t)=\\dot{\\phi}\_{\\dot{\\mathbf{q}}}(\\mathbf{q}, t) \\ddot{\\mathbf{q}}-\\gamma(\\mathbf{q}, \\dot{\\mathbf{q}}, t)=\\mathbf{0}&dollar&;$
for $\\ddot{\\mathbf{q}}$ and $\\mathbf{\\lambda}$
$&dollar&;\\mathbf{e}^{D y n, VP}=\\left\[\\begin{array}{cc}\\mathbf{M}\_{\\dot{\\mathbf{q}} \\dot{\\mathbf{q}}}  &  \\dot{\\phi}\_{\\dot{\\mathbf{q}}}^T \\\\ \\dot{\\phi}\_{\\dot{\\mathbf{q}}} & \\mathbf{0}\\end{array}\\right\]\\left\[\\begin{array}{l}\\ddot{\\mathbf{q}} \\\\ \\mathbf{\\lambda} \\end{array}\\right\]+\\left\[\\begin{array}{c}-\\mathbf{\\delta}\_{\\mathbf{v}} \\\\ -\\mathbf{\\gamma}\\end{array}\\right\]=\\left\[\\begin{array}{l}\\mathbf{0} \\\\ \\mathbf{0}\\end{array}\\right\]&dollar&;$
we need to export the mass matrix, $\\mathbf{M}\_{\\dot{\\mathbf{q}} \\dot{\\mathbf{q}}} $, the jacobian of the constraint forces, $\\mathbf{f}\_{\\dot{\\mathbf{q}} \\epsilon}^C$, and the independent term $\\mathbf{\\delta\_{\\dot{\\mathbf{q}}}$(other matrix functions already exported when exporting the Assembly Problem). As can be seen, the contribution of the constraint unknowns $\\mathbf{f}^C\_{\\dot{\\mathbf{q}}\\mathbf{\\epsilon}} \\mathbf{\\epsilon}$, can be expresed in terms of teh *Lagrange* multipliers, $\\dot{\\mathbf{\\phi}}^T\_{\\dot{\\mathbf{q}}} \\mathbf{\\lambda}$, we can recover  subset of constraint unknows $\\mathbf{\\epsilon}$ related to the joint enforcing sontrints, in terms of the Lagrange multipliers $\\mathbf{\\lambda}$.
$-\\mathbf{f}\_{\\dot{\\mathbf{q}} \\epsilon}^C \\mathbf{\\epsilon}=\\dot{\\mathbf{\\phi}}^T\_{\\dot{\\mathbf{q}}} \\mathbf{\\lambda} \\Rightarrow  \\mathbf{\\epsilon} = -{\\mathbf{f}\_{\\dot{\\mathbf{q}} \\epsilon}^C} ^+ \\dot{\\mathbf{\\phi}}^T\_{\\dot{\\mathbf{q}}} $
function Export_Direct_Dynamics_Problem_VP()

global t q dq ddq epsilon lambda param
global Dyn_eq_VP Dyn_eq_L M_qq delta_q FC_qepsilon dPhi_dq
global Dyn_eq_VP_OC M_OCqq delta_OCq FC_OCqepsilon
global optimize_matlabFunction
Determine expressions for the to-be exported functions.
By default we asume that the constraint contribution to the VP dynamic equations has been given in terms of the set $\\mathbf{\\epsilon}$. Removing these, if any, will lead to the dynamic equations of the "Open" system. Basically, if the joints enforzed trough constraints equations (not by the parameterization) would not be present , no $\\mathbf{\\epsilon}$ twould appear in the VP equations. Conversely, if considered only the subset of $\\mathbf{\\epsilon}$ associated with the joints enforced through the constraints would appear.
Dyn_eq_VP_open=subs(Dyn_eq_VP,epsilon,sym(zeros(size(epsilon))));
Now we express the constraint contribution to the VP dynamic equations in terms of the *Lagrange* multipliers (dyamic direct problem $\\mathbf{A} \\mathbf{x}=\\mathbf{b}$ leading matrix $\\mathbf{A}$ is symmetric and, in $\\mathbf{x}$, $\\mathbf{\\epsilon}$ is substituted by $\\mathbf{\\lambda}$, $\\mathbf{x}=\[\\ddot{\\mathbf{q}}^T,\\mathbf{\\lambda}^T\]^T$.
clearLambdas();
newLambdas();
Dyn_eq_L=Dyn_eq_VP_open+dPhi_dq'*lambda;
Determine the expression for mass matrix $\\mathbf{M}\_{\\dot{q}\\dot{q}}$, and check that it is positive definite.
M_qq=jacobian(Dyn_eq_VP,ddq);
if min(eig(getValue(M_qq))) <0
    error('Mass matrix, M_qq, is not positive semi definite');
end
Determine expression for $\\mathbf{\\delta}\_{\\dot{\\mathbf{q}}$
delta_q=subs(Dyn_eq_VP,epsilon,sym(zeros(size(epsilon))));
delta_q=subs(delta_q,lambda,sym(zeros(size(lambda))));
delta_q=-subs(delta_q,ddq,zeros(size(ddq)));
Determine the expression for $\\mathbf{f}^C\_{\\dot{\\mathbf{q}}\\mathbf{\\epsilon}}$.
FC_qepsilon=-jacobian(Dyn_eq_VP,epsilon);
MATLAB Symbolic Toolbox `matlabFunction` function is used to export the required functions  from symbolic expresions to be used in the numerical solvers. Notice the function dependencies.
matlabFunction(FC_qepsilon,'File','FC_qepsilon_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(M_qq,'File','M_qq_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(delta_q,'File','delta_q_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);
Lib\_3D\_MEC control  related, informs to the library that the VP Direct Dynamics Problem functions have been exported. In this way, it knows that it can be solved.
setControl('direct_dynamics_problem_VP_exported',true);
**Advanced**, to export the orthogonal complement of the VP equations.
if not(isempty(Dyn_eq_VP_OC))
    M_OCqq=jacobian(Dyn_eq_VP_OC,ddq);
    delta_OCq=subs(Dyn_eq_VP_OC,epsilon,sym(zeros(size(epsilon))));
    delta_OCq=subs(delta_OCq,lambda,sym(zeros(size(lambda))));
    delta_OCq=-subs(delta_OCq,ddq,zeros(size(ddq))); %delta=simplify(delta_q)
    FC_OCqepsilon=-jacobian(Dyn_eq_VP_OC,epsilon); %FC_vepsilon=simplify(FC_vepsilon);
    
    matlabFunction(FC_OCqepsilon,'File','FC_OCqepsilon_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
    matlabFunction(M_OCqq,'File','M_OCqq_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
    matlabFunction(delta_OCq,'File','delta_OCq_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);
end


end
