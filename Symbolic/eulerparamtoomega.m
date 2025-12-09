function omega=eulerparamtoomega(p)
e0=p(1,1);
e=p(2:4,1);
dp=timederivative(p);
G=[-e,vecttoskew(e)+e0*eye(3)];
omega=2*G*dp;
end