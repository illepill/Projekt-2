%---Uppgift 3---%

k = 0.001;

v0 = 400;

T = 35;

cond=0;

%Sätter övre- och undre vinkel för gissnings-intervallet.
theta_a = 45;

theta_b = 10;

while cond==0
    
    %Några villkor
    theta_m = theta_b + (theta_a - theta_b)/2;
    
    vx = v0*cos(theta_m*(pi/180));
    vy = v0*sin(theta_m*(pi/180));
    
    t = 0:k:T;

    N = T/k;
    
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
    
    %Identifierar index för y < 0.05 och x > 100 och gör en lista.
    y_indices = find((u(2,:) < 0.05) & (u(1,:) > 100));
    
    %Villkoren är olika för theta > 45 och theta < 45. Dessa if-satser
    %kontrollerar detta och sätter villkoren.
    if theta_m > 45
        if u(1,y_indices(1)) < 2700
            theta_a = theta_m;
        elseif u(1,y_indices(1)) > 2700
            theta_b = theta_m;
        end
    else
        if u(1,y_indices(1)) < 2700
            theta_b = theta_m;
        elseif u(1,y_indices(1)) > 2700
            theta_a = theta_m;
        end
    end
           
    disp(theta_m);
    
    %Kontrollerar om villkoret x = 2700m är uppfyllt
    if abs(u(1,y_indices(1))-2700) < 0.05
        cond = 1;
        disp(['Vinkeln är: ', num2str(theta_m), ' grader.']);
        disp(['Längden i x-led är: ', num2str(u(1,y_indices(1))), ' m.']);
    end
    
end

%Utan luftmotstånd:

T2 = 80;

vx2 = v0*cos(theta_m*(pi/180));
vy2 = v0*sin(theta_m*(pi/180));

t2 = 0:k:T2;

N2 = T2/k;

u02 = [0 0 vx2 vy2];

u2 = zeros(4,N2+1);

u2(:,1) = u02;

for n=1:N2
    w12 = FP2_luft0(t2(n), u2(:,n));
    w22 = FP2_luft0(t2(n) + k/2, u2(:,n) + k/2*w12);
    w32 = FP2_luft0(t2(n) + k/2, u2(:,n) + k/2*w22);
    w42 = FP2_luft0(t2(n) + k, u2(:,n) + k*w32);
    u2(:,n+1) = u2(:,n) + k/6*(w12+2*w22+2*w32+w42);
end

y_indices2 = find((u2(2,:) < 0.05) & (u2(1,:) > 100));

disp(['Längden i x-led utan luftmotstånd: ', num2str(u2(1,y_indices2(1))), ' m.']);




