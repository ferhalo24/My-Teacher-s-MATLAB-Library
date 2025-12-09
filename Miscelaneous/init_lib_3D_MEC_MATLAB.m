load release
splash = SplashScreen( 'Splashscreen', '3d_mec_title2_litle2.png');
      %splash.addText( 30, 50, 'My Cool App', 'FontSize', 30, 'Color', [0 0 0.6] )
      splash.addText( 280, 30, release, 'FontSize', 20, 'Color', [0.2 0.2 0.5] )
      splash.addText( 300, 270, 'Loading...', 'FontSize', 20, 'Color', 'white' );
clear release
my_timer = timer('StartDelay',5,'TimerFcn',{@my_callback_fcn, splash});
start(my_timer);

global Bases
global BasesNames NamesBases


Bases=[];
keySet =   {'xyz' 'abs'};
valueSet = [0 0];
BasesNames = containers.Map(keySet,valueSet);

global Frames
global FramesNames NamesFrames

keySet =   {'abs'};
valueSet = [0];
FramesNames = containers.Map(keySet,valueSet);

global InertialFrame_name
InertialFrame_name='abs';

global Solids n_Solids
global SolidsNames NamesSolids

keySet =   {'abs'};
valueSet = [0];
SolidsNames = containers.Map(keySet,valueSet);

global Points
global PointsNames NamesPoints

Points = [];
keySet = {'O' 'abs'};
valueSet = [0 0];
PointsNames = containers.Map(keySet,valueSet);


global Joints
Joints=[];

global Draws
% ToDo, set automatic names for the objects Drawn, like Solid_Gr, Frame_abs, Point_J,
% Vector_variable or Vector_Velocity Vector_Force.
% REMEMBER if clearDraw onject, it should be removed also from DrawsNames NamesDraws
% global DrawsNames NamesDraws

Draws=[];
% keySet =   {'abs'};
% valueSet = [0];
% DrawsNames = containers.Map(keySet,valueSet);

global Graphical_Output
global ax
global ax_Xlimit
global ax_Ylimit
global ax_Zlimit

ax_Xlimit=[-2,2];
ax_Ylimit=[-2,2];
ax_Zlimit=[-2,2];

Graphical_Output = findobj( 'Type', 'Figure', 'Name', 'Graphical_Output' );
if ~isempty(Graphical_Output)
%     clf(Graphical_Output,'reset');
    clf(Graphical_Output);
    % ax=Graphical_Output.CurrentAxes;
    ax = axes(Graphical_Output);
end

if isempty(Graphical_Output)
%Graphical_Output=figure();
Graphical_Output=figure('visible','off');
ax = axes(Graphical_Output);
end

set(Graphical_Output,'Name','Graphical_Output');
set(Graphical_Output,'NumberTitle','off');
set(Graphical_Output,'CloseRequestFcn',@my_closereq);
%set(Graphical_Output,'Visible','on');

% axes(ax,'XLim',[-5 5],'YLim',[-5 5],'ZLim',[0 5]);

ax.Clipping = 'off';    % turn clipping off
axis(ax,'equal');
axis(ax,'off');
axis(ax,'manual');
%axis(ax,'on');
grid(ax,'on');
%shading(ax, 'faceted');
%shading(ax, 'interp'); %error needs a special per face color definition
camlight(ax, 'headlight');
%material(ax,'shiny')
material(ax, 'dull')
%material(ax,'metal');
%view(ax,3);
view(ax,110,40);
ax.XLim=ax_Xlimit;
ax.YLim=ax_Ylimit;
ax.ZLim=ax_Zlimit;

% else
% set(Graphical_Output,'Visible','on');    
% ax=Graphical_Output.CurrentAxes;
% %ax = gca
% %ax=axes('XLim',[-5 5],'YLim',[-5 5],'ZLim',[0 5]);
% xlim(ax,[-10,10]);
% ax.Clipping = 'off';    % turn clipping off
% axis(ax,'equal');
% axis(ax,'off');
% axis(ax,'manual');
% %axis(ax,'on');
% grid(ax,'on');
% shading(ax, 'faceted');
% %shading(ax, 'interp'); %error needs a special per face color definition
% camlight(ax, 'headlight');
% %material(ax,'shiny')
% material(ax, 'dull')
% %material(ax,'metal');
% view(ax,3);
% view(ax,110,40);   
% 
% end

global t

t=sym('t','real');

global q dq ddq
global qNames dqNames ddqNames
global n_q n_dq n_ddq

q=sym(zeros(0,1)); dq=sym(zeros(0,1)); ddq=sym(zeros(0,1));
n_q=0; n_dq=0; n_ddq=0;

global OCdq
global OCdqNames
global n_OCdq
OCdq=sym(zeros(0,1));
n_OCdq=0;

