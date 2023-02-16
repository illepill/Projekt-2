%---Uppgift 2---%

v0 = 400;

theta = 45*(pi/180);

T = 35;

vx = v0*cos(theta);
vy = v0*sin(theta);

u0 = [0 0 vx vy];


%Den höga hastigheten gör att för stora tidssteg k kommer att missa y=0
k = 0.0001;

N = T/k;

t = linspace(0,T,N+1);
u = zeros(4,N+1);
u(:,1) = u0;

for n=1:N
        w1 = FP2(t(n), u(:,n));
        w2 = FP2(t(n) + k/2, u(:,n) + k/2*w1);
        w3 = FP2(t(n) + k/2, u(:,n) + k/2*w2);
        w4 = FP2(t(n) + k, u(:,n) + k*w3);
        u(:,n+1) = u(:,n) + k/6*(w1+2*w2+2*w3+w4);
end

I1 = find((u(2,:) < 0.05) & (u(2,:) > 0));

figure(1)
plot(u(1,:),u(2,:));
hold on
for i=1:length(I1)
    plot(u(1,I1(i)),u(2,I1(i)),'*',color='red');
end
hold off