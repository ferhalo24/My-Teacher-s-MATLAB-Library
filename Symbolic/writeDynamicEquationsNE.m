for k=1:n_Solids
    if not(Solids(k).isExt)
        sum_wrenches=Vector6D(Vector3D([0,0,0]',[]),Vector3D([0,0,0]',[]),[]);
        for j=1:length(Solids(k).IActions)
            sum_wrenches=sum_wrenches+Solids(k).IActions(j);
        end
        for j=1:length(Solids(k).CActions)
            sum_wrenches=sum_wrenches+Solids(k).CActions(j);
        end
        for j=1:length(Solids(k).CReactions)
            sum_wrenches=sum_wrenches-Solids(k).CReactions(j);
        end
        for j=1:length(Solids(k).Actions)
            sum_wrenches=sum_wrenches+Solids(k).Actions(j);
        end
        for j=1:length(Solids(k).Reactions)
            sum_wrenches=sum_wrenches-Solids(k).Reactions(j);
        end
        newDyn_eq_NE([sum_wrenches]);
    end
end
Dyn_eq_NE=-Dyn_eq_NE; %So mass matrix is positive definite