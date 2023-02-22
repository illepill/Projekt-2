%---Uppgift 7 del 2---%

theta = 65;

v0 = 820;

vx = v0*cos(theta*(pi/180));
vy = v0*sin(theta*(pi/180));

%k1 = [1 5 8 9 9.3 9.4 9.5 9.6 10];

k1 = [1 5 8 9 9.3 9.4 9.5 9.6];

%k2 = [1 5 8 9 9.3 9.4 9.5 9.6 10];

k2 = [1 5 8];

%k1 = [10];

for i=1:length(k1)
    
    T1 = 100;
    
    N1 = round(T1/k1(i));
    
    t1 = linspace(0,T,N1+1);
    
    u3 = zeros(4,N1+1);
    
    u3(:,1) = u0;
    
    for n=1:N1
        w1 = FP3(t1(n), u3(:,n));
        w2 = FP3(t1(n) + k1(i)./2, u3(:,n) + k1(i)./2*w1);
        w3 = FP3(t1(n) + k1(i)./2, u3(:,n) + k1(i)./2*w2);
        w4 = FP3(t1(n) + k1(i), u3(:,n) + k1(i).*w3);
        u3(:,n+1) = u3(:,n) + k1(i)./6*(w1 + 2*w2 + 2*w3 + w4);
    end
    
    x_vel = u3(3,:);
    y_vel = u3(4,:);
    
    ener = energy(x_vel,y_vel);
    
    plot(t1,ener)
    
    hold on
end
ylabel('E(k)')
xlabel('t')
legend('k=1','k=5','k=8','k=9','k=9.3','k=9.5','k=9.6')
hold off

for i=1:length(k2)
    
    T1 = 100;
    
    N1 = round(T1/k2(i));
    
    t1 = linspace(0,T1,N1+1);
    
    u3 = zeros(4,N1+1);
    
    u3(:,1) = u0;
    
    for n=1:N1
        w1 = FP32(t1(n), u3(:,n));
        w2 = FP32(t1(n) + k2(i)./2, u3(:,n) + k2(i)./2*w1);
        w3 = FP32(t1(n) + k2(i)./2, u3(:,n) + k2(i)./2*w2);
        w4 = FP32(t1(n) + k2(i), u3(:,n) + k2(i).*w3);
        u3(:,n+1) = u3(:,n) + k2(i)./6*(w1 + 2*w2 + 2*w3 + w4);
    end
    
    x_vel = u3(3,:);
    y_vel = u3(4,:);
    
    ener = energy(x_vel,y_vel);
    
    figure(2)
    plot(t1,ener)
    hold on
end
ylabel('E(k)')
xlabel('t')
legend('k=1','k=5','k=8')
hold off
