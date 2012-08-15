function [ I_buff_all_out, Q_buff_all_out ] = AccumAllSamples( I_buff, Q_buff, I_buff_all, Q_buff_all )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set variables 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw charts
    I_buff_all_out = I_buff_all;
    Q_buff_all_out = Q_buff_all;

    if isempty(I_buff)
        return;
    end

    I_buff_all_out = [I_buff_all I_buff];
    Q_buff_all_out = [Q_buff_all Q_buff];

end