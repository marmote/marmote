setvariables();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables
if TIME_STAMP == 1
    N = (BUFF_LENGTH-1)*BUFF_MULTIPLIER;
else
    N = BUFF_LENGTH*BUFF_MULTIPLIER;
end
%F = Fs / N;
T = 1/Fs;

Full_Scale = 2^Resolution - 1;
%Full_Scale_dB = 10 * log10(Full_Scale);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gen_f = 15e4; % 0.1 MHz
gen_A = 1; %
gen_phi = 0; % [rad]

t = 0:T:T*(N-1);

c1 = gen_A*sin(2*pi()*gen_f*t + gen_phi);
%chunk2 = -chunk1/Full_Scale; 
c2 = -c1/2; 

c1 = ( c1 +1 ) * Full_Scale/2;
c2 = ( c2 +1 ) * Full_Scale/2;

c = fix(c1) * 2^16 + fix(c2);

chunk = c;
if TIME_STAMP == 1
    TS_tmp = 1:BUFF_MULTIPLIER;

    c_tmp = [];
    for ii=1:BUFF_MULTIPLIER
        c_tmp = [c_tmp ii c((ii-1)*(BUFF_LENGTH-1)+1:ii*(BUFF_LENGTH-1))];
    end
    
    chunk = c_tmp;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ TS, chunk1, chunk2, chunk1fft, chunk2fft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk );

drawchart(TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, TS, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft);
