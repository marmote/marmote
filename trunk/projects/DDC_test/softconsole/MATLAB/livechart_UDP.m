setvariables();

TOTAL_BUFF_LENGTH = BUFF_MULTIPLIER * BUFF_LENGTH;


RFFrequency = uint32(433e6); %Hz
DC_Offset_I = int16(0);
DC_Offset_Q = int16(0);
DDCFrequency = int32(0); %Hz
Shift = uint8(4);

screen_refresh_rate = 10; %in frame per secs

TS_history = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open UDP connection. 
disp('Opening UDP connection');

% Create TCP/IP object 't'. Specify server machine and port number. 
u = udp('192.168.1.2', 49151);%, 'LocalPort', 49152);
%set(u,'Timeout', 3*READ_TIME) 
set(u,'Timeout', 0.001 + 0.0002);

% Set size of receiving buffer, if needed. 
set(u, 'InputBufferSize', 10 * BUFF_LENGTH * 32/8); 
set(u, 'DatagramTerminateMode', 'on'); 

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

temp = uint8(zeros( 1, BUFF_LENGTH*32/8 ));
%if TIME_STAMP == 1
%    chunk = zeros( 1, (BUFF_LENGTH-1)*BUFF_MULTIPLIER );
%    accum = zeros( 1, (BUFF_LENGTH-1)*(BUFF_MULTIPLIER+1) );
%else
    chunk = uint32(zeros( 1, TOTAL_BUFF_LENGTH ));
    accum = uint32(zeros( 1, TOTAL_BUFF_LENGTH ));
%end
accum_length = 0;

    fid = fopen('C:\Users\babjak\Desktop\logfile.txt', 'w');
    fclose(fid);

% Receive lines of data from server 
while (1) 
    
    fwrite(u, int8([1 1]), 'int8');

%Read data
    for ii=(1:5)
        temp = uint8(fread(u, BUFF_LENGTH*32/8, 'uint8'));
    
        temp_length = length(temp)*8/32;    
    
        if temp_length >= BUFF_LENGTH
            break;
        end
        
        disp('UNDERRUN!');
        disp(['temp_length in bytes: ' num2str(temp_length*32/8)]);
        disp(['temp_length: ' num2str(temp_length)]);
    end
    
    if temp_length < BUFF_LENGTH
        continue;
    end
    
    
    fid = fopen('C:\Users\babjak\Desktop\logfile.txt', 'a');
    fwrite(fid, temp);
    fclose(fid);
    
    accum(accum_length+1:accum_length+temp_length) = typecast(temp, 'uint32')';
    accum_length = accum_length + temp_length; 

    if (accum_length < BUFF_LENGTH*BUFF_MULTIPLIER)
        continue;
    end    
    
    chunk = accum;

    [ TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk, TS_history );

    drawchart(TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, TS, TS_history, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft);
    
    accum_length = 0;
end

% Disconnect and clean up the server connection. 
fclose(u); 
delete(u); 
clear u; 
