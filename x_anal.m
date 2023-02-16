function result = x_anal(c,a,v,t)
result = ((-c^2*v-a-v)*exp(-c*t)-cos(t)*a*c^2-a*c*sin(t)+(c^2+1)*(a+v))/((c^2+1)*c);
end