% Questão 8

% AM.m suppressed carrier AM with freq and phase offset
time=.3; Ts=1/10000;                        % sampling interval and time base
t=Ts:Ts:time; lent=length(t);               % define a "time" vector
fc=1000; c=cos(2*pi*fc*t);                  % define the carrier at freq fc
fm=20; w=5/lent*(1:lent)+cos(2*pi*fm*t);    % create "message"
v=c.*w;

gamma=0; phi=-pi;                             % freq & phase offset
c2=cos(2*pi*(fc+gamma)*t+phi);              % create cosine for demod
x=v.*c2;                                    % demod received signal
fbe=[0 0.1 0.2 1]; damps=[1 1 0 0]; fl=100; % low pass filter design
b=remez(fl,fbe,damps);                      % impulse response of LPF
m=2*filter(b,1,x);                          % LPF the demodulated signal

#{
f = (-lent/2:lent/2-1)*(1/(Ts*lent))
fftw_amp = abs(circshift(fft(w),ceil(lent/2)))
fftv_amp = abs(circshift(fft(v),ceil(lent/2)))
fftx_amp = abs(circshift(fft(x),ceil(lent/2)))
fftm_amp = abs(circshift(fft(m),ceil(lent/2)))
#}

plot(t,w,'-r','linewidth',2,t,m,'-g','linewidth',2)
legend("mensagem","envelope")
xlabel('tempo(s)')
ylabel('amplitude')
title('fase phi = -pi')

#{
% used to plot figure
subplot(4,1,1), plot(f,fftw_amp)
#axis([0,0.1, -1,3])
xlim([-5000 5000])
ylabel('amplitude'); title('(a) message signal');

subplot(4,1,2), plot(f,fftv_amp)
#axis([0,0.1, -2.5,2.5])
xlim([-5000 5000])
ylabel('amplitude'); title('(b) message after modulation');

subplot(4,1,3), plot(f,fftx_amp)
#axis([0,0.1, -1,3])
%hold on; plot(t,m,'r'); hold off
%xlabel('seconds');
xlim([-5000 5000])
ylabel('amplitude'); title('(c) demodulated signal');

#subplot(4,1,4)
plot(f,fftm_amp)
#axis([0,0.1, -2,2])
xlim([-5000 5000])
ylim([0 8000])
ylabel('amplitude'); title('(d) recovered message is a LPF applied to (c)');
#}
