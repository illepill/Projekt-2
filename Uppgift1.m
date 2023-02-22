%%%Uppgift 1%%%

%Några grejer angivna i uppgiften

a = 0.020;

c = 0.001;

v_0 = 40;

theta = 40*(pi/180); %Räknar om till radianer

g0 = 9.82;

T = 4;

k = [1 0.5 0.25 0.125];

%Begynnelsehastigheterna v_x, v_y
v_x = v_0*cos(theta);
v_y = v_0*sin(theta);

%Begynnelsevärden på formen u_0 = [x y v_x v_y]
f = [0 0 v_x v_y];

N = zeros(1, length(k));

for i=1:length(k)
    N(i) = T/k(i);
end

error = zeros(1,length(k));

%Analytiska lösningarna för T=4
x = x_anal(c,a,v_x,T);
y = y_anal(g0,c,v_y,T);

for i=1:length(k)
    
    t = 0:k(i):T;
    
    u = zeros(4,N(i)+1);
    
    u(:,1) = f;
    
    for n=1:N(i)
        w1 = FP(t(n), u(:,n), c, a, g0);
        w2 = FP(t(n) + k(i)./2, u(:,n) + k(i)./2*w1, c, a, g0);
        w3 = FP(t(n) + k(i)./2, u(:,n) + k(i)./2*w2, c, a, g0);
        w4 = FP(t(n) + k(i), u(:,n) + k(i).*w3, c, a, g0);
        u(:,n+1) = u(:,n) + k(i)./6*(w1+2*w2+2*w3+w4);
    end
    
    %disp(u(2,end));
    
    error(i) = sqrt((u(1,end) - x)^2+(u(2,end) - y)^2);
end
    
q1 = q_calc(error(1),error(2),k(1),k(2))
q2 = q_calc(error(2),error(3),k(2),k(3))
q3 = q_calc(error(3),error(4),k(3),k(4))