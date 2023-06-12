
clc;
opt = optimoptions(@fmincon,'Display','iter');
x = fmincon(@(x) f(x(1),x(2)),[1;90],[],[],[],[],[0 0],[20 360],[],opt);



function dist = f(alpha_p, gamma_p)

simulate_4_landing_point;

dist = sqrt((res(1)-550000)^2+(res(2)+10000)^2);

end