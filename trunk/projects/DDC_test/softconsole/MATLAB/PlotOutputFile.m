% open the file with write permission
% read samples and close
fid = fopen('samples.out', 'r');
temp = fscanf(fid, '%d\r\n'); 
fclose(fid);


% I'm throwing away the first 4 samples because they are 0 anyways in a 2
% stage CIC
c_I = temp(7:2:end); 
c_Q = temp(8:2:end);

figure;
hold on;
plot(c_I,'r');
plot(c_Q,'g');
hold off;


temp2 = fft(c_I + 1i*c_Q);
temp2 = temp2 / length(temp2);
spect = 20*log10(abs(temp2));

figure;
plot(spect);

