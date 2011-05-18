BUFF_LENGTH = 256;

Fs = 50e6 / 18; % [Hz] = 2.778 MHz
F_offset = 0; % [Hz]

N = BUFF_LENGTH;
F = Fs / N;
T = 1/Fs;
Full_Scale = 2^16 - 1;
Full_Scale_dB = 10*log10(Full_Scale);
dB_corr = 10*log10(Full_Scale);


disp('Opening TCPIP connection');

% Create TCP/IP object 't'. Specify server machine and port number. 
t = tcpip('192.168.1.2', 49151);

% Set size of receiving buffer, if needed. 
set(t, 'InputBufferSize', BUFF_LENGTH*32/8); 

% Open connection to the server. 
fopen(t); 

% Pause for the communication delay, if needed. 
pause(0.05) 

% Receive lines of data from server 
while (1) 
    if (get(t, 'BytesAvailable') == 0) 
        continue;
    end
    if (t.BytesAvailable < BUFF_LENGTH*32/8)
        continue;
    end
    
    chunk = fread(t, BUFF_LENGTH, 'uint32'); 

    chunk1 = fix( chunk / 2^16 ); %upper 16 bits
    chunk2 = rem( chunk, 2^16 ); %lower 16 bits
    
    chunk1fft = 10*log10(abs(fft(chunk1)));
    chunk2fft = 10*log10(abs(fft(chunk2)));

    chunk1fft(end/2:end) = [];
    chunk2fft(end/2:end) = [];
    
    chunk1fft = chunk1fft / N - dB_corr;
    chunk2fft = chunk2fft / N - dB_corr;

    [val1, pos] = max(chunk1fft);
    max_f1 = (pos-1)*F + F_offset;
    [val2, pos] = max(chunk2fft);
    max_f2 = (pos-1)*F + F_offset;
    
    x = ( ((1:length(chunk1fft)) - 1) * F + F_offset );
    time = (0:N-1)*T;
%    plot(x, chunk1, 'b', x, chunk2, 'g', max_f1, val1, 'ro', max_f2, val2, 'ro');

    clf;
%time
    subplot(3,1,1);
    hold on;
    plot(time*1e6, chunk1, 'b.-');
    plot(time*1e6, chunk2, 'r.-');
    xlim([0 N*T*1e6]);
    ylim([0 Full_Scale/4]);
    xlabel('time [usec]');
    ylabel('Sample []');
    hold off;

%time log    
    subplot(3,1,2);
    hold on;
    plot(time*1e6, log10(chunk1), 'b.-');
    plot(time*1e6, log10(chunk2), 'r.-');
    xlim([0 N*T*1e6]);
    ylim([0 10]);
    xlabel('time [usec]');
    ylabel('Log10 sample []');
    hold off;    
    
%frequency    
    subplot(3,1,3);
    hold on;
    plot(x/1e6, chunk1fft, 'b');
    plot(x/1e6, chunk2fft, 'r');
    plot(max_f1/1e6, val1, 'ro');
    plot(max_f2/1e6, val2, 'ro');
    
    xlim([(0+F_offset)/1e6 (Fs/2+F_offset)/1e6]);
%    ylim([-50 0]);
    ylim([-Full_Scale_dB -47.5]);
    title(['Max val1: ' num2str(val1) ' [dBFS]; Max f1: ' num2str(max_f1/1e6) ' [MHz]; Max val2: ' num2str(val2) ' [dBFS]; Max f2: ' num2str(max_f2/1e6) ' [MHz]']);
    xlabel('Frequency [MHz]');
    ylabel('Amplitude [dBFS]');
    hold off;

    
    pause(.001);
end

% Disconnect and clean up the server connection. 
fclose(t); 
delete(t); 
clear t; 
