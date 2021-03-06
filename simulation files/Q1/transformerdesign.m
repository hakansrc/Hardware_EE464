Vo = 12;
Vs = 24;
P = 80 ; %W
fsw = 10000; %hz bunu y�ksek att�m ama reasonable oldu�unu d���n�yorum
Ts = 1/fsw;
Iout = P/Vo;
D = 0.4; %just an assumption g�zel bir say�
n2overn1 = Vo/Vs*((1-D)/D); % turns ratio olaylar�
% Lm = 100e-6; % H %kafadan attim ama biraz y�ksek gibi ama bakmak laz�m 

Rload = Vo^2/P;
%% from hart at page 272
% Lm_min = (1-D)^2*Rload/(2*fsw)*n2overn1^2; % page 272 eqn 7-12
% ILm_av = Vo^2/(Vs*D*Rload);
% ILm_max = (Vs*D/(((1-D)^2)*Rload))*n2overn1^2 + Vs*D*Ts/(2*Lm);
% ILm_min = (Vs*D/(((1-D)^2)*Rload))*n2overn1^2 - Vs*D*Ts/(2*Lm);
% ILm_ripplepercent = 100*(ILm_max-ILm_min)/ILm_av; % percent


%% assume 40% ripple at the inductor.
Lm_min = (1-D)^2*Rload/(2*fsw)*n2overn1^2; % page 272 eqn 7-12
ripplepercent = 40/100;
ILm_av = Vo^2/(Vs*D*Rload);
ILm_max = ILm_av + ILm_av*ripplepercent/2;
ILm_min = ILm_av - ILm_av*ripplepercent/2;
delta_iLm =  ILm_max-ILm_min;
Lm = Vs*D/(delta_iLm*fsw);
Lm_reasonable = Vs*D/(delta_iLm*fsw); %bu form�le bir bakal�m sonra

%% upper section result in a Lm value of 28.8�H, lets choose a values of 40� just to be safe
u0 = 4*pi*10^-7;
L_desired = 1100*10^-6;

N =12; % give some numeros
AL_approximate = L_desired/N^2;%*10^9; %nH/turn^2


%% will be chosen https://www.digikey.com/product-detail/en/epcos-tdk/B65813J0250A041/495-5276-ND/3914229
AL = 160*10^-9; %will be chosen
Core_area= 200e-6; %will be chosen
N = 40; %will be chosen
L = AL*N^2; %will be chosen
length_effective= 70e-3; %will be chosen
ur = 45; %will be chosen
u = u0*ur;
Core_reluctance = length_effective/(u*Core_area);
Core_reluctance2 = N^2/L; %maybe and easy and alternative way
Bpeak = N*ILm_max/(Core_area*Core_reluctance);
Bpeakmean = N*ILm_av/(Core_area*Core_reluctance);
Core_volume= 14000*10e-9; %m3
Core_loss = 5*Core_volume*1000;%abartilibiraz
%%
copperarea = pi*(1.29/2)^2*N; %mm2
windowarea = 20.8*7; %% mm2
FF = copperarea/windowarea;
copperlength = ((2*20.8)+(2*7))*N/1000; %m 
approximate_copper_resistance = 1.68e-8*copperlength/(pi*(1.29/2*0.001)^2);
copper_loss = Iout^2*approximate_copper_resistance*2;
%% by neglecting the rc value
Vout_ripplepercent = 10;
delta_Vo = Vo*Vout_ripplepercent/100;
Capacitor_value = D/(Rload*(delta_Vo/Vo)*fsw);

%% switching element loss
mean_current = Iout/2; %due to the 2:1 ratio of the transformer
Rds_on = 0.125;
conduction_loss = mean_current^2*Rds_on;
switching_loss = 10*fsw*50e-9; % 41e-9 is the total gate charge V*Q*f is used.
switching_element_loss = switching_loss +conduction_loss;
%% diode loss
diode_loss = 0.66*Iout;
%% snubber design
% 2.3MHZ hi� bi�i yokken
% 3.6uF da 1.1MHZ falan
fs = 10000;
Ci = 5*930e-12;
f0 = 2.3e6;
f1 = 935e3;
m = f0/f1;
C0 = Ci/(m^2-1);
L_paras = (m^2-1)/((2*pi*f0)^2*Ci);
Csnub = 3*C0;
Rsnub = sqrt(L_paras/C0);
%% 
Z = 2*pi*2.3e6*2.3e-6;
C = 1/(2*pi*2.3e6*Z);
%% 
Llk = 2.2919e-06;
Vsn = 157/2-24;
disndt = -(Vsn-2*12)/Llk;
ipeak = 39.4;
ts = Llk/(Vsn-2*12)*ipeak;
Psn = Vsn*ipeak*ts*fsw/2;
Psn2 = 0.5*Llk*ipeak^2*Vsn*fs/(Vsn-2*12);
Rsn = Vsn^2/(Psn);
delta_Vsn = 0.10; % 10percent
Csn = 1/(Rsn*fsw*delta_Vsn);








