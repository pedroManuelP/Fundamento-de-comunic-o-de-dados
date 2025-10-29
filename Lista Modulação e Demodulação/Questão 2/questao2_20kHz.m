% Questão 2
time=3;                                 % length of time
Ts=1/20000;                             % time interval between samples
x=randn(1,time/Ts);                     % generate noise signal
figure(1),plotspec(x,Ts)                % draw spectrum of input

flp_corte = 3000
b=remez(300,[0 (flp_corte*2*Ts) 1.05*(flp_corte*2*Ts) 1],[1 1 0 0]);  % specify the LP filter
ylp=filter(b,1,x);                      % do the filtering
figure(2),plotspec(ylp,Ts)              % plot the output spectrum

fsp_corte1 = 1500
fsp_corte2 = 2500
b=remez(500,[0 (fsp_corte1*2*Ts) 1.05*(fsp_corte1*2*Ts) (fsp_corte2*2*Ts) 1.05*(fsp_corte2*2*Ts) 1],[1 1 0 0 1 1]); % SP filter
ysp=filter(b,1,x);                      % do the filtering
figure(3),plotspec(ysp,Ts)              % plot the output spectrum

fhp_corte = 500
b=remez(1100,[0 (fhp_corte*2*Ts) 1.05*(fhp_corte*2*Ts) 1],[0 0 1 1]); % specify the HP filter
yhp=filter(b,1,x);                      % do the filtering
figure(4),plotspec(yhp,Ts)              % plot the output spectrum
