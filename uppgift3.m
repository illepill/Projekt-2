%---Uppgift 3---%

k = 0.001;

v0 = 400;

T = 35;

cond=0;

theta=14.22;

dtheta=0.0001;

while cond==0
    
    vx = v0*cos(theta*(pi/180));
    vy = v0*sin(theta*(pi/180));
    
    t = 0:k:T;

    N = T/k;
    
    u0 = [0 0 vx vy];
    
    u=zeros(4,N+1);
    
    u(:,1)=u0;
    
    for n=1:N
        w1 = FP2(t(n), u(:,n));
        w2 = FP2(t(n) + k/2, u(:,n) + k/2*w1);
        w3 = FP2(t(n) + k/2, u(:,n) + k/2*w2);
        w4 = FP2(t(n) + k, u(:,n) + k*w3);
        u(:,n+1) = u(:,n) + k/6*(w1+2*w2+2*w3+w4);
    end
    
    y_indices = find((u(2,:) < 0.05) & (u(2,:) > 0));
    
    cond2 = length(y_indices);
    
    if cond2 > 0
        if abs(u(1,y_indices(1))-2700) < 0.05
            disp(theta)
            cond = 1;
        end
    end
    
    theta = theta + dtheta;
    
    disp(theta);
    
    if theta > 20
        cond =1;
    end
    
end
