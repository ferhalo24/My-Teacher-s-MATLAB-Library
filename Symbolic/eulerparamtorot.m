function R=eulerparamtorot(p)
e0=p(1,1);
e=p(2:4,1);
e_skew= vecttoskew(e);
R = eye(3) + 2 * e0 * e_skew  +  2 * (e_skew * e_skew);
end