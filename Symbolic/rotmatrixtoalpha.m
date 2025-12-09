function alpha_xyz_123=rotmatrixtoalpha(One_xyz_123)
%just for simple rotations

alpha_xyz_123=timederivative(rotmatrixtoomega(One_xyz_123));%+cross(One_xyz_123,One_xyz_123) that is 0
alpha_xyz_123=simplify(alpha_xyz_123);
