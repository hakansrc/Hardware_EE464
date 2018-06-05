I = 4;
Llk = 20e-6;
Llk_energy = 0.5*Llk*I^2;

V = 10;
C = Llk_energy/V^2*2;

fsw = 10000;
ts = 1/fsw;
D = 0.5;
t_off = (1-D)/10000;
% R = 100;
% TC = 3*R*C;

% r = t_off/(3*C)

wattage = Llk_energy/t_off;
R = V^2/wattage;
TC = 5*R*C;
t_off/TC;
% R
% C
% R*C
%%
Llk = 15e-6;
Ip = 6.17;
Plk = 0.5*Llk*Ip^2*fsw;
vx = 50;
vf = 24;
Psnmax = Plk*(1+vf/vx);
R = 2*vx*ts*(vf+vx)/(Llk*Ip^2);
Psn = (vx+vf)^2/R;