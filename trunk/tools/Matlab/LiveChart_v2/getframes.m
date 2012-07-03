function [ frames, frame_cnt, buff_out ] = getframes( buff )
%GETFRAMES Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set variables    
    DSPconf = GetDSPConfig_v2();
    
    START_OF_FRAME = DSPconf.START_OF_FRAME;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract frames
    buff_out = buff;
    copy_to_frames = 0;


    frames = {};
    frame_cnt = [];


    buff_count = length(START_OF_FRAME);

    while buff_count <= length(buff_out)
        % We are looking for the start of the frame
        if ~isequal( buff(buff_count+1-length(START_OF_FRAME):buff_count) , START_OF_FRAME )
            buff_count = buff_count + 1;
            continue;
        end

        % Every complete frame is copied to a list
        if copy_to_frames == 1
            frames{end+1} = uint8_to_uint32(buff_out( length(START_OF_FRAME)+4 +1 : buff_count - length(START_OF_FRAME)));
            frame_cnt(end+1) = uint8_to_uint32(buff_out( length(START_OF_FRAME)+1 : length(START_OF_FRAME)+4));
        end
    
        copy_to_frames = 1;
    
        % Complete frames are removed from buffer
        buff_out(1:buff_count - length(START_OF_FRAME)) = [];
        buff_count = length(START_OF_FRAME)+4+length(START_OF_FRAME);
    end
