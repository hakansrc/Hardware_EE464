%% designs the core and tries to determine the needed airgap
ur = 2200;
u0 = 4*pi*10^-7;
u = u0*ur;
core_area_inner = 17e-3*24.65e-3;
core_area_edges = 8.5e-3*24.65e-3;
length_effective = 2*(23.45e-3+23.45e-3+23.24e-3);
% we can take the inner core area to calculate reluctance with the
% effective lenthh, since the windings will be in the middle of the
% transformer core and the sides are parallelly connected reluctance whose
%equivalent reluctance is equal to the one in the middle.
reluctance_nogap = length_effective/(u*core_area_inner);
Al_nogap = 1/reluctance_nogap;
air_gap = 2e-3; %m
reluctance_airgap = 2*air_gap/(u0*core_area_inner);
Al_gap = 1/(reluctance_nogap+reluctance_airgap);

%%
L_desired = 288e-6;
N=sqrt(L_desired/Al_gap);
N1 = 50;
N2 = 25;
windowarea = 2*10.75e-3*19.16e-3;
copperarea1 = pi*(1.29/2)^2*N*1e-6; %primary
copperarea2 = 0.5*pi*(2.3/2)^2*N*1e-6; %secondary
FF = (copperarea1+copperarea2)/windowarea;
Volume = 27741.36e-6;
ur_e = length_effective/((reluctance_nogap+reluctance_airgap)*core_area_inner)*1/u0;

ILm_max = 10;
Bpeak = N*ILm_max/(core_area_inner*(reluctance_nogap+reluctance_airgap));
L_obtained = Al_gap*N1^2;

estimate_cablelength1 = (17e-3+24.65e-3)*2*N1;
estimate_cablelength2 = (17e-3+24.65e-3)*2*N2;
%%
Rin = 50;
Cin = 0.47e-6;
la = Rin*Cin*4*10^4
imp = 2*pi*10000*Cin
1/Rin