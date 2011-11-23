screen_refresh_rate = 25; %in frame per secs

setvariables();

TS_history = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open file. 
f = fopen('C:\Users\babjak\Desktop\logfile.txt'); 

temp = zeros( 1, BUFF_LENGTH );
chunk = zeros( 1, BUFF_LENGTH*BUFF_MULTIPLIER );
accum = zeros( 1, BUFF_LENGTH*(BUFF_MULTIPLIER+1) );
accum_length = 0;

processed_buffers = 0;

while (1) 
    temp = fread(f, BUFF_LENGTH, 'uint32');

    temp_length = length(temp);
    
    if temp_length == 0
        disp('Processed:');
        disp([num2str(processed_buffers) ' buffers, '   num2str(processed_buffers*BUFF_LENGTH) ' samples']);
        disp('Left in accum:');
        disp([num2str(accum_length/BUFF_LENGTH) ' buffers, '  num2str(accum_length) ' samples']);
        break;
    end 
    
    accum(accum_length+1:accum_length+temp_length) = temp';
    accum_length = accum_length + temp_length;

    if accum_length < BUFF_LENGTH*BUFF_MULTIPLIER
        continue;
    end
        
    processed_buffers = processed_buffers + BUFF_MULTIPLIER;
    
    chunk = accum( 1:BUFF_LENGTH*BUFF_MULTIPLIER );

    accum(1:accum_length - BUFF_LENGTH*BUFF_MULTIPLIER) = accum( BUFF_LENGTH*BUFF_MULTIPLIER + 1 : accum_length );

    accum_length = accum_length - BUFF_LENGTH*BUFF_MULTIPLIER;
    
    
    [ TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk, TS_history );

    drawchart(TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, TS, TS_history, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft);
        
    pause(1/screen_refresh_rate);
end

% Disconnect and clean up the server connection. 
fclose(f); 
