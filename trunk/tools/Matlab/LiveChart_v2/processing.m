function [ frame_FIFO_out, frame_cnt_FIFO_out, frame_cnt_history_out, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum ] = processing( frame_FIFO, frame_cnt_FIFO, frame_cnt_history )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set variables    
    DSPconf = GetDSPConfig_v2();
    
    Full_Scale          = DSPconf.Full_Scale;
    N                   = DSPconf.N;

    num_pos_fr          = round(N/2); %positive and zero frequency bins
    num_neg_fr          = N - num_pos_fr; %negative frequency bins    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signal processing
    frame_FIFO_out = frame_FIFO;
    frame_cnt_FIFO_out = frame_cnt_FIFO;
    frame_cnt_history_out = frame_cnt_history;
    
    frame_starts = [];
    missing_frames = [];
    I_buff = [];
    Q_buff = [];
    spectrum = [];
    I_spectrum = [];
    Q_spectrum = [];

    
% Take all the frames, and put them in one display buffer    

    % Do we have enough samples to fill up the display buffer?
    combined_length = 0;
    for ii=1:length(frame_FIFO_out)
        combined_length = combined_length + length(frame_FIFO_out{ii});
    end
    
    if combined_length < N
        return;
    end
        
    buff = [];
    frame_starts = [];
    missing_frames = [];
    
    while length(buff) < N
        % If this is the first time we encountered this frame we 
        % 1. copy the frame counter to the history 
        % 2. save the starting index 
        % 3. calculate the missing frames
        if isempty(frame_cnt_history_out) || frame_cnt_history_out(end) ~= frame_cnt_FIFO_out(1)
            frame_starts(end+1) = length(buff) + 1;
            if isempty(frame_cnt_history_out)
                missing_frames(end+1) = 0;
            else
                missing_frames(end+1) = frame_cnt_FIFO_out(1) - frame_cnt_history_out(end) - 1;
            end
            
            frame_cnt_history_out(end + 1) = frame_cnt_FIFO_out(1);
            while length(frame_cnt_history_out) > 100
                frame_cnt_history_out(1) = [];
            end
        end
        
        % Copy samples from frame to display buffer
        frame = frame_FIFO_out{1};
        
        copy_length = min( N - length(buff) , length(frame) );
        
        buff = [ buff frame(1:copy_length) ];
        
        if copy_length == length(frame)
            frame_FIFO_out(1) = [];
            frame_cnt_FIFO_out(1) = [];
        else
            frame_FIFO_out{1}(1:copy_length) = [];
        end
    end
    
    
% Do actual signal processing on display buffer    
   
    I_buff = bitand(bitshift(buff, -16), hex2dec('FFFF'));
    Q_buff = bitand(buff, hex2dec('FFFF'));
    
    I_buff = double(typecast(uint16(I_buff), 'int16'));
    Q_buff = double(typecast(uint16(Q_buff), 'int16'));
    
    I_buff = I_buff/Full_Scale;
    Q_buff = Q_buff/Full_Scale;
   
    spectrum = 2*abs(fft(I_buff + 1i * Q_buff));
    I_spectrum = 2*abs(fft(I_buff));
    Q_spectrum = 2*abs(fft(Q_buff));

    spectrum = [spectrum(num_pos_fr+1:end) spectrum(1:num_pos_fr)];
    I_spectrum(end-num_neg_fr+1:end) = [];
    Q_spectrum(end-num_neg_fr+1:end) = [];
    
    spectrum = spectrum / N;
    I_spectrum = I_spectrum / N;
    Q_spectrum = Q_spectrum / N;

    spectrum = 20 * log10(spectrum);
    I_spectrum = 20 * log10(I_spectrum);
    Q_spectrum = 20 * log10(Q_spectrum);
    
end