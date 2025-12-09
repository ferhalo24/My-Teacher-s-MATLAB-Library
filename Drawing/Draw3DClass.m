classdef Draw3DClass < handle
    properties
        Frame
        colors
        patchs
        lines
        transform;
        transform_function;
        vector_z_function;
        vector_z_name;
        vector_z_scale;
    end
    methods
        %------------------------
        function delete(obj)
            %delete(obj.patchs);
            delete(obj.lines);
        end
        function obj = Draw3DClass(Frame_name,fv,lv,colors,transform_function_name,vector_z_scale,vector_z_name)
            global Bases
            global BasesNames
            global Points
            global PointsNames
            
            global FramesNames
            
            global t_value
            
            global q_value
            global dq_value
            global ddq_value
            global param_value
            global epsilon_value
            
            global ax
            
           
            obj.colors=colors;
            
            transform_function_name=strcat(Frame_name,'_transform');
            obj.transform_function=str2func(transform_function_name);
            
            n_patchs=length(fv);
            for i=1:n_patchs
                obj.transform(i) = hgtransform('Parent',ax);
                obj.patchs(i)=patch(ax,fv(i));
            end
            
            for i=1:length(lv)
                obj.transform(i) = hgtransform('Parent',ax);
                obj.lines(i)=line(ax,lv(i).vertices(:,1),lv(i).vertices(:,2),lv(i).vertices(:,3));
            end
            
            [tras,Rot]=obj.transform_function(q_value,dq_value,ddq_value,t_value,param_value);
            translate = eye(4,4);
            
            if not(isempty(tras))
                translate(1:3,4)=tras;
            end
            
            if nargin==5
                obj.vector_z_name=[];
                obj.vector_z_scale=zeros(n_patchs,3);
                for i=1:n_patchs
                    obj.vector_z_scale(i,:)=[1,1,1];
                end
            elseif nargin==6
                obj.vector_z_name=[];
                if isequal(size(vector_z_scale),[1,3])
                    obj.vector_z_scale=zeros(n_patchs,3);
                    for i=1:n_patchs
                        obj.vector_z_scale(i,:)=vector_z_scale;
                    end
                else
                    obj.vector_z_scale=vector_z_scale;
                end
            else
                obj.vector_z_name=vector_z_name;
                obj.vector_z_function=str2func(obj.vector_z_name);
                if isequal(size(vector_z_scale),[1,3])
                    obj.vector_z_scale=zeros(n_patchs,3);
                    for i=1:n_patchs
                        obj.vector_z_scale(i,:)=vector_z_scale;
                    end
                else
                    obj.vector_z_scale=vector_z_scale;
                end
            end
            if not(isempty(obj.vector_z_name))
                vector=obj.vector_z_function(q_value,dq_value,ddq_value,t_value,param_value,epsilon_value);
            end
            
            for i=1:n_patchs
                rotate = eye(4,4);
                if isempty(obj.vector_z_name)
                    rotate(1:3,1:3)=Rot'*diag(obj.vector_z_scale(i));
                else
                    if size(obj.vector_z_scale(i,:),2)==3
                        norm_vector=norm(vector);
                        if norm_vector==0
                            scale=1;
                        else
                            scale=diag(obj.vector_z_scale(i,:));
                            if obj.vector_z_scale(i,1)<0
                                scale(1,1)=-obj.vector_z_scale(1)/norm_vector;
                            end
                            if obj.vector_z_scale(i,2)<0
                                scale(2,2)=-obj.vector_z_scale(2)/norm_vector;
                            end
                        end
                    end
                    rotate(1:3,1:3)=Rot'*vector_transformation_for_drawing(vector,scale);
                end
                set(obj.transform(i),'Matrix',translate*rotate);
                set(obj.patchs(i),'Parent',obj.transform(i));
                set(obj.patchs(i),...
                    'FaceColor',obj.colors(i,1:3),...
                    'FaceAlpha',obj.colors(i,4),...
                    'EdgeColor',       'none',        ...
                    'FaceLighting',    'flat',     ...
                    'AmbientStrength', 0.15);
            end
            
            for i=1:length(lv)
                rotate = eye(4,4);
                rotate(1:3,1:3)=Rot';
                set(obj.transform(i),'Matrix',translate*rotate);
                set(obj.lines(i),'Parent',obj.transform);
                set(obj.lines(i),'Color',obj.colors(i,1:4));
            end
        end
        %------------------------
        function update(obj)
            global Bases
            global BasesNames
            global Points
            global PointsNames
            
            global FramesNames
            
            global t_value
            
            global q_value
            global dq_value
            global ddq_value
            global param_value
            global epsilon_value
            global ax
            
            
            
            [tras,Rot]=obj.transform_function(q_value,dq_value,ddq_value,t_value,param_value);
            translate = eye(4,4);
            
            if not(isempty(tras))
                translate(1:3,4)=tras;
            end
            
            if not(isempty(obj.vector_z_name))
                vector=obj.vector_z_function(q_value,dq_value,ddq_value,t_value,param_value,epsilon_value);
            end
            
            n_patchs=length(obj.patchs);

            for i=1:n_patchs
                rotate = eye(4,4);
                if isempty(obj.vector_z_name)
                    rotate(1:3,1:3)=Rot'*diag(obj.vector_z_scale(i));
                else
                    if size(obj.vector_z_scale(i,:),2)==3
                        norm_vector=norm(vector);
                        if norm_vector==0
                            scale=1;
                        else
                            scale=diag(obj.vector_z_scale(i,:));
                            if obj.vector_z_scale(i,1)<0
                                scale(1,1)=-obj.vector_z_scale(i,1)/norm_vector;
                            end
                            if obj.vector_z_scale(i,2)<0
                                scale(2,2)=-obj.vector_z_scale(i,2)/norm_vector;
                            end
                        end
                    else
                        scale=obj.vector_z_scale(i,:);
                    end
                    rotate(1:3,1:3)=Rot'*vector_transformation_for_drawing(vector,scale);
                end
                set(obj.transform(i),'Matrix',translate*rotate);
                set(obj.patchs(i),'Parent',obj.transform(i));
                set(obj.patchs(i),...
                    'FaceColor',obj.colors(i,1:3),...
                    'FaceAlpha',obj.colors(i,4),...
                    'EdgeColor','none'        );
%                     'FaceLighting',    'flat',     ...
%                     'AmbientStrength', 0.15
%                 );
            end
            
            for i=1:length(obj.lines)
                set(obj.lines(i),'Parent',obj.transform);
                set(obj.lines(i),'Color',obj.colors(1,1:4));
            end
        end
        %------------------------
        function updatePatchs(obj,fv)
            global ax

            delete(obj.patchs);
            for i=1:length(fv)
                obj.patchs(i)=patch(ax,fv(i));
            end
            update(obj);
        end
    end

end
