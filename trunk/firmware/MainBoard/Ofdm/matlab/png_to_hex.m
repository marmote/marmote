clear all
clc

filename = 'marmote-banner.png'

a = imread(filename);
a = (a == 0); % invert

colormap(gray(2))
image(a)
axis off
axis image

if size(a,1) ~= 32 | size(a,2) > 254
    disp(['Invalid image size'])
    return
end

% C
[~,c_fn] = fileparts(filename);
c_fn = [c_fn '.h'];
c_fid = fopen(c_fn, 'w');

fprintf(c_fid,'/* Bitmap from %s */\n\n',filename);
fprintf(c_fid,'const uint32_t mask_v[] = {\n');
for ii = 1 : size(a,2)
    if mod(ii,4) == 1
        fprintf(c_fid,'\t');
    end
    fprintf(c_fid,'0x%08X, ',bi2de(a(:,ii)'));
	if mod(ii,4) == 0
        fprintf(c_fid,'\n');
    end
end
fprintf(c_fid,'};\n');
fclose(c_fid);


% BFM
[~,bfm_fn] = fileparts(filename);
bfm_fn = [bfm_fn '.bfm'];
bfm_fid = fopen(bfm_fn, 'w');

if bfm_fid == -1
    disp(['Could not open file ''' bfm_fn ''''])
    return
end

fprintf(bfm_fid,'write w TX_APB_IF_0 TX_MLEN 0x%08X\n\n',size(a,2));
fprintf(bfm_fid,'# Bitmap from %s\n\n',filename);
for ii = 1 : size(a,2)
    fprintf(bfm_fid,'write w TX_APB_IF_0 TX_FIFO 0x%08X\n', ...
        bi2de(a(:,ii)'));
end
fprintf(bfm_fid,'\n');

fclose(bfm_fid);

