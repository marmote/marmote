function [ TS, chunk1, chunk2, chunk1fft, chunk2fft ] = processing( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, Resolution, chunk )

    setvariables();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signal processing    
    TS = [];
    if TIME_STAMP == 1
        ii = BUFF_LENGTH*(BUFF_MULTIPLIER-1)+1;
        while ii > 0
           TS = [chunk(ii) TS]; 
           chunk(ii) = [];
           chunk(ii) = [];
           ii = ii - BUFF_LENGTH;
        end
    end

    chunk1 = chunk(1:2:end);
    chunk2 = chunk(2:2:end);

    chunk1 = chunk1/Full_Scale;
    chunk2 = chunk2/Full_Scale;
   
    chunk1fft = 2*abs(fft(chunk1));
    chunk2fft = 2*abs(fft(chunk2));

    chunk1fft(ceil(end/2):end) = [];
    chunk2fft(ceil(end/2):end) = [];
    
    chunk1fft = chunk1fft / N;
    chunk2fft = chunk2fft / N;

    chunk1fft = 20 * log10(chunk1fft);
    chunk2fft = 20 * log10(chunk2fft);
    
end