%фильтр нижних частот
clear;

% создадим исследуемый сигнал
fc = [400 1000 1900];
fs = 48000;
N = 12000;
t = (0:N)'/fs;

y = cos(2*pi*t*fc);
a = [0.4 0.25 0.15]; %коэф. амплитуд
z = y*a';
subplot(2,2,1);
plot(t,z)
title("Входной сигнал");

Z = fft(z); %преобразование фурье
F = (0:N)'/N*fs;
subplot(2,2,2);
plot(F,abs(Z))
title("Спектр входного сигнала");


%спроектируем фильтр в filter design
% All frequency values are in Hz.
Fs = 48000;  % Sampling Frequency

Fpass = 500;     % Passband Frequency
Fstop = 900;     % Stopband Frequency
Apass = 1;       % Passband Ripple (dB)
Astop = 80;      % Stopband Attenuation (dB)
match = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'ellip', 'MatchExactly', match);


%фильтрация
zfilt = filter(Hd, z);
ZF = fft(zfilt);
subplot(2,2,3);
plot(t,zfilt)
title("Выходной сигнал");
subplot(2,2,4);
plot(F,abs(ZF));
title("Спектр выходного сигнала");
