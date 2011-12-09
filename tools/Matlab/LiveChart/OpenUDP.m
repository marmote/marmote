function [ u ] = OpenUDP( IP, port, InputBufferSize )
%OPENUDP Summary of this function goes here
%   Detailed explanation goes here

    u = udp(IP, port);%, 'LocalPort', 49152);

    set(u,'Timeout', 0.0008);
    set(u, 'InputBufferSize', InputBufferSize); 
    set(u, 'DatagramTerminateMode', 'on'); 

% Open connection to the server. 
    fopen(u); 


end

