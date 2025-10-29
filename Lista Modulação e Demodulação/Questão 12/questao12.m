% Questão 12

time=.3; Ts=1/10000;                        % sampling interval and time base
t=Ts:Ts:time; lent=length(t);               % define a "time" vector
fc=1000;
c1=cos(2*pi*fc*t);                          % define the carrier 1 at freq fc
c2=sin(2*pi*fc*t);                          % define the carrier 2 at freq fc
fm=20;
w1=5/lent*(1:lent)+cos(2*pi*fm*t);          % create "message 1"
w2=2.5/lent*(1:lent)+cos(2*pi*fm*t);        % create "message 2"
#plot(t,w1,'-r',t,w2,'-b')
v1=c1.*w1;                                     % modulate with carrier 1
v2=c2.*w2;                                     % modulate with carrier 2

v=v1-v2

#{
figure(1)
subplot(2,1,1)
plot(t,w1,'-r',t,v1,'-b')
ylim([-6 6])
subplot(2,1,2)
plot(t,w2,'-r',t,v2,'-b')
ylim([-6 6])

figure(2)
plot(t,v,'-r')
ylim([-6 6])
#}

gamma=0; phi=-pi/6;                             % freq & phase offset
x1 = v.*cos(2*pi*(fc+gamma)*t+phi)
x2 = v.*sin(2*pi*(fc+gamma)*t+phi)

fbe=[0 0.2 0.3 1]; damps=[1 1 0 0]; fl=100; % low pass filter design
b=remez(fl,fbe,damps);                      % impulse response of LPF
m1=2*filter(b,1,x1);                        % LPF the demodulated signal
m2=2*filter(b,1,x2);                        % LPF the demodulated signal

#{
figure(1),plotspec(w1,Ts)
figure(2),plotspec(w2,Ts)
figure(3),plotspec(v1,Ts)
figure(4),plotspec(v2,Ts)
figure(5),plotspec(v,Ts)
figure(6),plotspec(x1,Ts)
figure(7),plotspec(x2,Ts)
figure(8),plotspec(m1,Ts)
figure(9),plotspec(m2,Ts)
#}

#plotspec(w1,Ts)
#plotspec(w2,Ts)

#{
figure(1)
plot(t,w1,'-r',t,w2,'-b')
title('mensagens originais')
xlabel('segundos')
ylabel('amplitude')
legend('m1','m2')
#}

#
figure(2)
plot(t,m1,'-r',t,-m2,'-b')
title('mensagens recuperadas com desvio de frequência = 0 Hz e de fase = -pi/6 rad')
xlabel('segundos')
ylabel('amplitude')
legend('m1','m2')
#

#{
[h t_h] = impz(b,1)
f_h = (-length(h)/2:length(h)/2-1)*(Fs/length(h))
ffth_amp = abs(circshift(fft(h),ceil(length(h)/2)))
subplot(2,1,1)
plot(t_h,h)
subplot(2,1,2)
plot(f_h,ffth_amp)
#}

#{
% used to plot figure
subplot(4,1,1), plot(t,w)
axis([0,0.1, -1,3])
ylabel('amplitude'); title('(a) message signal');
subplot(4,1,2), plot(t,v)
axis([0,0.1, -2.5,2.5])
ylabel('amplitude'); title('(b) message after modulation');
subplot(4,1,3), plot(t,x)
axis([0,0.1, -1,3])
%hold on; plot(t,m,'r'); hold off
%xlabel('seconds');
ylabel('amplitude');
title('(c) demodulated signal');
subplot(4,1,4), plot(t,m)
axis([0,0.1, -1,3])
ylabel('amplitude'); title('(d) recovered message is a LPF applied to (c)');
#}
