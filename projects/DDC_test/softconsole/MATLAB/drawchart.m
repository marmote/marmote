function [ ] = drawchart( TIME_STAMP, BUFF_MULTIPLIER, BUFF_LENGTH, TS, TS_history, Fs, F_offset, Resolution, N, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft )

    setvariables();

    c_freq = [(-num_neg_fr:-1) (0:num_pos_fr-1)] *F + F_offset;
    [val, pos] = max(chunkfft);
    max_f = c_freq(pos);

    
    freq = (0:num_pos_fr-1) *F + F_offset;
    time = (0:N-1)*T;

    [val1, pos] = max(chunk1fft);
    max_f1 = freq(pos);
    [val2, pos] = max(chunk2fft);
    max_f2 = freq(pos);
    

    clf;
    
if TIME_STAMP == 1
    TSD_history = (TS_history(2:end) - TS_history(1:end-1)) - 1;
   
    subplot(5,2,[1 2]);
    hold on;
    plot(TSD_history, '.-');
    xlim([1 length(TSD_history)]);
    hold off;    
    
    TSD = (TS(2:end) - TS(1:end-1)) - 1;

    subplot(5,2,3);
    hold on;
    plot(TSD, '.-');
    xlim([0 length(TSD)+1]);
    hold off;
    
    subplot(5,2,4);
    hold on;
    plot(TSD*BUFF_LENGTH*T*1e6, '.-');
    xlim([0 length(TSD)+1]);
%    plotyy(1:length(TSD), TSD, 1:length(TSD), TSD*BUFF_LENGTH*T*1e6);
    hold off;
end
    
    
%time
if TIME_STAMP == 1
    subplot(5,2,[5 6]);
else
    subplot(3,1,1);
end
    hold on;

    for ii=1:BUFF_MULTIPLIER-1
        x = ( ii*(BUFF_LENGTH-1)*T - T/2 )*1e6;
        plot([x x], [-1 1], 'r-');
    end
    
    plot(time*1e6, chunk1, 'b.-');
    plot(time*1e6, chunk2, 'g.-');
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
if TIME_STAMP == 1
    subplot(5,2,[7 8]);
else
    subplot(3,1,2);
end
    hold on;
    plot(freq/1e6, chunk1fft, 'b');
    plot(freq/1e6, chunk2fft, 'g');
    plot(max_f1/1e6, val1, 'ro');
    plot(max_f2/1e6, val2, 'ro');
    
    xlim([freq(1)/1e6 freq(end)/1e6]);
%    ylim([-50 0]);
    ylim([-Full_Scale_dB 0]);
    title(['Max val1: ' num2str(val1) ' [dB]; Max f1: ' num2str(max_f1/1e6) ' [MHz]; Max val2: ' num2str(val2) ' [dB]; Max f2: ' num2str(max_f2/1e6) ' [MHz]']);
    xlabel('Frequency [MHz]');
    ylabel('Amplitude [dB]');
    hold off;
    
    drawnow;



if TIME_STAMP == 1
    subplot(5,2,[9 10]);
else
    subplot(3,1,3);
end

    hold on;
    plot(c_freq/1e6, chunkfft, 'b');
    plot(max_f/1e6, val, 'ro');
    
    xlim([c_freq(1)/1e6 c_freq(end)/1e6]);
%    ylim([-50 0]);
    ylim([-Full_Scale_dB 0]);
    title(['Max val: ' num2str(val) ' [dB]; Max f: ' num2str(max_f/1e6) ' [MHz];']);
    xlabel('Frequency [MHz]');
    ylabel('Amplitude [dB]');
    hold off;
    
    drawnow;

end