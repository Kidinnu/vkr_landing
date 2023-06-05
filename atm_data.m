function [a,rho] = atm_data(height,p)
if height<0
    height = 0;
end


nov_6days  = [78.6 78.2 82.4 85.5 85.0 84.1];
dec_31daymean = 84.5;
jan_31daymean = 83.5;
feb_13days = [89.9 90.3 87.3 83.7 83.0 81.9 82.0 78.4 76.7 75.9 74.7 73.6 72.7];
F107A = (sum(nov_6days) + sum(feb_13days) + (dec_31daymean + jan_31daymean)*31)/81;
F107  = p.f107;
APH   = [17.375 15 20 15 27 (32+22+15+22+9+18+12+15)/8 (39+27+9+32+39+9+7+12)/8];
flags = ones(1,23);
flags(9) = -1;
[T, rho] = atmosnrlmsise00(height,65,65,2023,p.day,0,F107A,F107,APH,flags);
rho = rho(6);
a = 300;
end
