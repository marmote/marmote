BUFF_LENGTH = 256;

Fs = 10e6 / 18; % [Hz] = 2.778 MHz
F_offset = 0; % [Hz]
Resolution = 14; % bits

N = BUFF_LENGTH;
%F = Fs / N;
T = 1/Fs;

Full_Scale = 2^Resolution - 1;
%Full_Scale_dB = 20 * log10(Full_Scale);

%%%%%%%%%%%%%%%%%%%
gen_f = 15e4; % 0.1 MHz
gen_A = 1; %
gen_phi = 0; % [rad]

t = 0:T:T*(BUFF_LENGTH-1);

chunk1 = gen_A*sin(2*pi()*gen_f*t + gen_phi);
%chunk2 = -chunk1/Full_Scale; 
chunk2 = -chunk1/2; 

chunk1 = ( chunk1 +1 ) * Full_Scale/2;
chunk2 = ( chunk2 +1 ) * Full_Scale/2;
%%%%%%%%%%%%%%%%%%%%%%%%


chunk1 = chunk1/(Full_Scale/2) - 1;
chunk2 = chunk2/(Full_Scale/2) - 1;
   
chunk1fft = 2*abs(fft(chunk1));
chunk2fft = 2*abs(fft(chunk2));

chunk1fft(end/2:end) = [];
chunk2fft(end/2:end) = [];
    
chunk1fft = chunk1fft / N;
chunk2fft = chunk2fft / N;

chunk1fft = 20 * log10(chunk1fft);
chunk2fft = 20 * log10(chunk2fft);

drawchart(Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft);
