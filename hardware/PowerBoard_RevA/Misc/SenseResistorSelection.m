% Matlab help script for R_SENSE selection

clear all
clc

% LTC2942

Q_BAT = 6000; % mAh
I_MAX = 1000; % mA
M = 128;

R_SENSE = 50; % mohm

fprintf(1,'Checking condition Q_BAT > I_MAX * 5.5 h...')
if (Q_BAT > I_MAX * 5.5)
    fprintf(1,' TRUE\n')
    disp('Maximum charging current is low compared to battery capacity')
    
    disp('Checking condition R_SENSE <= 0.085 * 2^16 / Q_BAT * 50')    
    if R_SENSE <= 0.085 * 2^16 / Q_BAT * 50; % mAh
        disp('R_SENSE OK')
    else
        fprintf(1,'R_SENSE too large (0.085 * 2^16 / Q_BAT * 50 = %.4f mohm)\n', ...
            0.085 * 2^16 / Q_BAT * 50)
    end        
else
    fprintf(1,' FALSE\n')
    disp('Maximum charging current is adequate compared to battery capacity')
    
    disp('Checking condition R_SENSE <= 50 / I_MAX')
    if R_SENSE <= 50 / I_MAX
        disp('R_SENSE OK')
    else
        fprintf(1,'R_SENSE too large (50mohm / I_MAX = %.4f mohm)\n', 50/I_MAX)
    end
end
% R_SENSE_LC_MAX


q_LSB = 0.085 * 50/R_SENSE * M/128; % mAh
fprintf(1,'q_LSB = %.3f mAh (%.3f uAh)\n', q_LSB, q_LSB*1e3)