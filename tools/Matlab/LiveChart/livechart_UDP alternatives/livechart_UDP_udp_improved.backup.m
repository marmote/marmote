setvariables();

RFFrequency = uint32(433e6); %Hz
DC_Offset_I = int16(0);
DC_Offset_Q = int16(0);
DDCFrequency = int32(1); %Hz
Shift = uint8(0);


screen_refresh_rate = 10; %in frame per secs


NETWORK_BUFF_MULTIPLIER = (1/screen_refresh_rate)/T/BUFF_LENGTH; %The number of buffers that arrive between two consecutive screen refreshes
%NETWORK_BUFF_MULTIPLIER = round(NETWORK_BUFF_MULTIPLIER/20); %We'll take a part of that value, and read more often, rather than to have a huge buffer
NETWORK_BUFF_MULTIPLIER = 3;
TOTAL_BUFF_LENGTH       = BUFF_LENGTH * NETWORK_BUFF_MULTIPLIER; %In samples
READ_TIME               = T * TOTAL_BUFF_LENGTH; %At least this much time will be needed to fill the buffer


TS_history = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open UDP connection. 
disp('Opening UDP connection');

% Create TCP/IP object 't'. Specify server machine and port number. 
u = udp('192.168.1.2', 49151);%, 'LocalPort', 49152);
%set(u,'Timeout', 3*READ_TIME) 
set(u,'Timeout', 0.003);

% Set size of receiving buffer, if needed. 
set(u, 'InputBufferSize', 10*TOTAL_BUFF_LENGTH * 32/8); 
set(u, 'DatagramTerminateMode', 'off'); 

% Open connection to the server. 
fopen(u); 

% Pause for the communication delay, if needed. 
%pause(0.05)

data = [int8(0) ...
        typecast(swapbytes(RFFrequency),'int8') ...
        typecast(swapbytes(DC_Offset_I),'int8') ... 
        typecast(swapbytes(DC_Offset_Q),'int8') ... 
        typecast(swapbytes(DDCFrequency),'int8') ... 
        typecast(swapbytes(Shift),'int8')];
    
fwrite(u, data, 'int8');

%buffer = [RFFrequency DC_Offset_I DC_Offset_Q DDCFrequency Shift];
%fwrite(u, buffer, '13*uint8');


elapsed_time = 0;
ticID = tic;

temp = zeros( 1, TOTAL_BUFF_LENGTH );
%if TIME_STAMP == 1
%    chunk = zeros( 1, (BUFF_LENGTH-1)*BUFF_MULTIPLIER );
%    accum = zeros( 1, (BUFF_LENGTH-1)*(BUFF_MULTIPLIER+1) );
%else
    chunk = zeros( 1, BUFF_LENGTH*BUFF_MULTIPLIER );
    accum = zeros( 1, 2*TOTAL_BUFF_LENGTH );
%end
accum_length = 0;

% Receive lines of data from server 
while (1) 
    fwrite(u, int8([1 NETWORK_BUFF_MULTIPLIER]), 'int8');

    while (accum_length < BUFF_LENGTH*BUFF_MULTIPLIER)
%Read data    
        temp = swapbytes(uint32(fread(u, TOTAL_BUFF_LENGTH, 'uint32')));
    
        temp_length = length(temp);
    
        if temp_length < TOTAL_BUFF_LENGTH
%        disp('UNDERRUN!');
%            disp(['temp_length: ' num2str(temp_length)]);
%            disp(['accum_length: ' num2str(accum_length)]);
        
%        continue;
        end
    
        accum(accum_length+1:accum_length+temp_length) = temp';
        accum_length = accum_length + temp_length; 
        
        disp(['temp_length: ' num2str(temp_length)]);
        disp(['accum_length: ' num2str(accum_length)]);
    end
%Do we have enough data yet?    
%    if (accum_length < BUFF_LENGTH*BUFF_MULTIPLIER)
%        continue;
%    end
        
    while (accum_length >= BUFF_LENGTH*BUFF_MULTIPLIER)

        remaining_samples = mod(accum_length, BUFF_LENGTH*BUFF_MULTIPLIER);
    
%Did enough time pass by? Is it time for a screen refresh?
        elapsed_time = elapsed_time + toc(ticID);
        ticID = tic;    
    
        if (elapsed_time >= 1/screen_refresh_rate)
            chunk = accum( accum_length-remaining_samples-BUFF_LENGTH*BUFF_MULTIPLIER+1 : accum_length-remaining_samples );

        
            [ TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk, TS_history );

            drawchart(TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, TS, TS_history, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft);
        
            elapsed_time = 0;
        end

%Throw old data from accumulator
%    remaining_samples = mod(accum_length, BUFF_LENGTH*BUFF_MULTIPLIER);

        accum(1:remaining_samples) = accum( accum_length-remaining_samples+1 : accum_length );
        accum_length = remaining_samples;    
    end
    
end

% Disconnect and clean up the server connection. 
fclose(u); 
delete(u); 
clear u; 
