N1 = 50;
N2 = 25;
estimate_cablelength1 = (17e-3+24.65e-3)*2*N1;
estimate_cablelength2 = (17e-3+24.65e-3)*2*N2;
resistivity = 1.68e-8;
rLm1 = resistivity*estimate_cablelength1*1.1/(pi*(1.29e-3/2)^2);
rLm2 = resistivity*estimate_cablelength2*1.1/(pi*(2.3e-3/2)^2);
rLm = rLm2;
Lm = 3.24e-4;
C = 1000e-6;
Rload = 1.8;
rC = 0.22;

%% when S in on
A1 = [-rLm/Lm 0;0 -1/(C*(rC+Rload))];
B1 = [1/Lm; 0];
C1 = [0 Rload/(Rload+rC)];
D1 = 0;
%% when S is off
A2 = [-(rC*rLm+Rload*rC+rLm*Rload)/(Lm*(rC+Rload)) -Rload/(Lm*(rC+Rload)); ...
    Rload/(C*(rC+Rload)) -1/(C*(rC+Rload))];
B2 = [0 0]';
C2 = [Rload*rC/(Rload+rC) Rload/(Rload+rC)];
D2 = 0;
%% averaging
d = 0.5;
A = d*A1 + (1-d)*A2;
B = d*B1 + (1-d)*B2;
C = d*C1 + (1-d)*C2;
D = 0;
[la le] = ss2tf(A,B,C,D);
step(ss2tf(A,B,C,D));
sistem = ss(A,B,C,D)
impulse(sistem)