function updateSolid(n_Solid)

global Solids
global updateDraws_automatic

global stl_dir

if not(isempty(Solids(n_Solid).stl_constructor))
    reconstruct(Solids(n_Solid).stl_constructor);
    fv = stlRead(Solids(n_Solid).stl_constructor.stl_file_name);

    Solids(n_Solid).fv = fv;

    Solids(n_Solid).draw_handle.updatePatchs(Solids(n_Solid).fv);

    if Solids(n_Solid).isExt==0
        updateDraws_automatic_prev=updateDraws_automatic;
        updateDraws_automatic=false;
        [mass_n,center_of_mass_n,inertia_tensor_n]=inert_prop(fv,Solids(n_Solid).rho);
        if Solids(n_Solid).mass~= sym(0)
            setValue(Solids(n_Solid).mass,mass_n);
        end
        for i=1:3
            if Solids(n_Solid).first_mass_moment.Value(i)~= sym(0)
                setValue(Solids(n_Solid).first_mass_moment.Value(i)/Solids(n_Solid).mass,center_of_mass_n(i));
            end
        end
        for i=1:3
            for j=i:3
                if Solids(n_Solid).inertia_tensor.Value(i,j)~= sym(0)
                    setValue(Solids(n_Solid).inertia_tensor.Value(i,j),inertia_tensor_n(i,j));
                end
            end
        end
        updateDraws_automatic=updateDraws_automatic_prev;
    end

end
end
