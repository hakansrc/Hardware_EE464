Vo = 12;
Vs = 24;
P = 80 ; %W
fsw = 100000; %hz bunu yüksek attým ama reasonable olduðunu düþünüyorum
Ts = 1/fsw;
Iout = P/Vo;
D = 0.4; %just an assumption güzel bir sayý
n2overn1 = Vo/Vs*((1-D)/D); % turns ratio olaylarý
% Lm = 100e-6; % H %kafadan attim ama biraz yüksek gibi ama bakmak lazým 

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
Lm_reasonable = Vs*D/(delta_iLm*fsw); %bu formüle bir bakalým sonra

%% upper section result in a Lm value of 28.8µH, lets choose a values of 40µ just to be safe
u0 = 4*pi*10^-7;
L_desired = 35*10^-6;

N =12; % give some numeros
AL_approximate = L_desired/N^2;%*10^9; %nH/turn^2


%% will be chosen 
AL = 250*10^-9; %will be chosen
Core_area= 98e-6; %will be chosen
N = 12; %will be chosen
L = AL*N^2; %will be chosen
length_effective= 44e-3; %will be chosen
ur = 89; %will be chosen
u = u0*ur;
Core_reluctance = length_effective/(u*Core_area);
Core_reluctance2 = N^2/L; %maybe and easy and alternative way
Bpeak = N*ILm_max/(Core_area*Core_reluctance);



















