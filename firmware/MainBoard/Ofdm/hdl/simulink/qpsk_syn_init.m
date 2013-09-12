disp('Initializing QPSK modulator parameters...')

qpsk_syn_params.gauss_oversampling = 8;
qpsk_syn_params.CL = 20; % Chip length in samples
qpsk_syn_params.EbN0 = 10;
qpsk_syn_params.Ts = 1/20e6;
qpsk_syn_params.Tc = qpsk_syn_params.Ts * qpsk_syn_params.CL; % Chip time
qpsk_syn_params.bps = 2; % Bits per symbol (2 for QPSK)