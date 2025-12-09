function Wrench=newWrench(Wrench,action_solid_name,reaction_solid_name)

global Solids SolidsNames
global Frames  FramesNames

if not(isa(Wrench,'Vector6D'))
    error('First paremeter is not a Vector6D');
elseif not(isequal(size(Wrench.FW.Value),[3,1])) || not(isequal(size(Wrench.MV.Value),[3,1]))
    error('Wrench.FW & Wrench.MW must have [3,1] size');
end

if Solids(SolidsNames(action_solid_name)).isExt==false
    if not(isfield(Solids,'Actions'))
        n_Actions=0;
    else
    n_Actions=length(Solids(SolidsNames(action_solid_name)).Actions);
    end
    if n_Actions==0
        Solids(SolidsNames(action_solid_name)).Actions=Wrench;
    else
        Solids(SolidsNames(action_solid_name)).Actions(n_Actions+1)=Wrench;
    end
    
    if not(isfield(Solids,'Reactions'))
        n_Reactions=0;
    else
    n_Reactions=length(Solids(SolidsNames(reaction_solid_name)).Reactions);
    end
    if n_Reactions==0
        Solids(SolidsNames(reaction_solid_name)).Reactions=Wrench;
    else
        Solids(SolidsNames(reaction_solid_name)).Reactions(n_Reactions+1)=Wrench;
    end
end
end