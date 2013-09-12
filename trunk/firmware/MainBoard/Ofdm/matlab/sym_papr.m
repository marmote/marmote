% Matlab script to find OFDM symbols that minimize PAPR

clear all;
clc;

N = 8;

q = zeros(2^N, N);
m = ones(2^N, 1) * -1;
for ii = 0 : 2^N-1
    q(ii+1,:) = de2bi(ii, N, 'left-msb')*2-1;
    m(ii+1) = max(abs(ifft(q(ii+1,:))));
end

min_idx = find(m == min(m))
[min_idx q(min_idx,:)]
