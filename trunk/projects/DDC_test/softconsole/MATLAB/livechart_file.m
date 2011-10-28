setvariables();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open file. 
f = fopen('C:\Users\babjak\Desktop\logfile.txt'); 

temp = zeros( 1, BUFF_LENGTH );
chunk = zeros( 1, BUFF_LENGTH*BUFF_MULTIPLIER );
accum = zeros( 1, BUFF_LENGTH*(BUFF_MULTIPLIER+1) );
accum_length = 0;

while (1) 
    temp = fread(f, BUFF_LENGTH, 'uint32');

    temp_length = length(temp);
    
    accum(accum_length+1:accum_length+temp_length) = temp';
    accum_length = accum_length + temp_length;

    if accum_length < BUFF_LENGTH*BUFF_MULTIPLIER
        continue;
    end
        
    chunk = accum( 1:BUFF_LENGTH*BUFF_MULTIPLIER );

    accum(1:accum_length - BUFF_LENGTH*BUFF_MULTIPLIER) = accum( BUFF_LENGTH*BUFF_MULTIPLIER + 1 : accum_length );

    accum_length = accum_length - BUFF_LENGTH*BUFF_MULTIPLIER;
    
    
    [ TS, chunk1, chunk2, chunk1fft, chunk2fft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk );

    drawchart(TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, TS, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft);
        
    pause(0.1);
end

% Disconnect and clean up the server connection. 
fclose(f); 
