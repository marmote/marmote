gmsk_syn_params.gauss_oversampling = 8;
gmsk_syn_params.interpolation_factor = 1;
gmsk_syn_params.EbN0 = 10;
gmsk_syn_params.Ts = 1/20e6;
gmsk_syn_params.sin_lut_length = 64;

gmsk_syn_params.symbol_time = gmsk_syn_params.gauss_oversampling * gmsk_syn_params.interpolation_factor; % in Ts

sync_pattern = dec2bin(hex2dec('70eed2'),23) - double('0');