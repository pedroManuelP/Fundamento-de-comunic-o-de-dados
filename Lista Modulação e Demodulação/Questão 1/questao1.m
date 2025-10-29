% Questão 1
#{
fs = 32000
Ts = 1/fs
T = 1
t = 0:1/fs:T-Ts
N = length(t)

# Portadoras separadas por 1kHz
fc1 = 10000
fc2 = fc1 + 1000
carrier1 = cos(2*pi*fc1*t)
carrier2 = cos(2*pi*fc2*t)
#

#
# Sinal modulante e modulação da letra a
f1 = 0
f2 = 100
f3 = 200
w = 0.5*cos(2*pi*f1*t) + 0.3*cos(2*pi*f2*t) + 0.2*cos(2*pi*f3*t)

v1 = w.*carrier1
v2 = w.*carrier2

f = (-N/2:N/2-1)*(fs/N)
fftv1 = abs(circshift(fft(v1),ceil(N/2)))
fftv2 = abs(circshift(fft(v2),ceil(N/2)))
#

#
# Sinal modulante e modulação da letra b
f1 = 0
f2 = 1000
f3 = 2000
w = 0.5*cos(2*pi*f1*t) + 0.3*cos(2*pi*f2*t) + 0.2*cos(2*pi*f3*t)

v1 = w.*carrier1
v2 = w.*carrier2

fftv1 = abs(circshift(fft(v1),ceil(N/2)))
fftv2 = abs(circshift(fft(v2),ceil(N/2)))
#}

#
plot(f,fftv1,'-b',"linewidth",2,f,fftv2,'-r',"linewidth",2)
title("Espectros para as modulações com o sinal de banda 2 kHz")
xlabel("Frequência(Hz)")
xlim([0 fs/2])
ylabel("Magnitude")
legend("Portadora de 10kHz","Portadora de 11kHz","FontSize",15)
grid on
#
