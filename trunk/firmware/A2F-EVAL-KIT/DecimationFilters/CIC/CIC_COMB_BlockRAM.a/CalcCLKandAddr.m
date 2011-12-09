
c_CIC_ORDER = 6;

disp('Addition at clock cycles:');   
clk_counter = 0;
while clk_counter <= 17

 
jj = 0;
while jj <= 2 

    ii = jj + 1;
    while ii <= c_CIC_ORDER

        if clk_counter == 2*(ii-jj)+jj +2

            disp(clk_counter);
                    
        end

        ii = ii + 3;

    end

    jj = jj + 1;

end

clk_counter = clk_counter + 1;
end


disp('Reading and writing at clock cycles and mem addresses:');   
oddeven = 0;
while oddeven <= 1
clk_counter = 0;
while clk_counter <= 17
    
    if oddeven == 0
        k = 0;
    else
        k = 1;
    end


    jj = 0;
    while jj <= 2

    	ii = jj + 1;
        while ii <= c_CIC_ORDER

            if clk_counter == 2*(ii-jj)+jj-2 +2
                
                disp('Reading');
                disp(['Clock: '  int2str(2*(ii-jj)+jj-2 +2)]);
                disp(['Addr: '  int2str(2*ii - k -1)]);
                    
            end

            ii = ii + 3;

        end

        jj = jj + 1;

    end


    jj = 0;
    while jj <= 2

        ii = jj + 1;
        while ii < c_CIC_ORDER

            if clk_counter == 2*(ii-jj)+jj+1 +2

                disp('Writing');
                disp(['Clock: '  int2str(2*(ii-jj)+jj+1 +2)]);
                disp(['Addr: '  int2str(2*ii + 1 + k -1)]);

            end

            ii = ii + 3;

        end

        jj = jj + 1;

    end
    
clk_counter = clk_counter + 1;
end
oddeven = oddeven + 1;
end
