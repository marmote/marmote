function [ TS, TS_history_out, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk, TS_history )

    setvariables();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signal processing    
    TS = [];
    if TIME_STAMP == 1
        ii = BUFF_LENGTH*(BUFF_MULTIPLIER-1)+1;
        while ii > 0
           TS = [uint32(chunk(ii)) TS]; 
           chunk(ii) = [];
           ii = ii - BUFF_LENGTH;
        end
    end
    
    TS_history_out = [TS_history(end-min(length(TS_history), 97)+1:end) TS];

%    chunk1 = fix( chunk / 2^16 ); %upper 16 bits
%    chunk2 = rem( chunk, 2^16 ); %lower 16 bits
    
    chunk1 = bitand(bitshift(chunk, -16), hex2dec('FFFF'));
    chunk2 = bitand(chunk, hex2dec('FFFF'));
    
    chunk1 = double(typecast(uint16(chunk1), 'int16'));
    chunk2 = double(typecast(uint16(chunk2), 'int16'));
    
    chunk1 = chunk1/Full_Scale;
    chunk2 = chunk2/Full_Scale;
   
    chunkfft = 2*abs(fft(chunk1 + 1i * chunk2));
    chunk1fft = 2*abs(fft(chunk1));
    chunk2fft = 2*abs(fft(chunk2));

    chunkfft = [chunkfft(num_pos_fr+1:end) chunkfft(1:num_pos_fr)];
    chunk1fft(end-num_neg_fr+1:end) = [];
    chunk2fft(end-num_neg_fr+1:end) = [];
    
    chunkfft = chunkfft / N;
    chunk1fft = chunk1fft / N;
    chunk2fft = chunk2fft / N;

    chunkfft = 10 * log10(chunkfft);
    chunk1fft = 10 * log10(chunk1fft);
    chunk2fft = 10 * log10(chunk2fft);
    
end