function SliderValueChanged(sld,event)
global updateDraws_automatic assembly_problem_automatic direct_dynamics_problem_automatic
global control
setValue(sld.UserData(1),sld.Value);
if control.assembly_problem_automatic
    assembly_problem
    if control.direct_dynamics_problem_automatic
        direct_dynamics_problem
    end
end
if control.update_draws_automatic
updateDraws;
end
end