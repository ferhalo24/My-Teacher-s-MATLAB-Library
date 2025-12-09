function R=vectorangleparamtorot(v,phi)
% Would-be-unitary-vector and rotation angle arount it
I=eye(3,3);
v_skew= vecttoskew(v);

%Different versions of Rodrigues formula
%R = cos(phi) * (I - (v * v'))+ (v * v') + sin (phi) * v_skew;

%R = I + (sin (phi) *I +  (1-cos(phi)) * v_skew) * v_skew;

R = I + sin (phi)* v_skew  +  (1-cos(phi)) * (v_skew * v_skew);
end