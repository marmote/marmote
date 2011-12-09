DSPconf = GetDSPConfig();


RFFrequency = uint32(433e6); %Hz
DC_Offset_I = int16(0);
DC_Offset_Q = int16(0);
DDCFrequency = int32(0); %Hz
Shift = uint8(0);

%screen_refresh_rate = 10; %in frame per secs

TS_history = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Open UDP connection. 
disp('Opening UDP connection');
u = OpenUDP( '192.168.1.2', 49151, 10 * DSPconf.BUFF_LENGTH * 32/8 );

WriteConfig( u, RFFrequency, DC_Offset_I, DC_Offset_Q, DDCFrequency, Shift );

%    fid = fopen('C:\Users\babjak\Desktop\logfile.txt', 'w');
%    fclose(fid);
fig_handle = figure;

while (1) 
    
    chunk = ReadBuffer( u, DSPconf );
    
    [ TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft ] = processing( DSPconf, chunk, TS_history );

    drawchart( fig_handle, DSPconf, TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft);
    
end

% Disconnect and clean up the server connection. 
CloseUDP(u);
