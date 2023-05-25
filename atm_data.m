function [a,rho] = atm_data(height)    
    [T, rho] = atmosnrlmsise00(height,0,0,2023,30,0);
    rho = rho(6);
    a = 300;
end
