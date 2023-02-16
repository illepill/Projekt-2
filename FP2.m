function result = FP2(t,u)
x=u(1);
y=u(2);
vx=u(3);
vy=u(4);

c0=4.518e-4;
c = c0*exp(-1e-4*y);
w = -20*exp(-((t-10)/5)^2);
v_norm = sqrt((vx-w)^2+(vy)^2);
g = (3.986e14)/(6.371e6+y)^2;

result = [vx; vy; -c*v_norm*(vx-w); -c*v_norm*vy-g];
end