qNames=containers.Map();
dqNames=containers.Map();
ddqNames=containers.Map();

OCdqNames=containers.Map();

global param paramNames
global n_param

param=sym(zeros(0,1));

paramNames=containers.Map();

global epsilon n_epsilon epsilonNames
epsilon=sym(zeros(0,1)); n_epsilon=0;
epsilonNames=containers.Map();

global epsilono n_epsilono
epsilono=sym(zeros(0,1)); n_epsilono=0;

global epsilono n_epsilonc
epsilonc=sym(zeros(0,1)); n_epsilonc=0;

global lambda n_lambda lambdaNames
lambda=sym(zeros(0,1)); n_lambda=0;

lambdaNames=containers.Map();

global lambda_aux lambda_auxNames
global n_lambda_aux
lambda_aux=sym(zeros(0,1)); n_lambda_aux=0;

lambda_auxNames=containers.Map();

global t_value

global q_value
q_value=zeros(0,1);
global dq_value
dq_value=zeros(0,1);
global ddq_value
ddq_value=zeros(0,1);
global param_value
param_value=zeros(0,1);
global epsilon_value
epsilon_value=zeros(0,1);
global lambda_value
lambda_value=zeros(0,1);
global lambda_aux_value
lambda_aux_value=zeros(0,1);

t_value=0;

global optimize_matlabFunction

optimize_matlabFunction=false;

global has_my_contact_forzes

has_my_contact_forzes=false;

global has_my_piezewise_functions_in_Phi

has_my_piezewise_functions_in_Phi=false;

global Geom_Eq_tol Geom_Eq_relax
Geom_Eq_tol=1.0e-14;
Geom_Eq_relax=1;

global Geom_Eq_init_tol Geom_Eq_init_relax Eq_init_max_iter
Geom_Eq_init_tol=1.0e-10;
Geom_Eq_init_relax=0.1;
Eq_init_max_iter=300;

global round_mass_tol
global round_center_of_mass_tol1
global round_center_of_mass_tol2
global round_inertia_tensor_tol1 
global round_inertia_tensor_tol2

round_mass_tol=1e-4;
round_center_of_mass_tol1=1e-4;
round_center_of_mass_tol2=1e-3;
round_inertia_tensor_tol1=1e-4;
round_inertia_tensor_tol2=1e-3;

global updateDraws_automatic
updateDraws_automatic=true;

global PhiAux dPhiAux ddPhiAux
global n_PhiAux n_dPhiAux n_ddPhiAux
PhiAux=sym(zeros(0,1)); dPhiAux=sym(zeros(0,1)); ddPhiAux=sym(zeros(0,1));
n_PhiAux=0; n_dPhiAux=0; n_ddPhiAux=0;

global Phi dPhi dPhi_dq ddPhi PhiInit dPhiInit
global n_Phi n_dPhi n_ddPhi n_PhiInit n_dPhiInit

Phi=sym(zeros(0,1)); dPhi=sym(zeros(0,1)); ddPhi=sym(zeros(0,1)); PhiInit=sym(zeros(0,1)); dPhiInit=sym(zeros(0,1));
n_Phi=0; n_dPhi=0; n_ddPhi=0; n_PhiInit=0; n_dPhiInit=0;

global PhiH
global n_PhiH
PhiH=sym(zeros(0,1));
n_PhiH=0;

global dPhiH dPhiNH
global n_dPhiH n_dPhiNH
dPhiH=sym(zeros(0,1));
dPhiNH=sym(zeros(0,1));
n_dPhiH=0;
n_dPhiNH=0;

global ddPhiH ddPhiNH
global n_ddPhiH n_ddPhiNH
ddPhiH=sym(zeros(0,1));
ddPhiNH=sym(zeros(0,1));
n_ddPhiH=0;
n_ddPhiNH=0;

global dyn_equations_type
dyn_equations_type='Newton-Euler';

global GravityVector

GravityVector=[];

global V M_V_dV
V=sym(zeros(0,1));
M_V_dV=sym(zeros(0,0));;

global M_vq M_qq
global delta_v delta_q
delta_v=sym(zeros(0,1));
delta_q=sym(zeros(0,1));

global C_vq C_qq
global K_vq K_qq

global beta gamma
beta=sym(zeros(0,1));
gamma=sym(zeros(0,1));

global beta_aux gamma_aux
beta_aux=sym(zeros(0,1));
gamma_aux=sym(zeros(0,1));

global Dyn_eq_NE FC_vepsilon
global n_Dyn_eq_NE
Dyn_eq_NE=sym(zeros(0,1));

global Dyn_eq_VP FC_qepsilon Dyn_eq_L
global n_Dyn_eq_VP
Dyn_eq_VP=sym(zeros(0,1));
Dyn_eq_L=sym(zeros(0,1));

