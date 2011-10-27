setvariables();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open UDP connection. 
disp('Opening UDP connection');

% Create TCP/IP object 't'. Specify server machine and port number. 
u = udp('192.168.1.2', 49151);%, 'LocalPort', 49152);
set(u,'Timeout',10) 

%rec_buff_size = BUFF_LENGTH*BUFF_MULTIPLIER*32/8;
% Set size of receiving buffer, if needed. 
%set(t, 'InputBufferSize', 20*rec_buff_size); 

% Open connection to the server. 
fopen(u); 

% Pause for the communication delay, if needed. 
%pause(0.05) 

fwrite(u, 0, 'int32');

elapsed_time = 0;
ticID = tic;

ii = 0;

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
    temp = swapbytes(int32(fread(u, BUFF_LENGTH, 'int32')));
    
    temp_length = length(temp);
    
%    if temp_length < BUFF_LENGTH
%        disp(temp_length);
%    end
    
%    if TIME_STAMP == 1
%        accum(accum_length+1:accum_length+(temp_length-1)) = temp(2:end)';
%         accum_length = accum_length + temp_length - 1;
%         
%         if accum_length < (BUFF_LENGTH-1)*BUFF_MULTIPLIER
%             continue;
%         end
%         
%         chunk = accum( 1:(BUFF_LENGTH-1)*BUFF_MULTIPLIER );        
%     else
        accum(accum_length+1:accum_length+temp_length) = temp';
        accum_length = accum_length + temp_length;

        if accum_length < BUFF_LENGTH*BUFF_MULTIPLIER
            continue;
        end
        
        chunk = accum( 1:BUFF_LENGTH*BUFF_MULTIPLIER );
%    end
        
    accum(1:accum_length - BUFF_LENGTH*BUFF_MULTIPLIER) = accum( BUFF_LENGTH*BUFF_MULTIPLIER + 1 : accum_length );

    accum_length = accum_length - BUFF_LENGTH*BUFF_MULTIPLIER;
    
%    chunk = fread(u, BUFF_LENGTH*BUFF_MULTIPLIER, 'uint32');
    
    elapsed_time = elapsed_time + toc(ticID);
    ticID = tic;    
    
%    if (elapsed_time >= 2)
        [ TS, chunk1, chunk2, chunk1fft, chunk2fft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk );

        drawchart(TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, TS, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft);
        
        elapsed_time = 0;
%    end
end

% Disconnect and clean up the server connection. 
fclose(u); 
delete(u); 
clear u; 
