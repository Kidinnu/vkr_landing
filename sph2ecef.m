function ecef = sph2ecef(lambda,phi,r)
%% Из сферических координат в декартовы
%
%
%
    ecef = r.*[cos(phi).*cos(lambda);cos(phi).*sin(lambda);sin(phi)];
end