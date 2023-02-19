%---Uppgift 4---%

k = 0.001;

v0 = 400;

T = 80;  

t = 0:k:T;

N = T/k; 
%Sätter övre- och undre vinkel för gissnings-intervallet.
theta_a = 85;

theta_b = 5;

for z=1:2
    
    theta = linspace(theta_b,theta_a,10);
    
    disp(z);
 
    x_val = zeros(1,length(theta));
    
    for i=1:length(theta)
        
        vx = v0*cos(theta(i).*(pi/180));
        vy = v0*sin(theta(i).*(pi/180));
    
        u0 = [0 0 vx vy];
    
        u=zeros(4,N+1);
    
        u(:,1)=u0;
    
        %RK4
        for n=1:N
            w1 = FP2(t(n), u(:,n));
            w2 = FP2(t(n) + k/2, u(:,n) + k/2*w1);
            w3 = FP2(t(n) + k/2, u(:,n) + k/2*w2);
            w4 = FP2(t(n) + k, u(:,n) + k*w3);
            u(:,n+1) = u(:,n) + k/6*(w1+2*w2+2*w3+w4);
        end
    
        %Identifierar index för y < 0.05 och x > 10 och gör en lista.
        y_indices = find((u(2,:) < 0.05) & (u(1,:) > 10));
        
        x_val(i) = u(1,y_indices(1));
    
    end
    
    n = find(x_val==max(x_val));
    
    theta_a = theta(n) + theta(n)./(5.^z);
    theta_b = theta(n) - theta(n)./(5.^z);
    
end
disp(theta(n));
disp(max(x_val));