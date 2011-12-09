setvariables();

RFFrequency = uint32(433e6); %Hz
DC_Offset_I = int16(0);
DC_Offset_Q = int16(0);
DDCFrequency = int32(1); %Hz
Shift = uint8(0);


screen_refresh_rate = 8; %in frame per secs


NETWORK_BUFF_MULTIPLIER = (1/screen_refresh_rate)/T/BUFF_LENGTH; %The number of buffers that arrive between two consecutive screen refreshes
%NETWORK_BUFF_MULTIPLIER = round(NETWORK_BUFF_MULTIPLIER/20); %We'll take a part of that value, and read more often, rather than to have a huge buffer
NETWORK_BUFF_MULTIPLIER = 1;
TOTAL_BUFF_LENGTH       = BUFF_LENGTH * NETWORK_BUFF_MULTIPLIER; %In samples
READ_TIME               = T * TOTAL_BUFF_LENGTH; %At least this much time will be needed to fill the buffer


TS_history = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open UDP connection. 
disp('Opening UDP connection');

data = [typecast(swapbytes(RFFrequency),'int8') ...
        typecast(swapbytes(DC_Offset_I),'int8') ... 
        typecast(swapbytes(DC_Offset_Q),'int8') ... 
        typecast(swapbytes(DDCFrequency),'int8') ... 
        typecast(swapbytes(Shift),'int8')];
local_port = judp('send','192.168.1.2',49151, data);



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

%Read data    
    temp = swapbytes(uint32(judp('receive',local_port,TOTAL_BUFF_LENGTH*32/8)));
    
    temp_length = length(temp);
    
    if temp_length < TOTAL_BUFF_LENGTH
%        disp('UNDERRUN!');
        disp(temp_length);
        
%        continue;
    end
    
    accum(accum_length+1:accum_length+temp_length) = temp';
    accum_length = accum_length + temp_length; 

%Do we have enough data yet?    
    if (accum_length < BUFF_LENGTH*BUFF_MULTIPLIER)
        continue;
    end
        
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

% Disconnect and clean up the server connection. 
release(hudps);
release(hudpr);
