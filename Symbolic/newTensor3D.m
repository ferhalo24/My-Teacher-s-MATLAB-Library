function out=newTensor3D(varargin)
if size(varargin,2)==2
out=Vector3D(varargin{1},varargin{2});
elseif size(varargin,2)==3
    out=Vector3D(varargin{1},varargin{2},varargin{3});
end
end