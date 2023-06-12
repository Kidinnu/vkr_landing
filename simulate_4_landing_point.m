p.Rz    = 6371000;
p.mu    = 398600.4415e9;
p.g     = @(r) p.mu/r^2;
p.we    = 2*pi/(3600*24);

p.Cx = @(M,alpha) 1.6;
p.Cy = @(M,alpha) 0.0;
p.Sm = 13.5;

r0      = p.Rz + 70e3;
v0      = 2200;
theta0  = 30*pi/180;
psi0    = 60*pi/180;
phi0    = 0;
lambda0 = 0;
m0      = 48000;
q0      = [r0;v0;theta0;psi0;phi0;lambda0;m0];
p.f107  = 150;
p.day   = 1;

res = [];

dt = 35;
t1 = 245;

p.Is = @(P) 3000;
c.alpha = @(t,q,p) (t>t1 & t < t1+dt)*alpha_p*pi/180;
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

