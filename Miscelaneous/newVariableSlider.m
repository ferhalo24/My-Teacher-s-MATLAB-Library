function newVariableSlider(name,variable_limits)
global VariableSlider n_VariableSlider n_OptionButton
n_VariableSlider=n_VariableSlider+1;;
VariableSlider.width(n_VariableSlider)=120;
VariableSlider.slider(n_VariableSlider) = uicontrol('Style','slider','Position',[20,(n_VariableSlider+n_OptionButton)*20,VariableSlider.width(n_VariableSlider),20]);
VariableSlider.slider(n_VariableSlider).String=name;
VariableSlider.text(n_VariableSlider) = uicontrol('Style','text','String',name,'Position',[VariableSlider.width(n_VariableSlider)+20,(n_VariableSlider+n_OptionButton)*20,50,20]);
VariableSlider.slider(n_VariableSlider).SliderStep=[0.01,0.1];
VariableSlider.slider(n_VariableSlider).Min=variable_limits(1);
VariableSlider.slider(n_VariableSlider).Max=variable_limits(2);
VariableSlider.slider(n_VariableSlider).Value=getValue(name);
VariableSlider.slider(n_VariableSlider).Callback=@su;
end


function a= su(c,event)
global updateDraws_automatic assembly_problem_automatic direct_dynamics_problem_automatic
a=setValue(get(c,'String'),get(c,'Value'));
if assembly_problem_automatic
    assembly_problem
    if direct_dynamics_problem_automatic
        direct_dynamics_problem
    end
end
if updateDraws_automatic
updateDraws;
end
end