classdef Control < handle
    properties( SetObservable )
        update_draws_automatic=true;
        assembly_problem_exported=false;
        assembly_problem_automatic=false;
        assembly_problem_solved=false;
        n_Phi=0;
        n_dPhi=0;
        initial_assembly_problem_exported=false;
        initial_assembly_problem_automatic=false;
        initial_assembly_problem_solved=false;
        dyn_equations_type='Undefined';
        n_Dyn_eq_NE=0;
        direct_dynamics_problem_NE_exported=false;
        n_Dyn_eq_VP=0;
        direct_dynamics_problem_VP_exported=false;
        direct_dynamics_problem_automatic=false;
        direct_dynamics_problem_solved=false;
        equilibrium_problem_NE_exported=false;
        equilibrium_problem_VP_exported=false;
        equilibrium_problem_solved=false;
        eigen_problem_NE_exported=false;
        eigen_problem_VP_exported=false;
        eigen_problem_solved=false;
        perturbation_problem_NE_exported=false;
        perturbation_problem_VP_exported=false;
    end

    methods
        function this = Control()
            addlistener( this,'update_draws_automatic','PostSet',@this.Chg_update_draws_automatic);
            addlistener( this,'assembly_problem_automatic','PostSet',@this.Chg_assembly_problem_automatic);
            addlistener( this,'assembly_problem_exported','PostSet',@this.Chg_assembly_problem_exported);
            addlistener( this,'initial_assembly_problem_automatic','PostSet',@this.Chg_initial_assembly_problem_automatic);
            addlistener( this,'initial_assembly_problem_exported','PostSet',@this.Chg_initial_assembly_problem_exported);
            addlistener( this,'dyn_equations_type','PostSet',@this.Chg_dyn_equations_type);
            addlistener( this,'direct_dynamics_problem_automatic','PostSet',@this.Chg_direct_dynamics_problem_automatic);
            addlistener( this,'direct_dynamics_problem_NE_exported','PostSet',@this.Chg_direct_dynamics_problem_exported);
            addlistener( this,'direct_dynamics_problem_VP_exported','PostSet',@this.Chg_direct_dynamics_problem_exported);
            addlistener( this,'equilibrium_problem_NE_exported','PostSet',@this.Chg_equilibrium_problem_exported);
            addlistener( this,'equilibrium_problem_VP_exported','PostSet',@this.Chg_equilibrium_problem_exported);
            addlistener( this,'eigen_problem_NE_exported','PostSet',@this.Chg_eigen_problem_exported);
            addlistener( this,'eigen_problem_VP_exported','PostSet',@this.Chg_eigen_problem_exported);
            addlistener( this,'perturbation_problem_NE_exported','PostSet',@this.Chg_perturbation_problem_exported);
            addlistener( this,'perturbation_problem_VP_exported','PostSet',@this.Chg_perturbation_problem_exported);
        end
        
        function updateInterface( this, varargin )
            global interface
            if not(isempty(interface))
                interface.updateFcn;
            end
        end
        
        function Chg_update_draws_automatic( this, varargin )
            global updateDraws_automatic
            updateDraws_automatic=this.update_draws_automatic;
            this.updateInterface;
        end
        
        function Chg_assembly_problem_exported( this, varargin )
            if this.assembly_problem_exported==false
                this.assembly_problem_automatic=false;
            end
            this.updateInterface;
        end
        function Chg_assembly_problem_automatic( this, varargin )
            global assembly_problem_automatic
            if this.assembly_problem_exported==false
                this.assembly_problem_automatic=false;
            end
            if this.assembly_problem_automatic==false && this.direct_dynamics_problem_automatic==true
                this.direct_dynamics_problem_automatic=false;
            end
            this.updateInterface;
            assembly_problem_automatic=this.assembly_problem_automatic;
        end
        function Chg_assembly_problem_solved( this, varargin )
            if this.assembly_problem_exported==false
                this.assembly_problem_solved=false;
            end
            this.updateInterface;
        end
        
        function Chg_initial_assembly_problem_exported( this, varargin )
            if this.initial_assembly_problem_exported==false
                this.initial_assembly_problem_automatic=false;
            end
            this.updateInterface;
        end
        function Chg_initial_assembly_problem_automatic( this, varargin )
            global initial_assembly_problem_automatic
            if this.initial_assembly_problem_exported==false
                this.initial_assembly_problem_automatic=false;
            end
            this.updateInterface;
            initial_assembly_problem_automatic=this.initial_assembly_problem_automatic;
        end
        function Chg_initial_assembly_problem_solved( this, varargin )
            if this.initial_assembly_problem_exported==false
                this.initial_assembly_problem_solved=false;
            end
            this.updateInterface;
        end
        
        function Chg_dyn_equations_type( this, varargin )
            if not(strcmp(this.dyn_equations_type,'Newton-Euler') || strcmp(this.dyn_equations_type,'Virtual_Power'))
                this.dyn_equations_type='Undefined';
            end
            if this.direct_dynamics_problem_NE_exported==false && this.direct_dynamics_problem_VP_exported==false
                this.dyn_equations_type='Undefined';
            end
            this.updateInterface;
        end
        
        function Chg_direct_dynamics_problem_exported( this, varargin )
            if not(this.direct_dynamics_problem_NE_exported==true || this.direct_dynamics_problem_VP_exported==true)
                this.direct_dynamics_problem_automatic=false;
            end
            this.updateInterface;
        end
        function Chg_direct_dynamics_problem_automatic( this, varargin )
            if not(this.direct_dynamics_problem_NE_exported==true || this.direct_dynamics_problem_VP_exported==true)
                this.direct_dynamics_problem_automatic=false;
            end
            if this.assembly_problem_automatic==false && this.direct_dynamics_problem_automatic==true
                this.assembly_problem_automatic=true;
            end
            this.updateInterface;
        end
        
        function Chg_equilibrium_problem_exported( this, varargin )
            this.updateInterface;
        end
        function Chg_equilibrium_problem_automatic( this, varargin )
            this.updateInterface;
        end
        
        function Chg_eigen_problem_exported( this, varargin )
            this.updateInterface;
        end
        
        function Chg_perturbation_problem_exported( this, varargin )
            this.updateInterface;
        end
    end
end