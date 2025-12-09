function [eigenvalues_z_dz,eigenvectors_z_dz,eigenvectors_q,eigenvectors_dq,A,perm_d_z,perm_dd_dz]=eigenproblem_numerical_z_dz(given_perm_d_z,given_perm_dd_dz)
global eigenvalues
global q_value dq_value t_value param_value
global q dq n_q

global has_my_piezewise_functions_in_Phi

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
    error('The function has 0, 1 (perm_d_z) or 2 (perm_dd_dz) parameters');
end

Phi_q_num=[Phi_q_(q_value,t_value,param_value)];
n_d=rank(Phi_q_num);
n_z=length(q_value)-n_d;
if (exist('perm_d_z','var') == 0  || isempty(perm_d_z))
    [~,~,perm_d_z] = qr(Phi_q_num,'vector');
end
if n_d>rank(Phi_q_num(:,perm_d_z(1:n_d)))
    error([char("There are n_d=" + string(n_d)+" dependent generalized coordinates, but d=q(perm_d_z(1:n_d))="+ join(string(q(perm_d_z(1:n_d))'))+...
     " and z=q(perm_d_z(n_d+1:end))="+ join(string(q(perm_d_z(n_d+1:end))'))+" are not possible sets of dependent and independent generalized coordinates")]);
else
        disp([char("There are n_d=" + string(n_d)+" dependent generalized coordinates: d=q(perm_d_z(1:n_d))="+ join(string(q(perm_d_z(1:n_d))'))+...
     " and n_z=" + string(n_z)+ " independent generalized coordinates: z=q(perm_d_z(n_d+1:end))="+ join(string(q(perm_d_z(n_d+1:end))'))+" . For readability")]);
        disp("Dep. Coord. vector d"), disp(q(perm_d_z(1:n_d))'), disp("Indep. Coord. vector z"), disp(q(perm_d_z(n_d+1:end))')
end


dPhi_dq_num=[dPhi_dq_(q_value,t_value,param_value)];
n_dd=rank(dPhi_dq_num);
n_dz=length(dq_value)-n_dd;
if (exist('perm_dd_dz','var') == 0  || isempty(perm_dd_dz))
    [~,~,perm_dd_dz] = qr(dPhi_dq_num,'vector');
end
if n_dd>rank(dPhi_dq_num(:,perm_dd_dz(1:n_dd)))
    error([char("There are n_dd=" + string(n_dd)+" dependent generalized velocities, but dd=dq(perm_dd_dz(1:n_dd))="+ join(string(dq(perm_dd_dz(1:n_dd))'))+...
     "and dz=dq(perm_dd_dz(n_dd+1:end))="+ join(string(dq(perm_dd_dz(n_dd+1:end))'))+" are not possible sets of dependent and independent generalized velocities")]);
else
    disp([char("There are n_dd=" + string(n_dd)+" dependent generalized velocities: dd=dq(perm_dd_dz(1:n_dd))="+ join(string(dq(perm_dd_dz(1:n_dd))'))+...
     " and  n_dz=" + string(n_dz)+ " independent generalized velocities: dz=dq(perm_dd_dz(n_dd+1:end))="+ join(string(dq(perm_dd_dz(n_dd+1:end))'))+" . For readability")]);
        disp("Dep. Vel. vector dot_d"), disp(dq(perm_dd_dz(1:n_dd))'), disp("Indep. Vel. vector dot_z"), disp(dq(perm_dd_dz(n_dd+1:end))')
end

disp("The independent state vector to solve eigenproblem (z_dz) are:");
disp([q(perm_d_z(n_d+1:end));dq(perm_dd_dz(n_dd+1:end))]');

%% Algorithm to determine A

z_dz=[q_value(perm_d_z(n_d+1:end));dq_value(perm_dd_dz(n_dd+1:end))];
% [A,err]=jacobianest(@(z_dz)d_z_dz_(t_value,z_dz,perm_d_z,n_d,perm_dd_dz,n_dd),z_dz);

A=numerical_jacobian(@(z_dz)d_z_dz_(t_value,z_dz,perm_d_z,n_d,perm_dd_dz,n_dd),z_dz);

[V,D]=eig(A,'nobalance');
if rank(V,1e6*max(size(A))* eps)<size(A,2)
    warning("The jacobian, A, has Defective Eigenvalues!!!");
end

eigenvalues_z_dz=diag(D);
eigenvalues=eigenvalues_z_dz;
eigenvectors_z=V(1:n_z,:);
eigenvectors_dz=V(n_z+1:end,:);
eigenvectors_z_dz=V;

% [~,perm_eigenvalues]=sort(eigenvalues_z_dz,'descend');
% eigenvalues_z_dz=eigenvalues_z_dz(perm_eigenvalues);
% eigenvectors_z_dz=eigenvectors_z_dz(:,perm_eigenvalues);

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

eigenvectors_q(perm_d_z,:)=R_q_z*eigenvectors_z;
eigenvectors_dq(perm_dd_dz,:)=R_dq_dz*eigenvectors_dz;
%eigenvectors_qdq=[eigenvectors_q;eigenvectors_dq];
