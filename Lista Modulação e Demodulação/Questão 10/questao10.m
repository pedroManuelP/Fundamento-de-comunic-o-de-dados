% Questão 10[
#
Fs = 8000
Ts = 1/Fs
t = 0:Ts:1-Ts

N = length(t)
w_random =  randn(1,N)

b = remez(1200,[0 100*(2/Fs) 100*1.2*(2/Fs) 1],[1 1 0 0])
w = filter(b,1,w_random)      % mensagem para ser modulada
#figure(1),plotspec(w,Ts)

A0 = 1
f0 = 1000
v = w + A0*cos(2*pi*f0*t)
#figure(2),plotspec(v,Ts)

v_square = power(v,2)
#figure(3),plotspec(v_square,Ts)
#

#
b = remez(600,[0 0.9*(f0-100)*(2/Fs) 0.95*(f0-100)*(2/Fs) 1.05*(f0+100)*(2/Fs) 1.1*(f0+100)*(2/Fs) 1],[0 0 1 1 0 0])
w_modulado = filter(b,1,v_square)      % mensagem após filtro
#figure(4),plotspec(w_modulado,Ts)
#

#
gamma=0; phi=0;                             % freq & phase offset
c2=cos(2*pi*(f0+gamma)*t+phi);              % create cosine for demod
x=w_modulado.*c2;                                    % demod received signal
#figure(5),plotspec(x,Ts)
#

#
fbe=[0 100*(2/Fs) 2*100*(2/Fs) 1]; damps=[1 1 0 0]; fl=500; % low pass filter design
b=remez(fl,fbe,damps);                      % impulse response of LPF
m=2*filter(b,1,x);                          % LPF the demodulated signal
#figure(6),plotspec(m,Ts)
#}

figure(4),plotspec(w,Ts)
figure(5),plotspec(m,Ts)
figure(1),plot(t,w,'-r',t-0.07,-m/2-1,'-b','linewidth',1)
legend("mensagem","sinal recuperado")
xlim([0 1])
ylim([-1.75 0.75])

#{
[h t_h] = impz(b,1)
f_h = (-length(h)/2:length(h)/2-1)*(Fs/length(h))
ffth_amp = abs(circshift(fft(h),ceil(length(h)/2)))
subplot(2,1,1)
plot(t_h,h)
subplot(2,1,2)
plot(f_h,ffth_amp)
#}
