classdef Interface < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        InterfaceUIFigure             matlab.ui.Figure
        SolvePanel                    matlab.ui.container.Panel
        PerturbationProblemButton     matlab.ui.control.Button
        EigenProblemButton            matlab.ui.control.Button
        EquilibriumProblemButton      matlab.ui.control.Button
        DirectDynamicsProblemButton   matlab.ui.control.Button
        InitialAssemblyProblemButton  matlab.ui.control.Button
        AssemblyProblemButton         matlab.ui.control.Button
        DynamicSolverDropDown         matlab.ui.control.DropDown
        DynamicSolverDropDownLabel    matlab.ui.control.Label
        OnsliderchangesolvePanel      matlab.ui.container.Panel
        DirectDynamicProblemCheckBox  matlab.ui.control.CheckBox
        AssemblyProblemCheckBox       matlab.ui.control.CheckBox
    end
    
    properties (Access = public)
        VariableSliders               matlab.ui.control.Slider % Description
        VariableSlidersLabels         matlab.ui.control.Label
    end

    methods (Access = public)

        function results = updateFcn(app)
            global control
            app.OnsliderchangesolvePanel.Enable='on';
            if control.assembly_problem_exported==true
                app.AssemblyProblemCheckBox.Enable='on';
                app.AssemblyProblemButton.Enable='on';
            else
                app.AssemblyProblemCheckBox.Enable='off';
                app.AssemblyProblemButton.Enable='off';
            end
            if control.assembly_problem_automatic==true
                app.AssemblyProblemCheckBox.Value=1;
            else
                app.AssemblyProblemCheckBox.Value=0;
            end
            if control.initial_assembly_problem_exported==true
                app.InitialAssemblyProblemButton.Enable='on';
                app.InitialAssemblyProblemButton.Enable='on';
            else
                app.InitialAssemblyProblemButton.Enable='off';
                app.InitialAssemblyProblemButton.Enable='off';
            end
            
            if control.assembly_problem_automatic==true
                app.AssemblyProblemCheckBox.Value=1;
            else
                app.AssemblyProblemCheckBox.Value=0;
            end
            
            if control.direct_dynamics_problem_NE_exported || control.direct_dynamics_problem_VP_exported
                app.DirectDynamicProblemCheckBox.Enable='on';
                app.DirectDynamicsProblemButton.Enable='on';
            else
                app.DirectDynamicProblemCheckBox.Enable='off';
                app.DirectDynamicsProblemButton.Enable='off';
            end
            
            if control.direct_dynamics_problem_automatic==true
                app.DirectDynamicProblemCheckBox.Value=1;
            else
                app.DirectDynamicProblemCheckBox.Value=0;
            end
            
            if control.equilibrium_problem_NE_exported || control.equilibrium_problem_VP_exported
                app.EquilibriumProblemButton.Enable='on';
            else
                app.EquilibriumProblemButton.Enable='off';
            end
            if control.eigen_problem_NE_exported || control.eigen_problem_VP_exported
                app.EigenProblemButton.Enable='on';
            else
                app.EigenProblemButton.Enable='off';
            end
            if control.perturbation_problem_NE_exported || control.perturbation_problem_VP_exported
                app.PerturbationProblemButton.Enable='on';
            else
                app.PerturbationProblemButton.Enable='off';
            end
            
        end
    end
    
    methods (Access = public)
        
        function results = newVariableSlider(app,name,variable_limits)
            n_VariableSliders=length(app.VariableSliders)+1;
            
            app.VariableSlidersLabels(n_VariableSliders) = uilabel(app.InterfaceUIFigure);
            app.VariableSlidersLabels(n_VariableSliders).Interpreter = 'latex';
            app.VariableSlidersLabels(n_VariableSliders).HorizontalAlignment = 'right';           
            app.VariableSlidersLabels(n_VariableSliders).Text = name;
            
            if n_VariableSliders==1
            app.VariableSlidersLabels(n_VariableSliders).Position = [488,392,6*length(app.VariableSlidersLabels(n_VariableSliders).Text),22];
            else
            app.VariableSlidersLabels(n_VariableSliders).Position = app.VariableSlidersLabels(n_VariableSliders-1).Position;
            app.VariableSlidersLabels(n_VariableSliders).Position (2)=app.VariableSlidersLabels(n_VariableSliders).Position (2)+40;
            end
            
            
            app.VariableSliders(n_VariableSliders)=uislider(app.InterfaceUIFigure,'ValueChangedFcn',@SliderValueChanged);
            if n_VariableSliders==1
            app.VariableSliders(n_VariableSliders).Position = [389,400,83,7];
            else
            app.VariableSliders(n_VariableSliders).Position = app.VariableSliders(n_VariableSliders-1).Position;
            app.VariableSliders(n_VariableSliders).Position (2)=app.VariableSliders(n_VariableSliders).Position (2)+40;
            end
            app.VariableSliders(n_VariableSliders).Limits = variable_limits;
            app.VariableSliders(n_VariableSliders).MajorTicks = [variable_limits(1) variable_limits(2)];
            app.VariableSliders(n_VariableSliders).MajorTickLabels = {num2str(variable_limits(1)), num2str(variable_limits(2))};
            app.VariableSliders(n_VariableSliders).MinorTicks = [];
        end
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.updateFcn();
        end

        % Value changed function: DynamicSolverDropDown
        function DynamicSolverDropDownValueChanged(app, event)
            global control
            control.dyn_equations_type=app.DynamicSolverDropDown.Value;
        end

        % Callback function
        function DynamicSolverDropDownOpening(app, event)

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create InterfaceUIFigure and hide until all components are created
            app.InterfaceUIFigure = uifigure('Visible', 'off');
            app.InterfaceUIFigure.Position = [100 100 640 480];
            app.InterfaceUIFigure.Name = 'Interface';

            % Create OnsliderchangesolvePanel
            app.OnsliderchangesolvePanel = uipanel(app.InterfaceUIFigure);
            app.OnsliderchangesolvePanel.Title = 'On slider change solve';
            app.OnsliderchangesolvePanel.Position = [26 394 170 66];

            % Create AssemblyProblemCheckBox
            app.AssemblyProblemCheckBox = uicheckbox(app.OnsliderchangesolvePanel);
            app.AssemblyProblemCheckBox.Text = 'Assembly Problem';
            app.AssemblyProblemCheckBox.Position = [1 22 122 22];

            % Create DirectDynamicProblemCheckBox
            app.DirectDynamicProblemCheckBox = uicheckbox(app.OnsliderchangesolvePanel);
            app.DirectDynamicProblemCheckBox.Text = 'Direct Dynamic Problem';
            app.DirectDynamicProblemCheckBox.Position = [1 1 151 22];

            % Create DynamicSolverDropDownLabel
            app.DynamicSolverDropDownLabel = uilabel(app.InterfaceUIFigure);
            app.DynamicSolverDropDownLabel.HorizontalAlignment = 'right';
            app.DynamicSolverDropDownLabel.Position = [28 350 90 22];
            app.DynamicSolverDropDownLabel.Text = 'Dynamic Solver';

            % Create DynamicSolverDropDown
            app.DynamicSolverDropDown = uidropdown(app.InterfaceUIFigure);
            app.DynamicSolverDropDown.Items = {'Newton-Euler', 'Virtual_Power'};
            app.DynamicSolverDropDown.ValueChangedFcn = createCallbackFcn(app, @DynamicSolverDropDownValueChanged, true);
            app.DynamicSolverDropDown.Position = [27 329 169 22];
            app.DynamicSolverDropDown.Value = 'Newton-Euler';

            % Create SolvePanel
            app.SolvePanel = uipanel(app.InterfaceUIFigure);
            app.SolvePanel.Title = 'Solve';
            app.SolvePanel.Position = [26 154 170 154];

            % Create AssemblyProblemButton
            app.AssemblyProblemButton = uibutton(app.SolvePanel, 'push');
            app.AssemblyProblemButton.Position = [1 112 116 22];
            app.AssemblyProblemButton.Text = 'Assembly Problem';

            % Create InitialAssemblyProblemButton
            app.InitialAssemblyProblemButton = uibutton(app.SolvePanel, 'push');
            app.InitialAssemblyProblemButton.Position = [1 91 147 22];
            app.InitialAssemblyProblemButton.Text = 'Initial Assembly Problem';

            % Create DirectDynamicsProblemButton
            app.DirectDynamicsProblemButton = uibutton(app.SolvePanel, 'push');
            app.DirectDynamicsProblemButton.Position = [1 70 151 22];
            app.DirectDynamicsProblemButton.Text = 'Direct Dynamics Problem';

            % Create EquilibriumProblemButton
            app.EquilibriumProblemButton = uibutton(app.SolvePanel, 'push');
            app.EquilibriumProblemButton.Position = [1 49 123 22];
            app.EquilibriumProblemButton.Text = 'Equilibrium Problem';

            % Create EigenProblemButton
            app.EigenProblemButton = uibutton(app.SolvePanel, 'push');
            app.EigenProblemButton.Position = [1 28 100 22];
            app.EigenProblemButton.Text = 'Eigen Problem';

            % Create PerturbationProblemButton
            app.PerturbationProblemButton = uibutton(app.SolvePanel, 'push');
            app.PerturbationProblemButton.Position = [1 7 129 22];
            app.PerturbationProblemButton.Text = 'Perturbation Problem';

            % Show the figure after all components are created
            app.InterfaceUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Interface

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.InterfaceUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.InterfaceUIFigure)
        end
    end
end

