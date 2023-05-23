h = 0:100:5000;
h = [h 6000:1000:120000];

[~, rho1]  = atmosnrlmsise00(h,51,128,2022,1   ,12*3600);
[~, rho3]  = atmosnrlmsise00(h,51,128,2022,3*30,12*3600);
[~, rho6]  = atmosnrlmsise00(h,51,128,2022,6*30,12*3600);
[~, rho9] = atmosnrlmsise00(h,51,128,2022,9*30,12*3600);
[~, rho12] = atmosnrlmsise00(h,51,128,2022,11*30,12*3600);

[~, a, ~, rhos] = atmosisa(h);

clc;
res = [h'*0.001, rho1(:,6), rho3(:,6), rho6(:,6), rho9(:,6), rho12(:,6)];

fprintf('atmosnrlmsise00\n');

fprintf('%4.1f\t%5.3e\t%+5.3e\t%+5.3e\t%+5.3e\t%+5.3e\n', res');


%%



