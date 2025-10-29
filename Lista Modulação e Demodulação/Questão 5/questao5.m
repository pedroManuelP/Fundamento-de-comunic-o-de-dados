% Questão 5
% modulate.m: change the frequency of the input
time=.5; Ts=1/10000;                        % total time and sampling interval
t=Ts:Ts:time;                               % define a "time" vector
fc=1000; cmod=cos(2*pi*fc*t);               % create cos of freq fc

x = randn(1,length(t))

fp1 = 2000
fp2 = 2300
b = remez(400,[0 0.975*2*Ts*fp1 2*Ts*fp1 2*Ts*fp2 1.025*2*Ts*fp2 1],[0 0 1 1 0 0])

x = filter(b,1,x)

y=cmod.*x;                                  % multiply input by cmod
figure(1), plotspec(cmod,Ts)                % find spectra and plot
figure(2), plotspec(x,Ts)
figure(3), plotspec(y,Ts)

y_demod = cmod.*y
figure(4), plotspec(y_demod,Ts)

fp1 = 2000
fp2 = 2300
b = remez(400,[0 0.95*2*Ts*fp1 2*Ts*fp1 2*Ts*fp2 1.05*2*Ts*fp2 1],[0 0 1 1 0 0])

x_recuperado = filter(b,1,y_demod)
figure(5), plotspec(x_recuperado,Ts)
