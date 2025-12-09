function [eigenvalues_z_dz,eigenvectors_z_dz,eigenvectors_q,eigenvectors_dq,A,perm_d_z,perm_dd_dz]=eigenproblem_VP_z_dz(given_perm_d_z,given_perm_dd_dz)
global eigenvalues
global q_value dq_value ddq_value lambda_value t_value param_value
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
elseif n_d>=1
        disp([char("There are n_d=" + string(n_d)+" dependent generalized coordinates: d=q(perm_d_z(1:n_d))="+ join(string(q(perm_d_z(1:n_d))'))+...
     " and n_z=" + string(n_z)+ " independent generalized coordinates: z=q(perm_d_z(n_d+1:end))="+ join(string(q(perm_d_z(n_d+1:end))'))+" . For readability")]);
        disp("Dep. Coord. vector d"), disp(q(perm_d_z(1:n_d))'), disp("Indep. Coord. vector z"), disp(q(perm_d_z(n_d+1:end))')
else
     disp([char("There are n_d=" + string(n_d)+" dependent generalized coordinates: d=q(perm_d_z(1:n_d))="+ ...
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
elseif n_d>=1
    disp([char("There are n_dd=" + string(n_dd)+" dependent generalized velocities: dd=dq(perm_dd_dz(1:n_dd))="+ join(string(dq(perm_dd_dz(1:n_dd))'))+...
     " and  n_dz=" + string(n_dz)+ " independent generalized velocities: dz=dq(perm_dd_dz(n_dd+1:end))="+ join(string(dq(perm_dd_dz(n_dd+1:end))'))+" . For readability")]);
        disp("Dep. Vel. vector dot_d"), disp(dq(perm_dd_dz(1:n_dd))'), disp("Indep. Vel. vector dot_z"), disp(dq(perm_dd_dz(n_dd+1:end))')
else
    disp([char("There are n_dd=" + string(n_dd)+" dependent generalized velocities: dd=dq(perm_dd_dz(1:n_dd))="+...
     " and  n_dz=" + string(n_dz)+ " independent generalized velocities: dz=dq(perm_dd_dz(n_dd+1:end))="+ join(string(dq(perm_dd_dz(n_dd+1:end))'))+" . For readability")]);
        disp("Dep. Vel. vector dot_d"), disp(dq(perm_dd_dz(1:n_dd))'), disp("Indep. Vel. vector dot_z"), disp(dq(perm_dd_dz(n_dd+1:end))')
end

disp("The independent state vector to solve eigenproblem (z_dz) are:");
disp([q(perm_d_z(n_d+1:end));dq(perm_dd_dz(n_dd+1:end))]');


%% Algorithm to determine A

% Determine the dependent d and independent z Phi jacobians using perm_d_z
Phi_d_num=Phi_q_num(:,perm_d_z(1:n_d));
Phi_z_num=Phi_q_num(:,perm_d_z(n_d+1:end));
inv_Phi_d_num=pinv(Phi_d_num);
R_d_z=-inv_Phi_d_num * Phi_z_num;
R_q_z=[R_d_z;
   eye(n_z)];

% Determine the dependent dd and independent dz dPhi jacobians using perm perm_dd_dz
dPhi_dd_num=dPhi_dq_num(:,perm_dd_dz(1:n_dd));
dPhi_dz_num=dPhi_dq_num(:,perm_dd_dz(n_dd+1:end));
inv_dPhi_dd_num=pinv(dPhi_dd_num);
R_dd_dz=-inv_dPhi_dd_num * dPhi_dz_num;
R_dq_dz=[R_dd_dz;
   eye(n_dz)];

%Determine the Mass Damping and stifness matrix on the independent
%velocity formulation
M_dqdq_num=M_qq_(q_value,t_value,param_value);
M_dddzdddz_num=M_dqdq_num(perm_dd_dz,perm_dd_dz);
C_dqdq_num=C_qq_(q_value,dq_value,t_value,param_value);
C_dddzdddz_num=C_dqdq_num(perm_dd_dz,perm_dd_dz);
K_dqdq_num=K_qq_(q_value,dq_value,ddq_value,lambda_value,t_value,param_value);
K_dddzdddz_num=K_dqdq_num(perm_dd_dz,perm_d_z);

dPhi_q_num=[dPhi_q_(q_value,dq_value,t_value,param_value)];
dPhi_qiqz_num=dPhi_q_num(:,perm_d_z);
ddPhi_q_num=[ddPhi_q_(q_value,dq_value,ddq_value,t_value,param_value)];
ddPhi_qiqz_num=ddPhi_q_num(:,perm_d_z);
ddPhi_dq_num=[ddPhi_dq_(q_value,dq_value,t_value,param_value)];
ddPhi_dddz_num=ddPhi_dq_num(:,perm_dd_dz);

M_dzdz=R_dq_dz'*M_dddzdddz_num*R_dq_dz;

R_ddq_dz=[-inv_dPhi_dd_num*ddPhi_dddz_num*R_dq_dz;
    zeros(n_dz,n_dz)];
C_dzdz=R_dq_dz'*C_dddzdddz_num*R_dq_dz...
    +R_dq_dz'*M_dddzdddz_num*R_ddq_dz;

R_dd_z=-inv_dPhi_dd_num*dPhi_qiqz_num*R_q_z;
R_dq_z=[R_dd_z;
    zeros(n_dz,n_z)];
R_ddd_z=-inv_dPhi_dd_num*(ddPhi_qiqz_num*R_q_z+ddPhi_dddz_num*R_dq_z);
R_ddq_z=[R_ddd_z;
    zeros(n_dz,n_z)];
K_dzz=R_dq_dz'*K_dddzdddz_num*R_q_z...
      +R_dq_dz'*C_dddzdddz_num*R_dq_z...
      +R_dq_dz'*M_dddzdddz_num*R_ddq_z;
                                                              
% Assembing the eigenproblem matrix (state space form)
%A=[R_dq_z((n_d+1:end),:),R_dq_dz((n_d+1:end),:);
%   -M_dzdz^-1*K_dzz,-M_dzdz^-1*C_dzdz];
% Prueba
% A=[R_dq_z(perm_d_z(n_d+1:end),:),R_dq_dz(perm_d_z(n_d+1:end),:);
%    -M_dzdz^-1*K_dzz,-M_dzdz^-1*C_dzdz];

%Hay que darle una vuelta más!!!
A=[R_dq_z(perm_dd_dz(perm_dd_dz(perm_d_z(n_d+1:end))),:),R_dq_dz(perm_dd_dz(perm_dd_dz(perm_d_z(n_d+1:end))),:);
   -M_dzdz^-1*K_dzz,-M_dzdz^-1*C_dzdz];
%permutacion que toma las velocidades ordenadas segun la permutacion de
%velocidades (dq) y las devuelve ordenadas segun la permutación de
%coordenadas (q)
%(perm_dd_dz(perm_dd_dz(perm_d_z(n_d+1:end))))
% así
% q(perm_d_z(n_d+1:end))
% dq_ordered=dq(perm_dd_dz);
% Estas velocidades son las correspondientes a las coordenadas
% independientes y en el mismo orden
% dq_ordered(perm_dd_dz(perm_dd_dz(perm_d_z(n_d+1:end))))

[V,D]=eig(A,'nobalance');
if rank(V,1e5*max(size(A))* eps)<size(A,2)
    warning("The jacobian, A, has Defective Eigenvalues!!!");
end

eigenvalues_z_dz=diag(D);
eigenvalues=eigenvalues_z_dz;
eigenvectors_z_dz=V;
eigenvectors_z=V(1:n_z,:);
eigenvectors_dz=V(n_z+1:end,:);

% [~,perm_eigenvalues]=sort(eigenvalues_z_dz,'descend');
% eigenvalues_z_dz=eigenvalues_z_dz(:,perm_eigenvalues);
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

eigenvectors_q(perm_d_z,:)=[R_q_z,zeros(n_q,n_dz)]*eigenvectors_z_dz;
eigenvectors_dq(perm_dd_dz,:)=[zeros(n_q,n_z),R_dq_dz]*eigenvectors_z_dz;
%eigenvectors_qdq=[eigenvectors_q;eigenvectors_dq];

end