%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial variables
TIME_STAMP = 1;
BUFF_MULTIPLIER = 3; % How many buffers would you like to read from network?

BUFF_LENGTH = 128; % in samples for a single channel

Fs = 50e6 / 18 / 4; % [Hz] = 347.2 kHz
F_offset = 0; % [Hz]
Resolution = 16; % bits


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculated variables
if TIME_STAMP == 1
    N = (BUFF_LENGTH-1)*BUFF_MULTIPLIER;
else
    N = BUFF_LENGTH*BUFF_MULTIPLIER;
end
F = Fs / N;
T = 1/Fs;

Full_Scale = 2^(Resolution-1) - 1;
Full_Scale_dB = 10 * log10(Full_Scale);