function result = y_anal(g,c,v,t)
result = ((-v.*c-g)*exp(-c.*t)+(-g.*t+v).*c+g)/c.^2;
end