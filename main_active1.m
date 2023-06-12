p.Rz    = 6371000;
p.mu    = 398600.4415e9;
p.g     = @(r) p.mu/r^2;

p.Cx = @(M,alpha) 1.0;
p.Cy = @(M,alpha) 0.0;
p.Sm = 13;

    r0      = p.Rz + 70e3;
    v0      = 2200;
    theta0  = 30*pi/180;
    psi0    = 0;
    phi0    = 0;
    lambda0 = 0;
    m0      = 48000;
    q0      = [r0;v0;theta0;psi0;phi0;lambda0;m0];
    p.f107  = 200;
    p.day   = 190;

res = [];

clc;
dt = 35;
t1 = 245;

alpha_p = 20;alpha=0;
for gamma_p= [0 linspace(0,360,32)]

    p.Is = @(P) 3000;
    c.alpha = @(t,q,p) (t>t1 & t < t1+dt)*alpha*pi/180;
    c.gamma = @(t,q,p) (t>t1 & t < t1+dt)*gamma_p*pi/180;
    c.P     = @(t,q,p) (t>t1 & t < t1+dt)*100000*9.807;
  

    opt     = odeset('RelTol',1e-7,'AbsTol',1e-6,'Events',@(t,q) event_function(t,q,p,c));
    [t,q]   = ode45(@(t,q) yar_dqdt(t,q,p,c),[0 500], q0, opt);
    vec_r0   = sph2ecef(lambda0,phi0,p.Rz);
    DCMnorth = pp2DCM(vec_r0, [0;0;p.Rz], p.Rz);
    DCMr0v0  = DCMnorth*Ay(psi0-pi/2);
    vec_re   = sph2ecef(q(end,6),q(end,5),p.Rz);
    atct     = sph2atct(vec_r0,DCMr0v0,vec_re,p.Rz);
    res      = [res atct];

    if alpha == 0 
       alpha = alpha_p; 
    end
end

res2 = [];
alpha_p = 10;alpha=0;
for gamma_p= [0 linspace(0,360,32)]

    p.Is = @(P) 3000;
    c.alpha = @(t,q,p) (t>t1 & t < t1+dt)*alpha*pi/180;
    c.gamma = @(t,q,p) (t>t1 & t < t1+dt)*gamma_p*pi/180;
    c.P     = @(t,q,p) (t>t1 & t < t1+dt)*100000*9.807;

    opt     = odeset('RelTol',1e-7,'AbsTol',1e-6,'Events',@(t,q) event_function(t,q,p,c));
    [t,q]   = ode45(@(t,q) yar_dqdt(t,q,p,c),[0 500], q0, opt);
    vec_r0   = sph2ecef(lambda0,phi0,p.Rz);
    DCMnorth = pp2DCM(vec_r0, [0;0;p.Rz], p.Rz);
    DCMr0v0  = DCMnorth*Ay(psi0-pi/2);
    vec_re   = sph2ecef(q(end,6),q(end,5),p.Rz);
    atct     = sph2atct(vec_r0,DCMr0v0,vec_re,p.Rz);
    res2      = [res2 atct];

    if alpha == 0 
       alpha = alpha_p; 
    end
end

%
plot(res(1,2:end)*0.001, res(2,2:end)*0.001,'-o','LineWidth',2)
hold on;
plot(res2(1,2:end)*0.001, res2(2,2:end)*0.001,'-o','LineWidth',2)

plot(res(1,1)*0.001, res(2,1)*0.001,'s','MarkerSize',10,'LineWidth',2)

hold off;
daspect([1 1 1])
xlabel('Дальность, км')
ylabel('Боковое смещение, км')
grid;
legend('\alpha_1 = 20^o','\alpha_1 = 10^o')
set(gca,'FontSize',12)



%% Вариация Начала импульса

p.Rz    = 6371000;
p.mu    = 398600.4415e9;
p.g     = @(r) p.mu/r^2;

