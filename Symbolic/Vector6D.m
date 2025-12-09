classdef (InferiorClasses = {?sym}) Vector6D
   properties
      FW
      MV
      Point
   end
   methods
       function obj = Vector6D(force_vector,moment_vector,point)
           global Points
           global PointsNames
           global Solids
           global SolidsNames
           global Frames
           global FramesNames
           if nargin ==3
               if ischar(point)
                   obj.Point = PointsNames(point);
               elseif isa(point,'double') && isscalar(point) && point >= 0 && point <= length(Points);
                   obj.Point = point;
               elseif isempty(point)
                   obj.Point=point;
               else
                   error('3rd parameter must be a string or a integer number 0:num_Points')
               end
               obj.FW=force_vector;
               obj.MV=moment_vector;
           elseif nargin==0
               obj.FW=Vector3D();
               obj.MV=Vector3D();
           end
       end
       %-------------------------------------------
       function r = inBase(o1,base)
           global BasesNames
           global Bases
           if isa(base,'double') && isscalar(base) && base >= 0 && base <= length(Bases)
               base_number=base;
           else
               base_number=BasesNames(base);
           end
           r = Vector6D();
           [common_base_,One_base_base1,One_base_base2]=commonbase(o1.FW.Base,base_number);
           aux=One_base_base2'*One_base_base1;
           if isequal(size(o1.FW.Value),[3,1])
               r.FW.Value = aux*o1.FW.Value;
           elseif isequal(size(o1.FW.Value),[3,3])
               r.FW.Value = aux*(o1.FW.Value*aux');
           end
           r.FW.Base = base_number;
           [common_base_,One_base_base1,One_base_base2]=commonbase(o1.MV.Base,base_number);
           aux=One_base_base2'*One_base_base1;
           if isequal(size(o1.MV.Value),[3,1])
               r.MV.Value = aux*o1.MV.Value;
           elseif isequal(size(o1.MV.Value),[3,3])
               r.MV.Value = aux*(o1.MV.Value*aux');
           end
           r.MV.Base = base_number;
           r.Point=o1.Point;
       end
       %-------------------------------------------
       %-------------------------------------------
       function r = plus(o1,o2)
           r=Vector6D();
           
           r.FW=o1.FW+o2.FW;
           [commonpoint_,P_commonpoint_point1,P_commonpoint_point2]=commonpoint(o1.Point,o2.Point);
           r.Point=commonpoint_;
           r.MV = (o1.MV+cross(P_commonpoint_point1,o1.FW))+(o2.MV+cross(P_commonpoint_point2,o2.FW));
       end
      %-------------------------------------------
      function r = uminus(o1)
      r=Vector6D();
      
      r.FW = -o1.FW;
      r.MV= -o1.MV;
      
      r.Point = o1.Point;
      end
      %-------------------------------------------
      function r = minus(o1,o2)
          r=plus(o1,-o2);
      end
      %-------------------------------------------
      function r = dot(o1,o2)
          [commonpoint_,P_commonpoint_point1,P_commonpoint_point2]=commonpoint(o1.Point,o2.Point);
          %Moment translation to commonpoint_
          MV_o1=o1.MV+cross(Pos(commonpoint_,o1.Point),o1.FW);
          %Velocity translation to commonpoint_
          MV_o2=o2.MV+cross(Pos(commonpoint_,o2.Point),o2.FW);
          
          r=dot(o1.FW,MV_o2)+dot(MV_o1,o2.FW);
%           P_commonpoint_point1, Pos(commonpoint_,o1.Point)
%           P_commonpoint_point2, Pos(commonpoint_,o2.Point)
      end
      %-------------------------------------------
      function dv=diff(v,dqi)
          dv=Vector6D(diff(v.FW,dqi),diff(v.MV,dqi),v.Point);
      end
      %-------------------------------------------
      function simplified_v=simplify(v)

          simplified_v=Vector6D(simplify(v.FW),simplify(v.MV),v.Point);
          
      end
      %-------------------------------------------
      function r = inPoint(obj,Point)
          global PointsNames
          global Points
          if isa(Point,'double') && isscalar(Point) && Point >= 0 && Point <= length(Points)
              point_number=Point;
          else
              point_number=PointsNames(Point);
          end
          r=obj;
          r.MV=r.MV+cross(Pos(point_number,r.Point),r.FW);
          r.Point=point_number;
      end
      %-------------------------------------------
      function disp(obj)
          global NamesPoints
          disp(obj.FW);
          disp(obj.MV);
          if obj.Point==0
              disp(['Vector6D at point:','''','O','''']);
          else
              disp(['Vector6D at point:','''',char(NamesPoints(obj.Point).Point_name),'''']);
          end
      end
      %-------------------------------------------
        function display(obj,b)
            disp([b,' =']);
            disp(obj);
        end
      %-------------------------------------------
      function out_array=vertcat(varargin)
         out_array=[];
            for i=1:nargin
                if isa(varargin{i},'double') ||  isa(varargin{i},'sym')
                    out_array=[out_array;varargin{i}];
                else
                    out_array=[out_array;[varargin{i}.FW.Value;varargin{i}.MV.Value]];
                end
            end
      end
      %-------------------------------------------
      function out_array=horzcat(varargin)
          out_array=[];
            for i=1:nargin
                if isa(varargin{i},'double') ||  isa(varargin{i},'sym')
                    out_array=[out_array,varargin{i}];
                else
                    out_array=[out_array,[varargin{i}.FW.Value;varargin{i}.MV.Value]];
                end
            end
      end
      %-------------------------------------------
   end
end
