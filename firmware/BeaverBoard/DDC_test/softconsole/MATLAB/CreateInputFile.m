N = 1000;
Fs = 50e6/18;

Resolution = 14; % bits
Full_Scale = 2^(Resolution-1) - 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gen_f = Fs/N*40; % [Hz]
gen_A = 1; %
gen_phi = 0; % [rad]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = 1/Fs;
t = 0:T:T*(N-1);

c = gen_A*exp(1i*(2*pi()*gen_f*t + gen_phi));
c = c * Full_Scale;

c_I = int16(real(c));
c_Q = int16(imag(c));

% open the file with write permission
fid = fopen('samples.in', 'w');

for ii=1:N
   fprintf(fid, '%.0f\r\n', c_I(ii)); 
   fprintf(fid, '%.0f\r\n', c_Q(ii)); 
end

fclose(fid);

