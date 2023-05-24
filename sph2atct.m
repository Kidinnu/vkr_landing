function atct = sph2atct(r0,DCM0,rp,R)
%SPH2ATCT Вдоль-поперек
%   Detailed explanation goes here
DCM0p = pp2DCM(r0,rp,R);
Arp = acos(dot(DCM0p(:,1),DCM0(:,1)));
rp0 = DCM0'*rp;
if rp0(3)<0
    Arp = -Arp;
end
c = acos(dot(rp,r0)/(norm(rp)*norm(r0)));
along_track = atan(tan(c)*cos(Arp));
cross_track = atan(tan(Arp)*sin(along_track));
atct = [along_track;cross_track]*R;
end

