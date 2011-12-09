function [ ] = drawchart( fig_handle, conf, TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set variables   
    TIME_STAMP          = conf.TIME_STAMP;
    BUFF_LENGTH         = conf.BUFF_LENGTH;
    BUFF_MULTIPLIER     = conf.BUFF_MULTIPLIER;

    F_offset            = conf.F_offset;
    
    N                   = conf.N;
    
    F                   = conf.F;
    T                   = conf.T;

    num_pos_fr          = conf.num_pos_fr;
    num_neg_fr          = conf.num_neg_fr;

    Full_Scale_dB       = conf.Full_Scale_dB;
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw charts
    c_freq = [(-num_neg_fr:-1) (0:num_pos_fr-1)] *F + F_offset;
    [val, pos] = max(chunkfft);
    max_f = c_freq(pos);

    
    freq = (0:num_pos_fr-1) *F + F_offset;
    time = (0:N-1)*T;

    [val1, pos] = max(chunk1fft);
    max_f1 = freq(pos);
    [val2, pos] = max(chunk2fft);
    max_f2 = freq(pos);
    

    clf(fig_handle);
    
if TIME_STAMP == 1
    TSD_history = (TS_history(2:end) - TS_history(1:end-1)) - 1;
   
    hax = subplot(5,2,[1 2], 'Parent', fig_handle);
    plot(hax, TSD_history, '.-');
    xlim(hax, [1 length(TSD_history)]);
    
    TSD = (TS(2:end) - TS(1:end-1)) - 1;

    hax = subplot(5,2,3, 'Parent', fig_handle);
    plot(hax, TSD, '.-');
    xlim(hax, [0 length(TSD)+1]);
    
    hax = subplot(5,2,4, 'Parent', fig_handle);
    plot(hax, TSD*BUFF_LENGTH*T*1e6, '.-');
    xlim(hax, [0 length(TSD)+1]);
end
    
    
%time
if TIME_STAMP == 1
    hax = subplot(5,2,[5 6], 'Parent', fig_handle);
else
    hax = subplot(3,1,1, 'Parent', fig_handle);
end
    hold(hax,'on');

    for ii=1:BUFF_MULTIPLIER-1
        x = ( ii*(BUFF_LENGTH-1)*T - T/2 )*1e6;
        plot(hax, [x x], [-1 1], 'r-');
    end
    
    plot(hax, time*1e6, chunk1, 'b.-');
    plot(hax, time*1e6, chunk2, 'g.-');
    xlim(hax, [0 N*T*1e6]);
%    ylim([0 Full_Scale/4]);
    ylim(hax, [-1 1]);
    xlabel(hax, 'time [usec]');
    ylabel(hax, 'Sample []');
    
    hold(hax,'off');


    
%frequency  
if TIME_STAMP == 1
    hax = subplot(5,2,[7 8], 'Parent', fig_handle);
else
    hax = subplot(3,1,2, 'Parent', fig_handle);
end
    hold(hax,'on');
    plot(hax, freq/1e6, chunk1fft, 'b');
    plot(hax, freq/1e6, chunk2fft, 'g');
    plot(hax, max_f1/1e6, val1, 'ro');
    plot(hax, max_f2/1e6, val2, 'ro');
    
    xlim(hax, [freq(1)/1e6 freq(end)/1e6]);
%    ylim([-50 0]);
    ylim(hax, [-Full_Scale_dB 0]);
    title(hax, ['Max val1: ' num2str(val1) ' [dB]; Max f1: ' num2str(max_f1/1e6) ' [MHz]; Max val2: ' num2str(val2) ' [dB]; Max f2: ' num2str(max_f2/1e6) ' [MHz]']);
    xlabel(hax, 'Frequency [MHz]');
    ylabel(hax, 'Amplitude [dB]');
    hold(hax,'off');
    

if TIME_STAMP == 1
    hax = subplot(5,2,[9 10], 'Parent', fig_handle);
else
    hax = subplot(3,1,3, 'Parent', fig_handle);
end

    hold(hax,'on');
    plot(hax, c_freq/1e6, chunkfft, 'b');
    plot(hax, max_f/1e6, val, 'ro');
    
    xlim(hax, [c_freq(1)/1e6 c_freq(end)/1e6]);
%    ylim([-50 0]);
    ylim(hax, [-Full_Scale_dB 0]);
    title(hax, ['Max val: ' num2str(val) ' [dB]; Max f: ' num2str(max_f/1e6) ' [MHz];']);
    xlabel(hax, 'Frequency [MHz]');
    ylabel(hax, 'Amplitude [dB]');
    hold(hax,'off');
    
    drawnow;

end