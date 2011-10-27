setvariables();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open connection to the server. 
disp('Opening TCPIP connection');

% Create TCP/IP object 't'. Specify server machine and port number. 
t = tcpip('192.168.1.2', 49151);

rec_buff_size = BUFF_LENGTH*BUFF_MULTIPLIER*32/8;
% Set size of receiving buffer, if needed. 
set(t, 'InputBufferSize', 20*rec_buff_size); 

% Open connection to the server. 
fopen(t); 

% Pause for the communication delay, if needed. 
%pause(0.05) 


elapsed_time = 0;
ticID = tic;

ii = 0;
% Receive lines of data from server 
while (1) 
%    if (get(t, 'BytesAvailable') == 0) 
%        continue;
%    end
    BytesAvailable = get(t, 'BytesAvailable');
    if (BytesAvailable < rec_buff_size)
        continue;
    end
    
    chunk = fread(t, BUFF_LENGTH*BUFF_MULTIPLIER, 'int32');
    
    elapsed_time = elapsed_time + toc(ticID);
    ticID = tic;    
    
    if (elapsed_time >= 0.08)
        [ TS, chunk1, chunk2, chunk1fft, chunk2fft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk );

        drawchart(TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, TS, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft);
        
        elapsed_time = 0;
    end
end

% Disconnect and clean up the server connection. 
fclose(t); 
delete(t); 
clear t; 
