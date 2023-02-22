%---Uppgift 6---%

format long

T = 15;

v0 = 400;

theta = 45*(pi/180);

vx = v0*cos(theta);

vy = v0*sin(theta);

k_ref = 0.001;

%Till jämförelse av k = 0.001 och k = 0.0001
k_ver = [0.001 0.0001];

k = [0.1 0.05 0.025 0.0125];

N_ver = zeros(1,length(k_ver));

for i=1:length(k_ver)
    N_ver(i) = T/k_ver(i);
end

N = zeros(1, length(k));

for i=1:length(k)
    N(i) = T/k(i);
end

u0 = [0 0 vx vy];

%Denna lista fylls med resultat för k = 0.001, k=0.0001
result_ver = zeros(2,length(k_ver));

for i=1:length(k_ver)
    
    u = zeros(4,N_ver(i)+1);
    
    t = 0:k_ver(i):T;
    
    u(:,1) = u0;
    
    
    
    for n=1:N_ver(i)
        w1 = FP2(t(n), u(:,n));
        w2 = FP2(t(n) + k_ver(i)/2, u(:,n) + k_ver(i)/2*w1);
        w3 = FP2(t(n) + k_ver(i)/2, u(:,n) + k_ver(i)/2*w2);
        w4 = FP2(t(n) + k_ver(i), u(:,n) + k_ver(i)*w3);
        u(:,n+1) = u(:,n) + k_ver(i)/6*(w1+2*w2+2*w3+w4);
    end
    
    result_ver(1,i) = u(1,end);
    result_ver(2,i) = u(2,end);
    
end

fel_x = abs(u(1,1)-u(1,2));
fel_y = abs(u(2,1)-u(2,2));

disp('Felen för x- resp. y-led för k = 0.001 och k = 0.0001:');
disp(fel_x);
disp(fel_y);

%Lista för E_N
error = zeros(1,length(k));

%Lista för q
q = zeros(1,length(k)-1);

for i=1:length(k)
    
    u = zeros(4,N(i)+1);
    
    t = 0:k(i):T;
    
    u(:,1) = u0;
    
    for n=1:N(i)
        w1 = FP2(t(n), u(:,n));
        w2 = FP2(t(n) + k(i)/2, u(:,n) + k(i)/2*w1);
        w3 = FP2(t(n) + k(i)/2, u(:,n) + k(i)/2*w2);
        w4 = FP2(t(n) + k(i), u(:,n) + k(i)*w3);
        u(:,n+1) = u(:,n) + k(i)/6*(w1+2*w2+2*w3+w4);
    end
    
    error(i) = sqrt((u(1,end) - result_ver(1,1))^2+(u(2,end) - result_ver(2,1))^2);
   
end
    
for i=1:length(k)-1
    q(i) = q_calc(error(i),error(i+1),k(i),k(i+1));
end

disp('q bör här konvergera mot 4 i enlighet med noggrannhetsordn. för RK4. Här är q:');
disp(q);

    