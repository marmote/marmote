function conf = livechart_file_v2(file_name)

screen_refresh_rate = 25; %in frame per secs

DSPconf = GetDSPConfig_v2();

N = DSPconf.N;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open file. 

f = fopen(file_name); 

%temp = zeros( 1, DSPconf.BUFF_LENGTH );
%chunk = zeros( 1, DSPconf.BUFF_LENGTH*DSPconf.BUFF_MULTIPLIER );
%accum = zeros( 1, DSPconf.BUFF_LENGTH*(DSPconf.BUFF_MULTIPLIER+1) );
temp = [];
accum = [];


fig_handle = figure;


frame_cnt_history       = [];
frame_FIFO              = {};
frame_cnt_FIFO          = [];


while (1)

    temp = fread(f, 200, 'uint8');
    
    if isempty(temp)
        break;
    end

    accum = [ accum temp' ];
    
    [ frames, frame_cnt, accum ] = getframes( accum );
    
    if isempty(frames)
        continue;
    end

    frame_FIFO = {frame_FIFO{1:end} frames{1:end}};
    frame_cnt_FIFO = [frame_cnt_FIFO frame_cnt];
    
    [ frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum ] = processing( frame_FIFO, frame_cnt_FIFO, frame_cnt_history );

    drawchart( fig_handle, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum );
        
    pause(1/screen_refresh_rate);
   
end



% Disconnect and clean up the server connection. 
fclose(f); 
