function conf = GetDSPConfig()
%WRITECONFIG Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial variables
conf.TIME_STAMP         = 1;
conf.BUFF_MULTIPLIER	= 3; % How many buffers would you like to read from network?

conf.BUFF_LENGTH        = 128; % in samples for a single channel

%conf.Fs                 = 50e6 / 18 / 4; % [Hz] = 2*347.2 kHz
conf.Fs                 = 24e6 / 32; % [Hz] = 750 kHz
conf.F_offset           = 0; % [Hz]
conf.Resolution         = 16; % bits


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculated variables
if conf.TIME_STAMP == 1
    conf.N = (conf.BUFF_LENGTH-1) * conf.BUFF_MULTIPLIER;
else
    conf.N = conf.BUFF_LENGTH * conf.BUFF_MULTIPLIER;
end
conf.F = conf.Fs / conf.N;
conf.T = 1/conf.Fs;

conf.num_pos_fr = round(conf.N/2); %positive and zero frequency bins
conf.num_neg_fr = conf.N - conf.num_pos_fr; %negative frequency bins

conf.Full_Scale = 2^(conf.Resolution-1) - 1;
conf.Full_Scale_dB = 20 * log10(2^conf.Resolution);
