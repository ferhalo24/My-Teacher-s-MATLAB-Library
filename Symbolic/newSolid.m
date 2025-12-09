function Solid=newSolid(varargin)

global Bases
global BasesNames %We put frame names in BasesNames to get Frame Base
global Points
global PointsNames
global Frames
global FramesNames
global Solids n_Solids
global SolidsNames NamesSolids

global param
global param_value

global stl_dir

if (nargin==6) || (nargin==5)

    new_solid_name=varargin{1};
    frame_name=varargin{2};
    m_Sol=varargin{3};
    OSolGsol=varargin{4};
    I_Sol=varargin{5};

    if not(isKey(FramesNames,frame_name))
        error('Frame %s not defined',frame_name);
    elseif isKey(SolidsNames,new_solid_name)
        error('Solid %s already defined', new_solid_name);
    else
        if FramesNames(frame_name)==0
            base_name='xyz';
            point_name='O';
        else
            base_name=Frames(FramesNames(frame_name)).Base;
            point_name= Frames(FramesNames(frame_name)).Point;
        end

        BasesNames(new_solid_name)=BasesNames(base_name);

        PointsNames(new_solid_name)=PointsNames(point_name);
        FramesNames(new_solid_name)=FramesNames(frame_name);

        if nargin==6
            stl_file_name=varargin{6};
            stl_file_name=fullfile(stl_dir,stl_file_name);
            if exist(stl_file_name, 'file') == 2
                fv = stlRead(stl_file_name);
            else
                error('STL file %s does not exist in the specified path or current directory', stl_file_name);
            end
            Solids(n_Solids).fv = fv;
        end

        n_Solids=length(Solids)+1;
        Solids(n_Solids).Frame = frame_name;

        SolidsNames(new_solid_name)=n_Solids;

        Solids(n_Solids).mass=m_Sol;
        Solids(n_Solids).first_mass_moment=m_Sol*OSolGsol;
        Solids(n_Solids).inertia_tensor=I_Sol;
        Solids(n_Solids).inertia_tensor_point=PointsNames(frame_name);

        if m_Sol ~= sym(0)
            Solids(n_Solids).G=['G_',new_solid_name];
            newPoint(point_name,Solids(n_Solids).G,Solids(n_Solids).first_mass_moment*(1/m_Sol));
        else
            warning('Solid %s mass is cero and therefore inertia center is undefined', Solids(n_Solids).Frame);
        end
        Solids(n_Solids).isExt=false;
        Solids(n_Solids).IActions=[];
        Solids(n_Solids).CActions=[];
        Solids(n_Solids).CReactions=[];
        Solids(n_Solids).Actions=[];
        Solids(n_Solids).Reactions=[];
        Solid=Solids(n_Solids);
        NamesSolids(n_Solids).Solid_name=new_solid_name;
        BasesNames(new_solid_name)=BasesNames(base_name);
        PointsNames(new_solid_name)=PointsNames(point_name);
        FramesNames(new_solid_name)=FramesNames(frame_name);
    end
elseif nargin==4

    new_solid_name=varargin{1};
    frame_name=varargin{2};
    if ischar(varargin{3})
        stl_file_name=varargin{3};
        stl_constructor=[];
    else
        stl_constructor=varargin{3};
        stl_file_name=varargin{3}.stl_file_name;
    end
    rho=varargin{4};

    if not(isKey(FramesNames,frame_name))
        error('Frame %s not defined',frame_name);
    elseif isKey(SolidsNames,new_solid_name)
        error('Solid %s already defined', new_solid_name);
    else
        if FramesNames(frame_name)==0
            base_name='xyz';
            point_name='O';
        else
            base_name=Frames(FramesNames(frame_name)).Base;
            point_name= Frames(FramesNames(frame_name)).Point;
        end

        BasesNames(new_solid_name)=BasesNames(base_name);

        PointsNames(new_solid_name)=PointsNames(point_name);
        FramesNames(new_solid_name)=FramesNames(frame_name);

        stl_file_name=fullfile(stl_dir,stl_file_name);
        if exist(stl_file_name, 'file') == 2
            fv = stlRead(stl_file_name);
        else
            error('STL file %s does not exist in the specified path or current directory', stl_file_name);
        end

        [mass_s,first_mass_moment_s,inertia_tensor_s,mass_n,first_mass_moment_n,inertia_tensor_n,param_s,param_n]=round_inert_prop(fv,rho,new_solid_name);
        for i=1:length(param_s)
            newParam(char(param_s(i)),param_n(i));
        end

        n_Solids=length(Solids)+1;
        Solids(n_Solids).Frame = frame_name;
        Solids(n_Solids).fv = fv;
        Solids(n_Solids).stl_constructor=stl_constructor;
        Solids(n_Solids).rho=rho;
        SolidsNames(new_solid_name)=n_Solids;

        Solids(n_Solids).mass=mass_s;
        Solids(n_Solids).first_mass_moment=Vector3D(first_mass_moment_s,base_name);
        Solids(n_Solids).inertia_tensor=Vector3D(inertia_tensor_s,base_name);
        Solids(n_Solids).inertia_tensor_point=PointsNames(frame_name);
        if mass_s ~= sym(0)
            Solids(n_Solids).G=['G_',new_solid_name];
            newPoint(point_name,Solids(n_Solids).G,Solids(n_Solids).first_mass_moment*(1/mass_s));
        else
            warning('Solid %s mass is cero and therefore inertia center is undefined', Solids(n_Solids).Frame);
        end
        Solids(n_Solids).isExt=false;
        Solids(n_Solids).IActions=[];
        Solids(n_Solids).CActions=[];
        Solids(n_Solids).CReactions=[];
        Solids(n_Solids).Actions=[];
        Solids(n_Solids).Reactions=[];
        Solid=Solids(n_Solids);
        NamesSolids(n_Solids).Solid_name=new_solid_name;
        BasesNames(new_solid_name)=BasesNames(base_name);
        PointsNames(new_solid_name)=PointsNames(point_name);
        FramesNames(new_solid_name)=FramesNames(frame_name);
    end
end
