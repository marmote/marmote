screen_refresh_rate = 5; %in frame per secs

setvariables();

RFFrequency = 432e6; %Hz
DC_Offset_I = 10;
DC_Offset_Q = -10;
DDCFrequency = 200e3; %Hz
Shift = 3;


TS_history = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open UDP connection. 
disp('Opening UDP connection');

% Create TCP/IP object 't'. Specify server machine and port number. 
u = udp('192.168.1.2', 49151);%, 'LocalPort', 49152);
%set(u,'Timeout',90.0005) 

rec_buff_size = BUFF_LENGTH*BUFF_MULTIPLIER*32/8;
% Set size of receiving buffer, if needed. 
set(u, 'InputBufferSize', 2*rec_buff_size); 
set(u, 'DatagramTerminateMode', 'off'); 

% Open connection to the server. 
fopen(u); 

% Pause for the communication delay, if needed. 
%pause(0.05)

fwrite(u, RFFrequency, 'uint32');
fwrite(u, DC_Offset_I, 'int16');
fwrite(u, DC_Offset_Q, 'int16');
fwrite(u, DDCFrequency, 'int32');
fwrite(u, Shift, 'uint8');

%buffer = [RFFrequency DC_Offset_I DC_Offset_Q DDCFrequency Shift];
%fwrite(u, buffer, '13*uint8');


elapsed_time = 0;
ticID = tic;

temp = zeros( 1, BUFF_LENGTH );
%if TIME_STAMP == 1
%    chunk = zeros( 1, (BUFF_LENGTH-1)*BUFF_MULTIPLIER );
%    accum = zeros( 1, (BUFF_LENGTH-1)*(BUFF_MULTIPLIER+1) );
%else
    chunk = zeros( 1, BUFF_LENGTH*BUFF_MULTIPLIER );
    accum = zeros( 1, BUFF_LENGTH*(BUFF_MULTIPLIER+1) );
%end
accum_length = 0;

% Receive lines of data from server 

while (1) 
%    BytesAvailable = get(t, 'BytesAvailable');
%    if (BytesAvailable < rec_buff_size)
%        continue;
%    end

    temp = swapbytes(uint32(fread(u, 3*BUFF_LENGTH, 'uint32')));
    
    temp_length = length(temp);
    
    if temp_length < BUFF_LENGTH
%         disp('UNDERRUN!');
%         disp(temp_length);
        
        continue;
    end
    
    accum(accum_length+1:accum_length+temp_length) = temp';
    accum_length = accum_length + temp_length;

    while (accum_length >= BUFF_LENGTH*BUFF_MULTIPLIER)
        
        chunk = accum( 1:BUFF_LENGTH*BUFF_MULTIPLIER );

    
        accum(1:accum_length - BUFF_LENGTH*BUFF_MULTIPLIER) = accum( BUFF_LENGTH*BUFF_MULTIPLIER + 1 : accum_length );

        accum_length = accum_length - BUFF_LENGTH*BUFF_MULTIPLIER;
    
        elapsed_time = elapsed_time + toc(ticID);
        ticID = tic;    
    
        if (elapsed_time < 1/screen_refresh_rate)
            continue;
        end
        
        [ TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk, TS_history );

        drawchart(TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, TS, TS_history, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft);
        
        elapsed_time = 0;
    end
end

% Disconnect and clean up the server connection. 
fclose(u); 
delete(u); 
clear u; 
