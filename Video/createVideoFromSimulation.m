function createVideoFromSimulation(simulation_data_filename, Delta_t_refresh, outputVideoName)
% CREATEVIDEOFROMSIMULATION Generates a video from simulation data in Lib_3D_MEC_MATLAB.
% 
% Syntax:
%   createVideoFromSimulation(simulation_data_filename, Delta_t_refresh, outputVideoName)
%
% Inputs:
%   simulation_data_filename - String specifying the filename of the
%                              simulation data to be loaded.
%   Delta_t_refresh          - Scalar specifying the time interval for
%                              refreshing the graphical output.
%   outputVideoName          - String specifying the name of the output
%                              video file.
%
% Description:
%   This function loads simulation data from a specified file,
%   interpolates the data to create a smooth transition over time,
%   and generates a video that visualizes the model's dynamics.
%   The video frames are captured at specified time intervals and
%   compiled into a video file using the Motion JPEG AVI format.
%
%   The function utilizes global variables to manage the state of the
%   model and Graphical_Output. It is essential to ensure that the
%   global variables are properly initialized including Graphical_Output
%   before calling this function.
%
% Example:
%   createVideoFromSimulation('data.mat', 0.1, 'output_video.avi');
global Graphical_Output
global q_value dq_value ddq_value n_q
global epsilon_value n_epsilon
global lambda_value n_lambda
global lambda_aux_value n_lambda_aux

% Load the data from the specified file
dynamics_extended_state_series = load(simulation_data_filename);

% Interpolate data to get the value at t_refresh

t_values = dynamics_extended_state_series(:, 1);
q_values = dynamics_extended_state_series(:, 2:1 + n_q);
dq_values = dynamics_extended_state_series(:, 1 + n_q + 1:1 + 2 * n_q);
ddq_values = dynamics_extended_state_series(:, 1 + 2 * n_q + 1:1 + 3 * n_q);
epsilon_values = dynamics_extended_state_series(:, 1 + 3 * n_q + 1:1 + 3 * n_q + n_epsilon);
lambda_values = dynamics_extended_state_series(:, 1 + 3 * n_q + n_epsilon + 1:1 + 3 * n_q + n_epsilon + n_lambda);
%lambda_aux_values = dynamics_extended_state_series(:, 1 + 3 * n_q + n_epsilon + n_lambda + 1:1 + 3 * n_q + n_epsilon + n_lambda + n_lambda_aux);

clear dynamics_extended_state_series

% Perform linear interpolation for each variable
t_refresh=t_values(1) : Delta_t_refresh : t_values(end);
q_values = interp1(t_values, q_values, t_refresh, 'linear')';
dq_values = interp1(t_values, dq_values, t_refresh, 'linear')';
ddq_values = interp1(t_values, ddq_values, t_refresh, 'linear')';
epsilon_values = interp1(t_values, epsilon_values, t_refresh, 'linear')';
lambda_values = interp1(t_values, lambda_values, t_refresh, 'linear')';
%lambda_aux_values = interp1(t_values, lambda_aux_values, t_refresh, 'linear')';

%F = []; % Initialize frame array

% Loop through the interpolated data to simulate the model and create video frames
for k = 1:length(t_refresh)
    t_value=t_refresh(k);
    q_value = q_values(:,k);
    dq_value = dq_values(:,k);
    ddq_value = ddq_values(:,k);
    epsilon_value = epsilon_values(:,k);
    lambda_value = lambda_values(:,k);
    %lambda_aux_value = lambda_value(:,k);

    % Update graphical output
    updateDraws;

    Frames(k) = getframe(Graphical_Output);
    t_refresh = t_refresh + Delta_t_refresh;
end

% Create video file
% Check if the directory for the output video exists, if not, create it
[outputDir, ~, ~] = fileparts(outputVideoName);
if ~isempty(outputDir) && ~exist(outputDir, 'dir')
    mkdir(outputDir);
end
video = VideoWriter(outputVideoName, 'Motion JPEG AVI');
video.Quality = 100;
video.FrameRate = 1.5 / Delta_t_refresh;
open(video);
writeVideo(video, Frames);
close(video);
end
