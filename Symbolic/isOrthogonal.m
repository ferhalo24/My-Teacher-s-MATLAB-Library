function ans=isOrthogonal(R)
        epsilon=100*eps;
        if abs(norm(R(:,1))-1)>epsilon || abs(norm(R(:,2))-1)>epsilon || abs(norm(R(:,3))-1)>epsilon || ...
                norm(dot(R(:,2),R(:,3)))> epsilon ||  norm(dot(R(:,3),R(:,1)))> epsilon || norm(dot(R(:,1),R(:,2)))> epsilon
            ans=false;
        else
            ans=true;
        end
    end