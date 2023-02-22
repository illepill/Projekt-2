%---Uppgift 5---%

k = 0.001;

v0 = 400;

T = 50;

%För finare plot, välj fler steg (tar längre tid)
theta = linspace(1,89,100);

%Dessa behövs för att spara värden från for-loopen
integral = zeros(1,length(theta));

x_val = zeros(1, length(theta));

for i=1:length(theta)
    
    vx = v0*cos(theta(i)*(pi/180));
    vy = v0*sin(theta(i)*(pi/180));
    
    t = 0:k:T;
    
    N=T/k;
    
    u = zeros(4,N+1);
    
    u0 = [0 0 vx vy];
    
    u(:,1) = u0;
    
    %RK4
    for n=1:N
        w1 = FP2(t(n), u(:,n));
        w2 = FP2(t(n) + k/2, u(:,n) + k/2*w1);
        w3 = FP2(t(n) + k/2, u(:,n) + k/2*w2);
        w4 = FP2(t(n) + k, u(:,n) + k*w3);
        u(:,n+1) = u(:,n) + k/6*(w1+2*w2+2*w3+w4);
    end
    
    %Finner index för landningspunkt
    y_indices = find((u(2,:) < 0.05) & abs(u(1,:)) > 10);
    
    %Vektorer för hastigheterna
    vx = u(3,1:y_indices(1));
    
    vy = u(4,1:y_indices(1));
    
    %x-värdet vid landning
    x_val(i) = u(1,y_indices(1));
    
    %Integrandens värde
    integrand_val = integrand(vx, vy);
    
    %Tiden mellan 0 och landning
    time = t(1:y_indices(1));
    
    %Integralen beräknad med trapets-metoden
    integral(i) = trapz(time,integrand_val);
end
    
%Plot över integral, x beroende av theta
plot(theta, integral);
hold on
plot(theta, x_val);
legend('integral','x');

%För att finna abs(x) < 0.05 används samma idé som uppg. 3

cond=0;

%Sätter övre- och undre vinkel för gissnings-intervallet.
theta_a = 89;

theta_b = 45;

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
    
    %Identifierar index för y < 0.05 och gör en lista.
    y_indices = find(u(2,:) < 0.05);
    t_index = find(t(y_indices) > 5);
    
    
    if abs(u(1,t_index(1))) < 0.05
        theta_a = theta_m;
    elseif u(1,t_index(1)) > 0.05
        theta_b = theta_m;
    end
           
    disp(theta_m);
    
    %Kontrollerar om villkoret x = 2700m är uppfyllt
    if u(1,t_index(1)) < 0.05
        cond = 1;
        disp(['Vinkeln är: ', num2str(theta_m), ' grader.']);
        disp(['Längden i x-led är: ', num2str(u(1,t_index(1))), ' m.']);
    end
    
end

