
R  = 1;

r1 = [R;0;0]; 
r2 = [0;R;0];
r3 = [0;R;0];

A  = pp2DCM(r1,r2,R);

atct = sph2atct(r1,A,r3,R)
