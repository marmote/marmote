D = 32;
Fs = 50e6/18;

f_max = 1;
f = 0:f_max/1000:f_max;

y = sin(pi()*f*D)./sin(pi()*f);
y_dB = 20*log10(abs(y));


maximum = ceil(max(y_dB)/10)*10;
minimum = maximum-50;
plot(f*Fs,y_dB);
ylim([minimum maximum]);

figure;

ii = 1;
lap = f_max/(2*D);

blax = [];
blay = [];
while ii <= length(y_dB)/2
    blax(end+1) = rem(f(ii),lap);
    if (rem(fix(f(ii)/lap),2) == 1)
        blax(end) = lap-blax(end);
    end
    blay(end+1) = y_dB(ii);
    ii=ii+1;
end
plot(blax*Fs,blay);
ylim([minimum maximum]);
xlim([0 lap*Fs]);
