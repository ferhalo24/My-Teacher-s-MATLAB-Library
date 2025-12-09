function dv=dvcylinder(w2,R,N)
h = figure;
set(h, 'Visible', 'off');
[X,Y,Z]=cylinder(1,20);
s=surf(X,Y,Z,ones(size(Z)));
peaksPatch = patch(surf2patch(s));
delete(s);
shading interp;
dv = vrnode(w2, 'DefaultViewpoint','Viewpoint');
setfield(dv,'set_bind',true);
vrpatch2ifs(peaksPatch,w2);
vrfig2 = vrfigure(w2,'Name',...
         'Virtual world containing resulting IndexedFaceSet node');
     close(h)
     