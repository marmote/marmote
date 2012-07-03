function [ out ] = uint8_to_uint32( in )
%UINT8_TO_UINT32 Summary of this function goes here
%   Detailed explanation goes here

in = uint32(in);
out = bitshift(in(1:4:end), 24) + bitshift(in(2:4:end), 16) + bitshift(in(3:4:end), 8) + bitshift(in(4:4:end), 0);

end

