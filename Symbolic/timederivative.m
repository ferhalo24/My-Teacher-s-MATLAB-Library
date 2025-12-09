function dM=timederivative(M)

global t  q  dq  ddq

dM=zeros(size(M));

for i=1:size(q,1)
 dM = dM+diff(M,q(i))*dq(i);
end

for i=1:size(dq,1)
 dM = dM+diff(M,dq(i))*ddq(i);
end

dM=dM+diff(M,t);

end