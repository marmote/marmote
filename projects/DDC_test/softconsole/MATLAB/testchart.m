DSPconf = GetDSPConfig();

TIME_STAMP          = DSPconf.TIME_STAMP;
BUFF_MULTIPLIER     = DSPconf.BUFF_MULTIPLIER;
BUFF_LENGTH         = DSPconf.BUFF_LENGTH;
N                   = DSPconf.N;
Fs                  = DSPconf.Fs;
T                   = DSPconf.T;
Full_Scale          = DSPconf.Full_Scale;

TS_history = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%gen_f = 100000; % [Hz]
gen_f = Fs/10; % [Hz]
gen_A = 1; %
gen_phi = 0; % [rad]

t = 0:T:T*(N-1);

c1 = gen_A*cos(2*pi()*gen_f*t + gen_phi);
%c2 = -c1/2; 
c2 = gen_A*sin(2*pi()*gen_f*t + gen_phi);

c1 = c1 * Full_Scale;
c2 = c2 * Full_Scale;

c1 = typecast(int32(c1), 'uint32');
c2 = typecast(int32(c2), 'uint32');

c1 = bitand(c1, hex2dec('FFFF'));
c2 = bitand(c2, hex2dec('FFFF'));

c = [];
c = bitor(bitshift(c1,16), c2);

chunk = [];
if TIME_STAMP == 1
    TS_tmp = 1:BUFF_MULTIPLIER;

    c_tmp = [];
    for ii=1:BUFF_MULTIPLIER
        c_tmp = [c_tmp ii c((ii-1)*(BUFF_LENGTH-1)+1:ii*(BUFF_LENGTH-1))];
    end
    
    chunk = c_tmp;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig_handle = figure;

    [ TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft ] = processing( DSPconf, chunk, TS_history );

    drawchart( fig_handle, DSPconf, TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft);
