function omega=vectorangleparamtoomega(v,phi)
dv=timederivative(v);
dphi=timederivative(phi);
omega=dphi*v+sin(phi)*dv+(1-cos(phi))*cross(v,dv);
end