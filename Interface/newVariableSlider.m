function [outputArg1,outputArg2] = newVariableSlider(name,variable_limits)
%NEWVARIABLESLIDER
% Example: newVariableSlider(["psi","$\psi$"],[-pi,pi]);
%   Detailed explanation goes here
global interface
if not(isempty(interface))
    interface.newVariableSlider(name,variable_limits);
end
end

