function DCM = pp2DCM(r1, r2, R)
%pp2DMC Локальная система координат для двух точек на сфере
%   ey направлена по радиус-вектору сферы (из сферы) в точке r1
%   ex направлена по касательной к сфере в точке r1 в направлении r2
%   ez дополняет до правой
    ey  = r1/norm(r1);
    ec  = (r2-r1)/norm(r2-r1);
    ez  = cross(ec,ey);
    ez  = ez/norm(ez);
    ex  = cross(ey,ez);
    DCM = [ex ey ez];
end

