library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Entity definition
--
------------------------------------------------------------------------------
entity CIC is
    generic (
        c_CIC_DECIMATION   : integer := pow2(c_CIC_ORDER);
        c_CIC_INNER_WIDTH  : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER
    );

   	port (
		CLK       : in  std_logic;
		RST       : in  std_logic;


-- DEBUG
        --OUTDEBUG  : out std_logic_vector(c_CIC_WIDTH-1 downto 0);

		INPUT     : in  std_logic_vector(c_CIC_WIDTH-1 downto 0);
        OUTPUT    : out std_logic_vector(c_CIC_WIDTH-1 downto 0)
	);
end entity; 


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of CIC is

    type sample_vector is array ( natural range <> ) of signed(c_CIC_INNER_WIDTH-1 downto 0);

	-- Signals
    signal int              : sample_vector(1 to c_CIC_ORDER+1);
    signal comb             : sample_vector(1 to c_CIC_ORDER+1);
    signal comb_delayed     : sample_vector(1 to c_CIC_ORDER);

    signal prog             : unsigned(1 to log2_ceil(c_CIC_DECIMATION)); 

begin

    -- INTEGRATOR STAGE
    process (rst, clk)
    begin

        if rst = '1' then
            int(1) <= (others => '0');
        elsif rising_edge(clk) then
            int(1)(c_CIC_INNER_WIDTH-1 downto c_CIC_WIDTH) <= ( others => input(input'high) );
            int(1)(c_CIC_WIDTH-1 downto 0) <= signed(input(input'range));
        end if;

        for i in 1 to c_CIC_ORDER loop

            if rst = '1' then
                int(i+1) <= (others => '0');
            elsif rising_edge(clk) then
                int(i+1) <= int(i) + int(i+1);
            end if;

        end loop;
        
    end process;


    -- DECIMATION
    process(rst, clk)
    begin
        if rst = '1' then
            prog <= (others => '0');
        elsif rising_edge(clk) then
            if prog >= c_CIC_DECIMATION-1 then
                prog <= (others => '0');    
            else
                prog <= prog + 1;
            end if;
        end if;
    end process;


    -- COMB STAGE
    process (rst, clk)
    begin

        if rst = '1' then

            comb(1)         <= (others => '0');
		    
        elsif rising_edge(clk) then

            if prog = (prog'range => '0') then
                comb(1) <= int(c_CIC_ORDER+1);
            end if;

        end if;


        for i in 1 to c_CIC_ORDER loop
            
            if rst = '1' then

                comb(i+1)         <= (others => '0');
                comb_delayed(i) <= (others => '0');
		    
            elsif rising_edge(clk) then
                if prog = (prog'range => '0') then
                    comb_delayed(i) <= comb(i);

                    comb(i+1)       <= comb(i) - comb_delayed(i);
                end if;
            end if;

        end loop;
        
    end process;


	-- Assign output signal
    output  <= std_logic_vector(comb(c_CIC_ORDER+1)(c_CIC_INNER_WIDTH-1 downto c_CIC_INNER_WIDTH-1-(c_CIC_WIDTH-1)));  


end Behavioral;
