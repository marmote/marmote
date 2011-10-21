
c_CIC_ORDER = 3;

INPUT = 1;

int_vec = zeros(2, c_CIC_ORDER);

for ii=1:1:8
    disp('start');
    
    int_vec(1,1) = INPUT - int_vec(2,1);
    
    for jj=2:1:c_CIC_ORDER
        int_vec(1,jj) = int_vec(1,jj-1) - int_vec(2,jj);
    end
    
    for jj=1:1:c_CIC_ORDER
        disp(int_vec(1,jj));
    end
        
    int_vec(2,1) = INPUT;
    int_vec(2,2:end) = int_vec(1,1:end-1);
end