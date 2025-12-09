function out_fvc=rotate_translate_patch(in_fvc, tras, Rot)
  out_fvc=in_fvc;
  if size(tras,1)==0
      out_fvc.vertices=in_fvc.vertices*Rot;
  else
      out_fvc.vertices=repmat(tras',size(in_fvc.vertices,1),1)+in_fvc.vertices*Rot;
  end