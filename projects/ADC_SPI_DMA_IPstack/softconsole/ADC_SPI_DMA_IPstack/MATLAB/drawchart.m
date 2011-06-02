function [ ] = drawchart( Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft )

    F = Fs / N;
    T = 1/Fs;

    Full_Scale = 2^Resolution - 1;
    Full_Scale_dB = 20 * log10(Full_Scale);


    [val1, pos] = max(chunk1fft);
    max_f1 = (pos-1)*F + F_offset;
    [val2, pos] = max(chunk2fft);
    max_f2 = (pos-1)*F + F_offset;
    
    freq = ( ((1:length(chunk1fft)) - 1) * F + F_offset );
    time = (0:N-1)*T;

    clf;
    
%time
    subplot(2,1,1);
    hold on;
    plot(time*1e6, chunk1, 'b.-');
    plot(time*1e6, chunk2, 'r.-');
    xlim([0 N*T*1e6]);
%    ylim([0 Full_Scale/4]);
    ylim([-1 1]);
    xlabel('time [usec]');
    ylabel('Sample []');
    hold off;

%time log    
%     subplot(3,1,2);
%     hold on;
%     plot(time*1e6, log10(chunk1), 'b.-');
%     plot(time*1e6, log10(chunk2), 'r.-');
%     xlim([0 N*T*1e6]);
%     ylim([0 10]);
%     xlabel('time [usec]');
%     ylabel('Log10 sample []');
%     hold off;    
    
%frequency    
    subplot(2,1,2);
    hold on;
    plot(freq/1e6, chunk1fft, 'b');
    plot(freq/1e6, chunk2fft, 'r');
    plot(max_f1/1e6, val1, 'ro');
    plot(max_f2/1e6, val2, 'ro');
    
    xlim([(0+F_offset)/1e6 (Fs/2+F_offset)/1e6]);
%    ylim([-50 0]);
    ylim([-Full_Scale_dB 0]);
    title(['Max val1: ' num2str(val1) ' [dB]; Max f1: ' num2str(max_f1/1e6) ' [MHz]; Max val2: ' num2str(val2) ' [dB]; Max f2: ' num2str(max_f2/1e6) ' [MHz]']);
    xlabel('Frequency [MHz]');
    ylabel('Amplitude [dB]');
    hold off;

end
