function diff_omega=diff_eulerparamtorot(v,phi)
diff_omega=eye(3,3)+phi*vecttoskew(v);