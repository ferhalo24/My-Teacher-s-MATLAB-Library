function newPhiInit(phiInit,optimize)
global PhiInit
global n_PhiInit
global simplify_expressions

if nargin==1
    optimize=simplify_expressions;
end

if optimize && (size(phiInit,1)>0)
    phiInit=simplify(phiInit);
end

PhiInit=[PhiInit;
    phiInit];
n_PhiInit=size(PhiInit,1);

end