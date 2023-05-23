p.Rz    = 6371000;
p.mu    = 398600.4415e9;
p.g     = @(r) p.mu/r^2;

p.Cx = @(M,alpha) 1.0;
p.Cy = @(M,alpha) 0.0;
p.Sm = 13;

p.Is = @(P) 3000;

c.alpha = @(t,q,p) 0;
c.gamma = @(t,q,p) 0;
c.P     = @(t,q,p) (t>200 & t < 230)*1000000;

r0      = p.Rz + 60e3;
v0      = 2200;
theta0  = 30*pi/180;
psi0    = 0;
phi0    = 0;
lambda0 = 0;
m0      = 45000;
q0      = [r0;v0;theta0;psi0;phi0;lambda0;m0];

opt     = odeset('RelTol',1e-7,'AbsTol',1e-8,'Events',@(t,q) event_function(t,q,p,c));
[t,q]   = ode113(@(t,q) yar_dqdt(t,q,p,c),[0 400], q0, opt);

plot(t,(q(:,1)-p.Rz)*0.001);
plot(t, q(:,2));


ecef0 = sph2ecef(lambda0,phi0,p.Rz);

ecef  = sph2ecef(q(:,6)',q(:,5)',q(:,1)');




