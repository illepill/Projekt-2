%---Uppgift 7---%

%Först jämför vi x_N för de olika luftmotståndskoefficienterna. För detta
%använder vi funktionen FP3 som tar in c som en variabel och har w(t)=0.

v0 = 820;

theta = 65;

vx = v0*cos(theta*(pi)/180);
vy = v0*sin(theta*(pi)/180);

u0 = [0 0 vx vy];

k = 0.0001;

T = 70;

t = 0:k:T;

N = round(T/k);

u1 = zeros(4,N+1);
u2 = zeros(4,N+1);

u1(:,1) = u0;
u2(:,1) = u0;

x_N = zeros(1,2);

%Denna loopar för konstant c
for i=1:N
    w1 = FP32(t(i), u1(:,i));
    w2 = FP32(t(i) + k/2, u1(:,i) + k/2*w1);
    w3 = FP32(t(i) + k/2, u1(:,i) + k/2*w2);
    w4 = FP32(t(i) + k, u1(:,i) + k*w3);
    u1(:,i+1) = u1(:,i) + k/6*(w1 + 2*w2 + 2*w3 + w4);
end

I1 = find(u1(2,:) < 0.05 & u1(2,:) > 0);

x_N(1,1) = u1(1,I1(end)); 

%Denna loopar för c beroende av y
for i=1:N
    w1 = FP3(t(i), u2(:,i));
    w2 = FP3(t(i) + k/2, u2(:,i) + k/2*w1);
    w3 = FP3(t(i) + k/2, u2(:,i) + k/2*w2);
    w4 = FP3(t(i) + k, u2(:,i) + k*w3);
    u2(:,i+1) = u2(:,i) + k/6*(w1 + 2*w2 + 2*w3 + w4);
end

I2 = find(u2(2,:) < 0.05 & u2(2,:) > 0);

x_N(1,2) = u2(1,I2(end));

diff = abs(x_N(1,1) - x_N(1,2));

disp(['Skillnaden i flyglängden då man bortser från y-beroendet är: ', num2str(diff), ' m']);
    
    


    
