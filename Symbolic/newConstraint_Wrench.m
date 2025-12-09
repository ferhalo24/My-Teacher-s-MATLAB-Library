function Wrench=newConstraint_Wrench(t,r,point_name,base_name,action_solid_name,reaction_solid_name);

global Solids
global SolidsNames PointsNames  BasesNames
global FramesNames

if not(isKey(SolidsNames, action_solid_name))
    error(['Action receiving solid ''',action_solid_name,''' does not exists']);
end

if nargin==5
    reaction_solid_name='abs';
end

if not(isKey(SolidsNames, reaction_solid_name))
    error(['Reaction receiving Solid''',reaction_solid_name,''' does not exists' ]);
end


if 0 == isKey(PointsNames, point_name)
    error(['Point ''',point_name,''' does not exists']);
end

if 0 == isKey(BasesNames, base_name)
    error(['Base ''',base_name,''' does not exists']);
end

for i=1:3
    if not(t(i)==0)
        F(i,1)=newEpsilon(strcat('f__',reaction_solid_name,action_solid_name,'_',int2str(i)),0);
    else
        F(i,1)=sym(0);
    end
end
for i=1:3
    if not(r(i)==0)
        M(i,1)=newEpsilon(strcat('m__',reaction_solid_name,action_solid_name,'_',point_name,'_',int2str(i)),0);
    else
        M(i,1)=sym(0);
    end
end

F3D=Vector3D(F,base_name);
M3D=Vector3D(M,base_name);

Wrench=Vector6D(F3D , M3D, point_name);
if Solids(SolidsNames(action_solid_name)).isExt==false
    if not(isfield(Solids,'CActions'))
        n_CActions=0;
    else
    n_CActions=length(Solids(SolidsNames(action_solid_name)).CActions);
    end
    if n_CActions==0
        Solids(SolidsNames(action_solid_name)).CActions=Wrench;
    else
        Solids(SolidsNames(action_solid_name)).CActions(n_CActions+1)=Wrench;
    end
end
if Solids(SolidsNames(reaction_solid_name)).isExt==false
     if not(isfield(Solids,'CReactions'))
        n_CReactions=0;
    else
    n_CReactions=length(Solids(SolidsNames(reaction_solid_name)).CReactions);
    end
    if n_CReactions==0
        Solids(SolidsNames(reaction_solid_name)).CReactions=Wrench;
    else
        Solids(SolidsNames(reaction_solid_name)).CReactions(n_CReactions+1)=Wrench;
    end
end

end