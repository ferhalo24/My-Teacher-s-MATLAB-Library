function [eigenvalues_z,eigenvectors_z,eigenvectors_q,eigenvectors_dq]=eigenproblem_VP_dz(given_perm_d_z,given_perm_dd_dz)
global eigenvalues
global q_value dq_value ddq_value lambda_value lambda_aux_value t_value param_value
global q n_q

global has_my_piezewise_functions_in_Phi


warning('This function is not right always for nonholonomic systems. Use eigenproblem_VP_z_dz or eigenproblem_VP_numerical_z_dz');

if has_my_piezewise_functions_in_Phi
    my_piezewise_functions_in_Phi();
end

if nargin==0
    perm_d_z=[];
    perm_dd_dz=[];
elseif  nargin==1
    perm_d_z=given_perm_d_z;
    perm_dd_dz=given_perm_d_z;
elseif  nargin==2
    perm_d_z=given_perm_d_z;
    perm_dd_dz=given_perm_dd_dz;
elseif nargin > 2
    error('eigenproblem_VP_numerical dz has 0, 1 (perm_d_z) or 2 (perm_dd_dz) parameters');
end

if (exist('perm_d_z','var') == 0  || isempty(perm_d_z))
    Phi_q_num=[Phi_q_(q_value,t_value,param_value);
        PhiAux_q_(q_value,t_value,param_value)];
    n_d=rank(Phi_q_num);
    n_z=length(q_value)-n_d;
    [~,~,perm_d_z] = qr(Phi_q_num,'vector');
end
if (exist('perm_dd_dz','var') == 0  || isempty(perm_dd_dz))
    dPhi_dq_num=[dPhi_dq_(q_value,t_value,param_value);
        dPhiAux_dq_(q_value,t_value,param_value)];
    n_dd=rank(dPhi_dq_num);
    n_dz=length(dq_value)-n_dd;
    [~,~,perm_dd_dz] = qr(dPhi_dq_num,'vector');
end

% disp('perm_d_z=');
% disp(perm_d_z);
% disp('d=');
% disp(q(perm_d_z(1:n_d)));
% disp('z=');
% disp(q(perm_d_z(n_d+1:end)));
% 
% disp('perm_dd_dz=');
% disp(perm_dd_dz);
% disp('dd=');
% disp(q(perm_dd_dz(1:n_dd)));
% disp('dz=');
% disp(q(perm_dd_dz(n_dd+1:end)));

%Determine the dependent d and independent z Phi jacobians using perm_d_z
Phi_d_num=Phi_q_num(:,perm_d_z(1:n_d));
Phi_z_num=Phi_q_num(:,perm_d_z(n_d+1:end));
inv_Phi_d_num=pinv(Phi_d_num);
R_q_z=[-inv_Phi_d_num * Phi_z_num;
   eye(n_z)];

%Determine the dependent dd and independent dz dPhi jacobians using perm perm_dd_dz
dPhi_dd_num=dPhi_dq_num(:,perm_dd_dz(1:n_dd));
dPhi_dz_num=dPhi_dq_num(:,perm_dd_dz(n_dd+1:end));
inv_dPhi_dd_num=pinv(dPhi_dd_num);
R_dq_dz=[-inv_dPhi_dd_num * dPhi_dz_num;
   eye(n_dz)];

%Determine the Mass Damping and stifness matrix on the independent
%velocity formulation
M_dqdq_num=M_qq_(q_value,t_value,param_value);
M_dddzdddz_num=M_dqdq_num(perm_dd_dz,perm_dd_dz);
C_dqdq_num=C_qq_(q_value,dq_value,t_value,param_value);
C_dddzdddz_num=C_dqdq_num(perm_dd_dz,perm_dd_dz);
K_dqdq_num=K_qq_(q_value,dq_value,ddq_value,lambda_value,lambda_aux_value,t_value,param_value);
K_dddzdddz_num=K_dqdq_num(perm_dd_dz,perm_dd_dz);

dPhi_q_num=[dPhi_q_(q_value,dq_value,t_value,param_value);
            dPhiAux_q_(q_value,dq_value,t_value,param_value)];
dPhi_qiqz_num=dPhi_q_num(:,perm_dd_dz);
ddPhi_q_num=[ddPhi_q_(q_value,dq_value,ddq_value,t_value,param_value);
             ddPhiAux_q_(q_value,dq_value,ddq_value,t_value,param_value)];
ddPhi_qiqz_num=ddPhi_q_num(:,perm_dd_dz);
ddPhi_dq_num=[ddPhi_dq_(q_value,dq_value,t_value,param_value);
              ddPhiAux_dq_(q_value,dq_value,t_value,param_value)];
ddPhi_dddz_num=ddPhi_dq_num(:,perm_dd_dz);

M_dzdz=R_dq_dz'*M_dddzdddz_num*R_dq_dz;
C_dzdz=R_dq_dz'*C_dddzdddz_num*R_dq_dz...
    +R_dq_dz'*M_dddzdddz_num*[-inv_dPhi_dd_num*ddPhi_dddz_num*R_dq_dz;
                     zeros(n_dz,n_dz)];
K_dzdz=R_dq_dz'*K_dddzdddz_num*R_dq_dz...
    +R_dq_dz'*M_dddzdddz_num*[-inv_dPhi_dd_num*ddPhi_qiqz_num*R_dq_dz;
                     zeros(n_dz,n_dz)]...
    +R_dq_dz'*C_dddzdddz_num*[-inv_dPhi_dd_num*dPhi_qiqz_num*R_dq_dz;
                     zeros(n_dz,n_dz)];
                          
                 
%Term in K_dzdz comming from beta_lin in M_dzdz
additional_term=+R_dq_dz'*M_dddzdddz_num*[-inv_dPhi_dd_num*ddPhi_dddz_num*...
[-inv_dPhi_dd_num*dPhi_qiqz_num*R_dq_dz;
                     zeros(n_dz,n_dz)];
                     zeros(n_dz,n_dz)];
                 
K_dzdz=K_dzdz+additional_term;

tol_eigenvectors_q=1.0e-10;
if norm( additional_term) > tol_eigenvectors_q
    warning('beta_lin contribution to K_dzdz is not negligible');
end
                     
%Assembing the eigenproblem matrix (state space form)
A=[zeros(n_dz,n_dz),eye(n_dz);
   -M_dzdz^-1*K_dzdz,-M_dzdz^-1*C_dzdz];

[V,D]=eig(A,'nobalance');

eigenvalues_z=diag(D);
eigenvalues=eigenvalues_z;
eigenvectors_z=V;

eigenvectors_q(perm_dd_dz,:)=[R_dq_dz,zeros(n_q,n_dz)]*eigenvectors_z;
eigenvectors_dq(perm_dd_dz,:)=[zeros(n_q,n_dz),R_dq_dz]*eigenvectors_z;
eigenvectors_qdq=[eigenvectors_q;eigenvectors_dq];

if norm(    -inv_dPhi_dd_num*dPhi_qiqz_num*R_dq_dz*eigenvectors_z(1:n_dz,:))> tol_eigenvectors_q
        warning('This warning is just to check in which examples beta_lin is not negligible')
end

disp('eigenvalues_z');disp(eigenvalues_z);
disp('eigenvectors_z');disp(eigenvectors_z);
disp('eigenvectors_qdq');disp(eigenvectors_qdq);