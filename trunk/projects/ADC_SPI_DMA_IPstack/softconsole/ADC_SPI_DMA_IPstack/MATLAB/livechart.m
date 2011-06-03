%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial variables
TIME_STAMP = 1;
BUFF_MULTIPLIER = 16; % How many buffers would you like to read from network?

BUFF_LENGTH = 64/2; % in samples for a single channel

Fs = 50e6 / 18; % [Hz] = 2.778 MHz
F_offset = 0; % [Hz]
Resolution = 14; % bits

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables
if TIME_STAMP == 1
    N = (BUFF_LENGTH-1)*BUFF_MULTIPLIER;
else
    N = BUFF_LENGTH*BUFF_MULTIPLIER;
end
%F = Fs / N;
%T = 1/Fs;

Full_Scale = 2^Resolution - 1;
%Full_Scale_dB = 10 * log10(Full_Scale);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp('Opening TCPIP connection');

% Create TCP/IP object 't'. Specify server machine and port number. 
t = tcpip('192.168.1.2', 49151);

% Set size of receiving buffer, if needed. 
set(t, 'InputBufferSize', BUFF_LENGTH*BUFF_MULTIPLIER*32/8); 

% Open connection to the server. 
fopen(t); 

% Pause for the communication delay, if needed. 
pause(0.05) 

% Receive lines of data from server 
while (1) 
    if (get(t, 'BytesAvailable') == 0) 
        continue;
    end
    if (t.BytesAvailable < BUFF_LENGTH*BUFF_MULTIPLIER*32/8)
        continue;
    end
    
    chunk = fread(t, BUFF_LENGTH*BUFF_MULTIPLIER, 'uint32');
    
    [ TS, chunk1, chunk2, chunk1fft, chunk2fft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk );

    drawchart(TIME_STAMP, TS, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft);
    
    pause(.001);
end

% Disconnect and clean up the server connection. 
fclose(t); 
delete(t); 
clear t; 
