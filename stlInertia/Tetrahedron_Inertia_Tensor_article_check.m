
% //Reference: F. Tonon. Explicit Exact Formulas for the 3-D Tetrahedron Inertia Tensor
% //in Terms of its Vertex Coordinates. Journal of Mathematics and Statistics 1 (1): 8-11, 2004
% //http://www.scipub.org/fulltext/jms2/jms2118-11.pdf

v1=[8.33220, -11.86875, 0.93355];
v2=[0.75523 ,5.00000, 16.37072];
v3=[52.61236, 5.00000, -5.38580];
v4=[2.00000, 5.00000, 3.00000];
vg=[15.92492, 0.78281, 3.72962]; 

v1=v1-vg;
v2=v2-vg;
v3=v3-vg;
v4=v4-vg;

x1=v1(1);y1=v1(2);z1=v1(3);
x2=v2(1);y2=v2(2);z2=v2(3);
x3=v3(1);y3=v3(2);z3=v3(3);
x4=v4(1);y4=v4(2);z4=v4(3);

%volume * 6
vol_dot_6=(x2-x1)*((y3-y1)*(z4-z1)-(z3-z1)*(y4-y1))-(x3-x1)*((y2-y1)*(z4-z1)-(z2-z1)*(y4-y1))+(x4-x1)*((y2-y1)*(z3-z1)-(z2-z1)*(y3-y1));

%Centroid
((x1+x2+x3+x4)/4,(y1+y2+y3+y4)/4,(z1+z2+z3+z4)/4)

a = vol_dot_6* (...
y1*y1 + y1*y2 + y2*y2 + y1*y3 + y2*y3 + y3*y3 + y1*y4 + y2*y4 + y3*y4 + y4*y4 +...
z1*z1 + z1*z2 + z2*z2 + z1*z3 + z2*z3 + z3*z3 + z1*z4 + z2*z4 + z3*z4 + z4*z4...
 ) / 60.0;

 b = vol_dot_6* (...
x1*x1 + x1*x2 + x2*x2 + x1*x3 + x2*x3 + x3*x3 + x1*x4 + x2*x4 + x3*x4 + x4*x4 +...
z1*z1 + z1*z2 + z2*z2 + z1*z3 + z2*z3 + z3*z3 + z1*z4 + z2*z4 + z3*z4 + z4*z4...
 ) / 60.0;

 c = vol_dot_6* (...
x1*x1 + x1*x2 + x2*x2 + x1*x3 + x2*x3 + x3*x3 + x1*x4 + x2*x4 + x3*x4 + x4*x4 +...
y1*y1 + y1*y2 + y2*y2 + y1*y3 + y2*y3 + y3*y3 + y1*y4 + y2*y4 + y3*y4 + y4*y4...
 ) / 60.0;

ap= vol_dot_6* (2.0 * y1*z1 + y2*z1 + y3*z1 + y4*z1 + y1*z2 +...
2.0 * y2*z2 + y3*z2 + y4*z2 + y1*z3 + y2*z3 + 2.0 * y3*z3 +...
y4*z3 + y1*z4 + y2*z4 + y3*z4 + 2.0 * y4*z4...
) / 120.0;

bp = vol_dot_6* (2.0 * x1*z1 + x2*z1 + x3*z1 + x4*z1 + x1*z2 +...
2.0 * x2*z2 + x3*z2 + x4*z2 + x1*z3 + x2*z3 + 2.0 * x3*z3 +...
x4*z3 + x1*z4 + x2*z4 + x3*z4 + 2.0 * x4*z4...
) / 120.0;

cp = vol_dot_6* (2.0 * x1*y1 + x2*y1 + x3*y1 + x4*y1 + x1*y2 +...
2.0 * x2*y2 + x3*y2 + x4*y2 + x1*y3 + x2*y3 + 2.0 * x3*y3 +...
x4*y3 + x1*y4 + x2*y4 + x3*y4 + 2.0 * x4*y4...
) / 120.0;

a,b,c,ap,bp,cp

a2=43520.33257,b2=194711.28938,c2=191168.76173,ap2=4417.66150,bp2=-46343.16662,cp2=11996.20119


a/a2,b/b2,c/c2,ap/ap2,bp/bp2,cp/cp2

