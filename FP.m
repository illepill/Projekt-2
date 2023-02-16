function result = FP(t,u,c,a,g)
x = u(1);
y = u(2);
vx = u(3);
vy = u(4);

result = [vx; vy; -c*vx+a*sin(t); -c*vy-g];
end

