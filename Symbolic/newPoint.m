function newPoint(prev_point_name,new_point_name,pos_vector)

global Points
global PointsNames NamesPoints
global dq OCdq

if isKey(PointsNames,prev_point_name)

    if not(isKey(PointsNames,new_point_name))

        if isa(pos_vector,'Vector3D')

            n_Points=length(Points)+1;
            Points(n_Points).prev_new=pos_vector;

            prev_new_vel=timederivative(pos_vector,pos_vector.Base);
            Points(n_Points).prev_new_vel=prev_new_vel;

            prev_new_OCvel=null(jacobian(prev_new_vel.Value,dq)');
            if isequal(size(prev_new_OCvel),[1,0])
                prev_new_OCvel=sym(zeros(3,0));
            end
            subset_OCvel=sym(zeros(0,1));
            for i=1:rank(prev_new_OCvel)
                subset_OCvel=[subset_OCvel;newOCvel()];
            end

            prev_new_OCvel=Vector3D(prev_new_OCvel*subset_OCvel,prev_new_vel.Base);
            Points(n_Points).prev_new_OCvel=prev_new_OCvel;
            Points(n_Points).prev=PointsNames(prev_point_name);
            PointsNames(new_point_name)=n_Points;
            NamesPoints(n_Points).Point_name=new_point_name;

        else
            error('"pos_vector" must be of type "Vector3D"')
        end

    else
        error('["new" point, ',new_point_name,' alerady defined')
    end

else
    error('"prev" point not defined')
end