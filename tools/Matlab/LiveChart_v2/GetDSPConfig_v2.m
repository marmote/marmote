function conf = GetDSPConfig_v2()
%WRITECONFIG Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial variables
conf.START_OF_FRAME_HEX = ['A1'; 'BE'; 'AF'; '01'];

conf.N                  = 300; %

conf.Fs                 = 24e6 / 32; % [Hz] = 750 kHz
conf.F_offset           = 0; % [Hz]
conf.Resolution         = 16; % bits


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculated variables
conf.START_OF_FRAME = hex2dec(conf.START_OF_FRAME_HEX)';

%conf.F = conf.Fs / conf.N;
conf.T = 1/conf.Fs;

conf.Full_Scale = 2^(conf.Resolution-1) - 1;
conf.Full_Scale_dB = 20 * log10(2^conf.Resolution);
