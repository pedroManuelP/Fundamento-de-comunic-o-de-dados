% Questão 7
% AMlarge.m: large carrier AM demodulated with "envelope"
time=.08; Ts=1/10000;                           % sampling interval and time
t=0:Ts:time; lent=length(t);                    % define a "time" vector

fc=1000; phi=0; g=0; c=cos(2*pi*(fc+g)*t + phi);  % define carrier at freq fc
#fm=20; w=10/lent*[1:lent]+cos(2*pi*fm*t);       % create "message" > -1
fm=20; w=1+cos(2*pi*fm*t);                     % create "message" > -1
v=c.*w+c;                                      % modulate with large carrier
fbe=[0 0.1 0.2 1]; damps=[1 1 0 0]; fl=100;    % low pass filter design
b=remez(fl,fbe,damps);                         % impulse response of LPF
envv=(pi/2)*filter(b,1,abs(v));                % find envelope

% generate the figure
figure(1)
#subplot(4,1,1)
plot(t,1+w,'-r',t,v,'-g',t-0.005,envv,'-b')
legend("message","modulated","output of envelope detector")
ylabel('amplitude'); title('(a) signals');
#ylabel('amplitude'); title('(a) message signal');
#axis([0,0.08, -1,4])
xlim([-0.02 0.1])
#{
subplot(4,1,2), plot(t,c)
ylabel('amplitude'); title('(b) carrier');
axis([0,0.08, -1.5,1.5])
#}
#subplot(4,1,3), plot(t,v)
#ylabel('amplitude'); title('(c) modulated signal');
#axis([0,0.08, -3,4])
#subplot(4,1,4), plot(t,envv)
#ylabel('amplitude'); title('(d) output of envelope detector');
#axis([0,0.08, -1,4])
#xlabel('seconds');
