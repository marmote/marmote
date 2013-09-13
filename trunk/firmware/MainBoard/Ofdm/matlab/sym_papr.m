% Matlab script to find OFDM symbols that minimize PAPR

close all;
clear all;
clc;

N = 8; % Subcarriers
G = 2; % Guards

if mod(N, 2) ~= 0
    disp('Error: Number of carriers (N) must be even')
    return
end

if mod(G, 2) ~= 0
    disp('Error: Number of guards (G) must be even')
    return
end

a = zeros(2^N, N);
for ii = 0 : 2^N-1
    a(ii+1,:) = de2bi(ii, N, 'left-msb')*2-1;
end


% Masks
mask = [zeros(1, G/2) ones(1, N-G) zeros(1, G/2)];
mask1 = reshape([ones(1,N/2); zeros(1,N/2)], 1, N) .* mask;
mask2 = reshape([zeros(1,N/2); ones(1,N/2)], 1, N) .* mask;

% Calculate peaks
p = ones(2^N, 1) * -1;
p1 = ones(2^N, 1) * -1;
p2 = ones(2^N, 1) * -1;
for ii = 0 : 2^N-1
    p(ii+1) = max(abs(ifft(a(ii+1,:) .* mask)));
    p1(ii+1) = max(abs(ifft(a(ii+1,:) .* mask1)));
    p2(ii+1) = max(abs(ifft(a(ii+1,:) .* mask2)));
end

% Find minimas
min_idx12 = find((p1 == min(p1)) .* (p2 == min(p2)));
min_idx = find(p == min(p(min_idx12)));

% Plot
subplot(3,1,1)
stem(p), hold on
stem(min_idx, min(p(min_idx12))*ones(1, length(min_idx)), 'g')
title('Rx')
subplot(3,1,2)
stem(p1), hold on
stem(min_idx12, min(p1)*ones(1, length(min_idx12)), 'g')
title('Tx_1')
subplot(3,1,3)
stem(p2), hold on
stem(min_idx12, min(p2)*ones(1, length(min_idx12)), 'g')
title('Tx_2')
