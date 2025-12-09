function omega_xyz_123__xyz=rotmatrixtoomega(One_xyz_123)
 global simplify_omega
 tildeOm_xyz_123__123=timederivative(One_xyz_123)*One_xyz_123';
 if simplify_omega
 omega_xyz_123__xyz=simplify(skewtovect(tildeOm_xyz_123__123));
 else
 omega_xyz_123__xyz=skewtovect(tildeOm_xyz_123__123);
 end
end
