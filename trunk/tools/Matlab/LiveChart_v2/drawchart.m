function [ ] = drawchart( fig_handle, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set variables 
    DSPconf = GetDSPConfig_v2();
    
    N                   = DSPconf.N;

    F_offset            = DSPconf.F_offset;
    Fs                  = DSPconf.Fs;
    T                   = DSPconf.T;

    Full_Scale_dB       = DSPconf.Full_Scale_dB;
    
    F                   = Fs / N;
    
    num_pos_fr          = round(N/2); %positive and zero frequency bins
    num_neg_fr          = N - num_pos_fr; %negative frequency bins    

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw charts
    if isempty(I_buff)
        return;
    end

    c_freq = [(-num_neg_fr:-1) (0:num_pos_fr-1)] *F + F_offset;
    [val, pos] = max(spectrum);
    max_f = c_freq(pos);

    
    freq = (0:num_pos_fr-1) *F + F_offset;
    time = (0:N-1)*T;

    [I_val, I_pos] = max(I_spectrum);
    I_max_f = freq(I_pos);
    [Q_val, Q_pos] = max(Q_spectrum);
    Q_max_f = freq(Q_pos);
    

% Missing frames history    
    clf(fig_handle);
    
    MF_history = (frame_cnt_history(2:end) - frame_cnt_history(1:end-1)) - 1;
   
    hax = subplot(4,2,[1 2], 'Parent', fig_handle);
    plot(hax, MF_history, '.-');
    xlim(hax, [1 length(MF_history)]);
    
    
% Time
    hax = subplot(4,2,[3 4], 'Parent', fig_handle);
    hold(hax,'on');

    for ii=1:length(frame_starts)
        x = ( (frame_starts(ii)-1)*T - T/2 )*1e6;
        if missing_frames(ii) == 0
            plot(hax, [x x], [-1 1], 'g-');
        else
            plot(hax, [x x], [-1 1], 'r-');
        end
    end
    
    plot(hax, time*1e6, I_buff, 'b.-');
    plot(hax, time*1e6, Q_buff, 'g.-');
    xlim(hax, [0 N*T*1e6]);
%    ylim([0 Full_Scale/4]);
    ylim(hax, [-1 1]);
    xlabel(hax, 'time [usec]');
    ylabel(hax, 'Sample []');
    
    hold(hax,'off');


    
% Spectrum
    hax = subplot(4,2,[5 6], 'Parent', fig_handle);

    hold(hax,'on');
    plot(hax, freq/1e6, I_spectrum, 'b');
    plot(hax, freq/1e6, Q_spectrum, 'g');
    plot(hax, I_max_f/1e6, I_val, 'ro');
    plot(hax, Q_max_f/1e6, Q_val, 'ro');
    
    xlim(hax, [freq(1)/1e6 freq(end)/1e6]);
%    ylim([-50 0]);
    ylim(hax, [-Full_Scale_dB 0]);
    title(hax, ['Max val I: ' num2str(I_val, '%.1f') ' [dB]; Max f I: ' num2str(I_max_f/1e6, '%.1f') ' [MHz]; Max val Q: ' num2str(Q_val, '%.1f') ' [dB]; Max f Q: ' num2str(Q_max_f/1e6, '%.1f') ' [MHz]']);
    xlabel(hax, 'Frequency [MHz]');
    ylabel(hax, 'Amplitude [dB]');
    hold(hax,'off');
    

    hax = subplot(4,2,[7 8], 'Parent', fig_handle);

    hold(hax,'on');
    plot(hax, c_freq/1e6, spectrum, 'b');
    plot(hax, max_f/1e6, val, 'ro');
    
    xlim(hax, [c_freq(1)/1e6 c_freq(end)/1e6]);
%    ylim([-50 0]);
    ylim(hax, [-Full_Scale_dB 0]);
    title(hax, ['Max val: ' num2str(val, '%.1f') ' [dB]; Max f: ' num2str(max_f/1e6, '%.1f') ' [MHz];']);
    xlabel(hax, 'Frequency [MHz]');
    ylabel(hax, 'Amplitude [dB]');
    hold(hax,'off');
    
    drawnow;

end