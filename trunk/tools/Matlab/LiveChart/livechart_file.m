function conf = livechart_file(file_name)

screen_refresh_rate = 25; %in frame per secs

DSPconf = GetDSPConfig();

TS_history = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open file. 

%file_name = '..\..\netcat_win\SaveSamples\logfile.txt'
f = fopen(file_name); 

temp = zeros( 1, DSPconf.BUFF_LENGTH );
chunk = zeros( 1, DSPconf.BUFF_LENGTH*DSPconf.BUFF_MULTIPLIER );
accum = zeros( 1, DSPconf.BUFF_LENGTH*(DSPconf.BUFF_MULTIPLIER+1) );
accum_length = 0;

processed_buffers = 0;

fig_handle = figure;

while (1) 
    temp = fread(f, DSPconf.BUFF_LENGTH, 'uint32');

    temp_length = length(temp);
    
    if temp_length == 0
        disp('Processed:');
        disp([num2str(processed_buffers) ' buffers, '   num2str(processed_buffers*DSPconf.BUFF_LENGTH) ' samples']);
        disp('Left in accum:');
        disp([num2str(accum_length/DSPconf.BUFF_LENGTH) ' buffers, '  num2str(accum_length) ' samples']);
        break;
    end 
    
    accum(accum_length+1:accum_length+temp_length) = temp';
    accum_length = accum_length + temp_length;

    if accum_length < DSPconf.BUFF_LENGTH*DSPconf.BUFF_MULTIPLIER
        continue;
    end
        
    processed_buffers = processed_buffers + DSPconf.BUFF_MULTIPLIER;
    
    chunk = accum( 1:DSPconf.BUFF_LENGTH*DSPconf.BUFF_MULTIPLIER );

    accum(1:accum_length - DSPconf.BUFF_LENGTH*DSPconf.BUFF_MULTIPLIER) = accum( DSPconf.BUFF_LENGTH*DSPconf.BUFF_MULTIPLIER + 1 : accum_length );

    accum_length = accum_length - DSPconf.BUFF_LENGTH*DSPconf.BUFF_MULTIPLIER;
    
    
    [ TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft ] = processing( DSPconf, chunk, TS_history );

    drawchart( fig_handle, DSPconf, TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft);
        
    pause(1/screen_refresh_rate);
end

% Disconnect and clean up the server connection. 
fclose(f); 
