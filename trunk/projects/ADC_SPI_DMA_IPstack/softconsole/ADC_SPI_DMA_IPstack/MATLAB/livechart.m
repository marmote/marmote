BUFF_LENGTH = 256;

Fs = 50e6 / 18; % [Hz] = 2.778 MHz
F_offset = 0; % [Hz]
Resolution = 14; % bits

%N = BUFF_LENGTH;
%F = Fs / N;
%T = 1/Fs;

Full_Scale = 2^Resolution - 1;
%Full_Scale_dB = 10 * log10(Full_Scale);

disp('Opening TCPIP connection');

% Create TCP/IP object 't'. Specify server machine and port number. 
t = tcpip('192.168.1.2', 49151);

% Set size of receiving buffer, if needed. 
set(t, 'InputBufferSize', BUFF_LENGTH*32/8); 

% Open connection to the server. 
fopen(t); 

% Pause for the communication delay, if needed. 
pause(0.05) 

% Receive lines of data from server 
while (1) 
    if (get(t, 'BytesAvailable') == 0) 
        continue;
    end
    if (t.BytesAvailable < BUFF_LENGTH*32/8)
        continue;
    end
    
    chunk = fread(t, BUFF_LENGTH, 'uint32'); 

    chunk1 = fix( chunk / 2^16 ); %upper 16 bits
    chunk2 = rem( chunk, 2^16 ); %lower 16 bits

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
    
    pause(.001);
end

% Disconnect and clean up the server connection. 
fclose(t); 
delete(t); 
clear t; 
