function result = RK4(FP,k,T,f,c,a,g)
N = T/k;

u = zeros(N+1);

u(1) = f;

t = 0:k:T;

for n=1:N
    w1 = FP(t(n),u(n),c,a,g);
    w2 = FP(t(n)+k/2,u(n)+k/2*w1,c,a,g);
    w3 = FP(t(n)+k/2,u(n)+k/2*w2,c,a,g);
    w4 = FP(t(n)+k,u(n)+k*w3,c,a,g);
    u(n+1) = u(n)+k/6*(w1+2*w2+2*w3+w4);
end

result = u;

end
    