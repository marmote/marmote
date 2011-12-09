function chunk = ReadBuffer( u, conf )
%READBUFFER Summary of this function goes here
%   Detailed explanation goes here
    
    BUFF_LENGTH         = conf.BUFF_LENGTH;
    BUFF_MULTIPLIER     = conf.BUFF_MULTIPLIER;

    
    TOTAL_BUFF_LENGTH = BUFF_MULTIPLIER * BUFF_LENGTH;

    temp = uint8(zeros( 1, BUFF_LENGTH*32/8 ));
    %if TIME_STAMP == 1
    %    chunk = zeros( 1, (BUFF_LENGTH-1)*BUFF_MULTIPLIER );
    %    accum = zeros( 1, (BUFF_LENGTH-1)*(BUFF_MULTIPLIER+1) );
    %else
        chunk = uint32(zeros( 1, TOTAL_BUFF_LENGTH ));
        accum = uint32(zeros( 1, TOTAL_BUFF_LENGTH ));
    %end

    accum_length = 0;
    
    for jj=(1:BUFF_MULTIPLIER)

%Tell SmartFusion we'll be reading one buffer        
        fwrite(u, int8([1 1]), 'int8');

%Read data
        for ii=(1:3)
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
            % Discard unsuccesfull read attempts
            continue;
        end
    
%    fid = fopen('C:\Users\babjak\Desktop\logfile.txt', 'a');
%    fwrite(fid, temp);
%    fclose(fid);
    
        accum(accum_length+1:accum_length+temp_length) = typecast(temp, 'uint32')';
        accum_length = accum_length + temp_length; 

        if (accum_length < BUFF_LENGTH*BUFF_MULTIPLIER)
            continue;
        end    
    
        chunk = accum;
    end
    
end

