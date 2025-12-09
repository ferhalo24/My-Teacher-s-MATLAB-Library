function newOptionButton(name)
global OptionButton n_OptionButton n_VariableSlider
n_OptionButton=n_OptionButton+1;
% OptionButton.width(n_OptionButton)=120;
OptionButton.radiobutton(n_OptionButton) = uicontrol('Style','radiobutton','String',name,'Position',[20,(n_VariableSlider+n_OptionButton)*20,20,20]);
OptionButton.text(n_VariableSlider) = uicontrol('Style','text','String',name,'Position',[20+20,(n_VariableSlider+n_OptionButton)*20,200,20]);
OptionButton.radiobutton(n_OptionButton).Value=0;
OptionButton.radiobutton(n_OptionButton).Callback=@su;
end


function a= su(c,event)
global updateDraws_automatic assembly_problem_automatic direct_dynamics_problem_automatic
name=get(c,'String');
if strcmp(name,'assembly_problem_automatic')
    assembly_problem_automatic=get(c,'Value');
    if assembly_problem_automatic
        assembly_problem
    end
end

if strcmp(name,'direct_dynamics_problem_automatic')
    direct_dynamics_problem_automatic=get(c,'Value');
    if direct_dynamics_problem_automatic
        direct_dynamics_problem
    end
end

if strcmp(name,'updateDraws_automatic')
    updateDraws_automatic=get(c,'Value');
end

if updateDraws_automatic
updateDraws;
end
end