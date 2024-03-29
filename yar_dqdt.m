function dqdt = yar_dqdt(t,q,p,c)
%yar_dqdt Уравнения движения спускаемого аппарата 
% (уравнения из монографии Ярошевского)

r       = q(1);
v       = q(2);
theta   = q(3);
psi     = q(4);
phi     = q(5);
lambda  = q(6);
m       = q(7);

g   = p.g(r);
[ss, rho]  = atm_data(r-p.Rz,p);
M   = v/ss;

% Управляемые параметры: угол атаки, скоростной угол крена, тяга 
alpha = c.alpha(t,q,p); 
gamma = c.gamma(t,q,p);
P     = c.P(t,q,p);


Pxa    = -P*cos(alpha);
Pya    = -P*sin(alpha);

% Аэродинамические коэффициенты
cx    = p.Cx(M,alpha);
cy    = p.Cy(M,alpha);
% Скоростной напор
q     = 0.5*rho*v*v;

dv    = - g*sin(theta)-cx*p.Sm*q/m+Pxa/m - r*p.we^2*(cos(phi)*sin(theta)-sin(phi)*sin(psi)*cos(theta))*cos(phi);
dr    = v*sin(theta);
dtheta= (g*(v*v/(r*g)-1)*cos(theta)+cy*p.Sm*q*cos(gamma)/m-Pya*cos(gamma)/m)/v+2*p.we*cos(phi)*cos(psi)+(1/v)*r*p.we^2*(sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi))*cos(phi);
dpsi  = (cy*p.Sm*q*sin(gamma)/m-Pya*sin(gamma)/m-v*v/r*tan(phi)*cos(theta)^2*cos(psi))/(v*cos(theta))-(2*p.we*(sin(phi)*cos(theta)-cos(phi)*sin(theta)*sin(psi))+r*p.we^2*sin(phi)*cos(phi)*cos(psi)/v)/cos(theta);

dphi  = v*cos(theta)*sin(psi)/r;
dlambda = v*cos(theta)*cos(psi)/(r*cos(phi));

% Секундный расход массы
dm    = -P/p.Is(P);

dqdt = [dr;dv;dtheta;dpsi;dphi;dlambda;dm];

end