global Dyn_eq_VP_OC  FC_OCqepsilon
global n_Dyn_eq_VP_OC
Dyn_eq_VP_OC=sym(zeros(0,1));

global Dyn_Eq_eq_NE Dyn_Eq_eq_VP
Dyn_Eq_eq_NE=sym(zeros(0,1));
Dyn_Eq_eq_VP=sym(zeros(0,1));


global compute_all_epsilon_in_VP
compute_all_epsilon_in_VP==true;

global Extra_Dyn_Eq_eq
global n_Extra_Dyn_Eq_eq
Extra_Dyn_Eq_eq=sym(zeros(0,1));
n_Extra_Dyn_Eq_eq=0;

global Perturbed_Dyn_State_eq_NE Perturbed_Dyn_State_eq_VP
Perturbed_Dyn_State_eq_NE=sym(zeros(0,1));
Perturbed_Dyn_State_eq_VP=sym(zeros(0,1));

global Extra_Perturbed_Dyn_State_eq
global n_Extra_Perturbed_Dyn_State_eq
Extra_Perturbed_Dyn_State_eq=sym(zeros(0,1));
n_Extra_Perturbed_Dyn_State_eq=0;

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

warning('off','MATLAB:hg:DiceyTransformMatrix');
warning('off','MATLAB:MKDIR:DirectoryExists');

global pop_up_dialogs
pop_up_dialogs=true;

global characteristic_size
characteristic_size=1;

global characteristic_scene_length
characteristic_scene_length=3;

global simplify_omega
simplify_omega=true;

global simplify_expressions
simplify_expressions=false;

global  n_VariableSlider
n_VariableSlider=0;

global OptionButton n_OptionButton
n_OptionButton=0;

global n_pushbutton
n_pushbutton=0;

global assembly_problem_automatic assembly_problem_exported
assembly_problem_automatic=false;
assembly_problem_exported=false;

global initial_assembly_problem_automatic initial_assembly_problem_exported
initial_assembly_problem_automatic=false;
initial_assembly_problem_exported=false;


global direct_dynamics_problem_automatic direct_dynamics_problem_NE_exported direct_dynamics_problem_VP_exported
direct_dynamics_problem_automatic=false;
direct_dynamics_problem_NE_exported=false;
direct_dynamics_problem_VP_exported=false;

global equilibrium_problem_NE_exported equilibrium_problem_VP_exported
equilibrium_problem_NE_exported=false;
equilibrium_problem_VP_exported=false;
global Dyn_Eq_tol  Dyn_Eq_relax
Dyn_Eq_tol=1.0000e-10;
Dyn_Eq_relax=1.0e-3;

global eigen_problem_NE_exported eigen_problem_VP_exported
eigen_problem_NE_exported=false;
eigen_problem_VP_exported=false;

%global perm_d_z perm_dd_dz eigenvalues  %remove as soon as possible!!!!

global perturbation_problem_NE_exported perturbation_problem_VP_exported
perturbation_problem_NE_exported=false;
perturbation_problem_VP_exported=false;
global Per_Dyn_State_tol Per_Dyn_State_relax
Per_Dyn_State_tol=1.0e-12;
Per_Dyn_State_relax=0.1;


global Delta_t
Delta_t=0.001;

global Delta_t_refresh
Delta_t_refresh=1/24;

global t_refresh
t_refresh=t_value;

global t_end
t_end=t_value+Delta_t_refresh;

global integrator_type
integrator_type='Euler';

global matlab_ode_suite_options
matlab_ode_suite_options=odeset('RelTol',1e-10,'AbsTol',1e-10);

global control
global interface
control=Control();
% interface=Interface();

% Write down dynamic eq VP
global debug_Dyn_eq_VP_orth
debug_Dyn_eq_VP_orth=false;

global equilibrium_problem_solved
equilibrium_problem_solved=false;

global cam_target_use
cam_target_use=false;

global cam_pos_use
cam_pos_use=false;

global cam_view_angle_use
global cam_view_angle
cam_view_angle_use=false;
camva(ax,60)
cam_view_angle=camva(ax);

global cam_up_use
cam_up_use=false;
global cam_proj_use
cam_proj_use=false;
global cam_proj_name
cam_proj_name=camproj(ax);

global scad_dir
global stl_dir
scad_dir='./scad';
stl_dir='./stl';
if exist(scad_dir, 'dir') ~= 7
    % Create the directory if it does not exist
    mkdir(scad_dir);
    disp(['Directory "', scad_dir, '" created.']);
end
if exist(stl_dir, 'dir') ~= 7
    % Create the directory if it does not exist
    mkdir(stl_dir);
    disp(['Directory "', stl_dir, '" created.']);
end
addpath(scad_dir)
addpath(stl_dir)