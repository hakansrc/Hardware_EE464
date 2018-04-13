Vo = 12;
Vs = 24;
P = 80 ; %W
fsw = 100000; %hz bunu y�ksek att�m ama reasonable oldu�unu d���n�yorum
Ts = 1/fsw;
Iout = P/Vo;
D = 0.4; %just an assumption g�zel bir say�
n2overn1 = Vo/Vs*((1-D)/D); % turns ratio olaylar�
Lm = 100e-6; % H %kafadan attim ama biraz y�ksek gibi ama bakmak laz�m 

Rload = Vo^2/P;
%% from hart at page 272
ILm_av = Vo^2/(Vs*D*Rload);
ILm_max = (Vs*D/(((1-D)^2)*Rload))*n2overn1^2 + Vs*D*Ts/(2*Lm);
ILm_min = (Vs*D/(((1-D)^2)*Rload))*n2overn1^2 - Vs*D*Ts/(2*Lm);
ILm_ripplepercent = 100*(ILm_max-ILm_min)/ILm_av; % percent

Lm_min = (1-D)^2*Rload/(2*fsw)*n2overn1^2; % page 272 eqn 7-12

delta_iLm =  ILm_max-ILm_min;
%Lm_reasonable = Vs*D/(delta_iLm*fsw); bu form�le bir bakal�m sonra