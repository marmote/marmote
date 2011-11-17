Fs = 1e6;
N = 5;

%f = 0;
%f = Fs/N;
f = 2*Fs/N;

T = 1/Fs;


t = (0:N-1)*T;
y = cos(2*pi()*f*t);
spectrum = abs(fft(y));

figure;
plot(y, '.-');
figure;
plot(spectrum, '.-');