p.Cx = @(M,alpha) 1.0;
p.Cy = @(M,alpha) 0.0;
p.Sm = 13;

    r0      = p.Rz + 70e3;
    v0      = 2200;
    theta0  = 30*pi/180;
    psi0    = 0;
    phi0    = 0;
    lambda0 = 0;
    m0      = 48000;
    q0      = [r0;v0;theta0;psi0;phi0;lambda0;m0];
    p.f107  = 200;
    p.day   = 190;

res = [];

clc;
dt = 35;
t1 = 245;

alpha_p = 20;alpha=0;
for gamma_p= [0 linspace(0,360,32)]

    p.Is = @(P) 3000;
    c.alpha = @(t,q,p) (t>t1 & t < t1+dt)*alpha*pi/180;
    c.gamma = @(t,q,p) (t>t1 & t < t1+dt)*gamma_p*pi/180;
    c.P     = @(t,q,p) (t>t1 & t < t1+dt)*100000*9.807;
  

    opt     = odeset('RelTol',1e-7,'AbsTol',1e-6,'Events',@(t,q) event_function(t,q,p,c));
    [t,q]   = ode45(@(t,q) yar_dqdt(t,q,p,c),[0 500], q0, opt);
    vec_r0   = sph2ecef(lambda0,phi0,p.Rz);
    DCMnorth = pp2DCM(vec_r0, [0;0;p.Rz], p.Rz);
    DCMr0v0  = DCMnorth*Ay(psi0-pi/2);
    vec_re   = sph2ecef(q(end,6),q(end,5),p.Rz);
    atct     = sph2atct(vec_r0,DCMr0v0,vec_re,p.Rz);
    res      = [res atct];

    if alpha == 0 
       alpha = alpha_p; 
    end
end
fprintf('Высота запуска %3.1f\n',max(q(t>t1,1)-p.Rz)*0.001);

t1 = 235;

res2 = [];
alpha_p = 20;alpha=0;
for gamma_p= [0 linspace(0,360,32)]

    p.Is = @(P) 3000;
    c.alpha = @(t,q,p) (t>t1 & t < t1+dt)*alpha*pi/180;
    c.gamma = @(t,q,p) (t>t1 & t < t1+dt)*gamma_p*pi/180;
    c.P     = @(t,q,p) (t>t1 & t < t1+dt)*100000*9.807;

    opt     = odeset('RelTol',1e-7,'AbsTol',1e-6,'Events',@(t,q) event_function(t,q,p,c));
    [t,q]   = ode45(@(t,q) yar_dqdt(t,q,p,c),[0 500], q0, opt);
    vec_r0   = sph2ecef(lambda0,phi0,p.Rz);
    DCMnorth = pp2DCM(vec_r0, [0;0;p.Rz], p.Rz);
    DCMr0v0  = DCMnorth*Ay(psi0-pi/2);
    vec_re   = sph2ecef(q(end,6),q(end,5),p.Rz);
    atct     = sph2atct(vec_r0,DCMr0v0,vec_re,p.Rz);
    res2      = [res2 atct];

    if alpha == 0 
       alpha = alpha_p; 
    end
end

fprintf('Высота запуска %3.1f\n',max(q(t>t1,1)-p.Rz)*0.001);

%
plot(res(1,2:end)*0.001, res(2,2:end)*0.001,'-o','LineWidth',2)
hold on;
plot(res2(1,2:end)*0.001, res2(2,2:end)*0.001,'-o','LineWidth',2)
plot(res(1,1)*0.001, res(2,1)*0.001,'sr','MarkerSize',10,'LineWidth',2)
plot(res2(1,1)*0.001, res2(2,1)*0.001,'sb','LineWidth',2)
legend('t_1','t_1-10 с')

hold off;
daspect([1 1 1])
xlabel('Дальность, км')
ylabel('Боковое смещение, км')
grid;
set(gca,'FontSize',12)
%%

