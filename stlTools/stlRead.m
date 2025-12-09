function varargout = stlRead(fileName)
%STLREAD reads any STL file not depending on its format
%V are the vertices
%F are the faces
%N are the normals
%NAME is the name of the STL object (NOT the name of the STL file)

format = stlGetFormat(fileName);
if strcmp(format,'ascii')
  [v,f,n,name] = stlReadAscii(fileName);
elseif strcmp(format,'binary')
  [v,f,n,name] = stlReadBinary(fileName);
end
if size(f,1)==0
    error('Number of faces in STL object is 0.\nNumber in vertexes of STL object is %d.\nProbably %s is an invalid STL file.',size(v,1),fileName)
end

varargout = cell(1,nargout);
    switch nargout        
        case 2
            varargout{1} = v;
            varargout{2} = f;
        case 3
            varargout{1} = v;
            varargout{2} = f;
            varargout{3} = n;
        case 4
            varargout{1} = v;
            varargout{2} = f;
            varargout{3} = n;
            varargout{4} = name;
        otherwise
            varargout{1} = struct('faces',f,'vertices',v);
    end