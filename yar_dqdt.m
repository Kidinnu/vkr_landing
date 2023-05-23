function dqdt = yar_dqdt(t,q,p,c)

r       = q(1);
v       = q(2);
theta   = q(3);
psi     = q(4);
phi     = q(5);
lambda  = q(6);
m       = q(7);

g   = p.g(r);
[ss, rho]  = atm_data(r-p.Rz);
M   = v/ss;

alpha = c.alpha(t,q,p);
gamma = c.gamma(t,q,p);
P     = c.P(t,q,p);
Pxa    = -P*cos(alpha);
Pya    = -P*sin(alpha);

cx    = p.Cx(M,alpha);
cy    = p.Cy(M,alpha);
q     = 0.5*rho*v*v;

dv    = - g*sin(theta)-cx*p.Sm*q/m+Pxa/m;
dr    = v*sin(theta);
dtheta= (g*(v*v/(r*g)-1)*cos(theta)+cy*p.Sm*q*cos(gamma)/m-Pya*cos(gamma)/m)/v;

dpsi  = (cy*p.Sm*q*sin(gamma)/m-Pya*sin(gamma)/m-v*v/r*tan(phi)*cos(theta)^2*cos(psi))/(v*cos(theta));
dphi  = v*cos(theta)*sin(psi)/r;
dlambda = v*cos(theta)*cos(psi)/(r*cos(phi));

dm    = -P/p.Is(P);

dqdt = [dr;dv;dtheta;dpsi;dphi;dlambda;dm];

end


