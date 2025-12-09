
function fvc=square_patch(X,Y,Z)

   
fvc.vertices=[X',Y',Z'];
fvc.faces=[1:length(X)];
fvc.facevertexcdata=1;

