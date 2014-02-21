% Matlab script file to examine the maximum-length PN sequences

clear all;
close all;
clc;

mseq_order = 11;

mseq_taps = { ...
    [11 2 0], ...
    [11 8 5 2 0], ...
    [11 7 3 2 0], ...
    [11 5 3 2 0], ...
    [11 10 3 2 0], ...
    [11 6 5 1 0], ...
    [11 5 3 1 0], ...
    [11 9 4 1 0], ...
    [11 8 6 2 0], ...
    [11 9 8 3 0], ...
    [11 10 9 8 3 1 0], ...
};

mseq_poly = cell(length(mseq_taps));

seed = de2bi(hex2dec('401')); % 0x401
mask = [zeros(1,length(mseq_taps)-1) 1];

% Export polynomials
for ii = 1 : length(mseq_taps)
    a = zeros(0, mseq_order+1);
    idx = mseq_taps{ii}(1:end-1);
    a(idx) = 1;
    
    mseq_poly{ii} = bi2de(a);    
    fprintf(1, '0x%s,\t // %s\n', dec2hex(mseq_poly{ii}), mat2str(mseq_taps{ii}));
end

h = cell(length(mseq_taps));

% Check sequence length (auto Matlab warning)
for ii = 1 : length(mseq_taps)
    h{ii} = commsrc.pn('GenPoly', mseq_taps{ii}, ...
        'InitialStates', seed, ...
        'Mask', mask);
end

% Check auto-correlation
s = cell(1, length(mseq_taps));
for ii = 1 : length(mseq_taps)
    s{ii} = zeros(1,2^(mseq_order+1));
    for kk = 1 : length(s{ii})
        s{ii}(kk) = (h{ii}.generate*2)-1;
    end    

    x = s{ii} > 0;    
    N = length(x)
    r = zeros(1,2*N-1);
    for mm = 0 : N-1
        for nn = 0 : N-mm-1
            if xor(x(nn+mm+1), x(nn+1)) == 0
                r(mm+N) = r(mm+N) + 1;
            else
                r(mm+N) = r(mm+N) - 1;
            end
        end
        r(N-mm) = r(N+mm);
    end
    subplot(2,1,1)
    plot(r)
    title(sprintf('x: 0x%s %s max = %d', dec2hex(mseq_poly{ii}), mat2str(mseq_taps{ii}), max(xcorr(s{ii},s{ii}))))
    fprintf(1, 'Auto-correlation max = %d [%d]\n', max(r), ii);
    
    pause
    subplot(2,1,2)
    plot(xcorr(s{ii},s{ii}))
    title(sprintf('s: 0x%s %s max = %d', dec2hex(mseq_poly{ii}), mat2str(mseq_taps{ii}), max(xcorr(s{ii},s{ii}))))
    fprintf(1, 'Auto-correlation max = %d [%d]\n', max(xcorr(s{ii},s{ii})), ii);
    
    return
end

return

% Check cross-correlation
max_val = 0;
max_idx = [0 0];
for ii = 1 : length(mseq_taps)    
    for jj = ii + 1 : length(mseq_taps)        
        xc = xcorr(s{ii},s{jj});       
        
        if abs(max(xc)) > max_val
            max_val = max(abs(xc));
            max_idx = [ii, jj];  
        end
        
        plot(xcorr(s{ii},s{ii}), 'r'), hold on;
        plot(xcorr(s{jj},s{jj}), 'g');
        plot(xc, 'b'), hold off;
        ylim([-2^(mseq_order+1) 2^(mseq_order+1)]);
        title(sprintf('Cross-correlation of 0x%s [%d] and 0x%s [%d] max = %g\n', ...
            dec2hex(mseq_poly{ii}), ii, dec2hex(mseq_poly{jj}), jj, max(abs(xc))));
        legend( ...
            sprintf('R(%d,%d)',ii,ii), ...
            sprintf('R(%d,%d)',jj,jj), ...
            sprintf('R(%d,%d)',ii,jj))

        fprintf(1, 'Cross-correlation max = %g [R(%d,%d)]\n', max(abs(xc)), ii, jj);
        pause
    end    
end