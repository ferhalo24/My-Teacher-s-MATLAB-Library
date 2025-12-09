function df=numerical_jacobian(f,x,b) 
% https://es.mathworks.com/matlabcentral/answers/407316-how-can-i-take-the-jacobian-of-a-function
% Everybody uses other values as optimal h for numerical differentiation. Just test for your case which order of magnitude fits your needs.
% Here is a link that derives h ~ eps^(1/3) for the central difference quotient:
% https://math.stackexchange.com/questions/815113/is-there-a-general-formula-for-estimating-the-step-size-h-in-numerical-different
n=length(x); 
E=speye(n); 
e=eps^(1/3); 
for i=1:n 
 df(:,i)=(f(x+e*E(:,i),b)-f(x-e*E(:,i),b))/(2*e); % zentraler Differenzenquotient 
end 
end