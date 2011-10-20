library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.common.all;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Entity definition
--
------------------------------------------------------------------------------
entity MULTIPLIER is
    generic (
        c_A_WIDTH       : integer := 8;
        c_B_WIDTH       : integer := 14;
        c_C_WIDTH       : integer := 22 -- MUST BE c_A_WIDTH+c_B_WIDTH
    );

    port (
		CLK             : in    std_logic;
		RST             : in    std_logic;

        sample_rdy_in   : in    std_logic;

        A               : in    std_logic_vector(c_A_WIDTH-1 downto 0);
        B               : in    std_logic_vector(c_B_WIDTH-1 downto 0);

        sample_rdy      : out   std_logic;

        C               : out   std_logic_vector(c_C_WIDTH-1 downto 0)

         );
end entity;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of MULTIPLIER is

    signal As       : unsigned(c_A_WIDTH-1 downto 0);
    signal Bs       : unsigned(c_B_WIDTH-1 downto 0);
    signal Cs       : unsigned(c_C_WIDTH downto 0);

    signal counter  : unsigned( log2_ceil(c_B_WIDTH+2) downto 1 );  


begin

    process(RST, CLK)
    begin
        if RST = '1' then

            counter <= to_unsigned(0, log2_ceil(c_B_WIDTH+1));
            sample_rdy <= '0';

        elsif rising_edge(CLK) then

            sample_rdy <= '0';
            
            if counter > 1 then
                -- Computing 
                if Bs(Bs'HIGH) = '1' then

                    Cs(c_C_WIDTH downto 1) <= Cs(c_C_WIDTH-1 downto 0) + As;
                    Cs(0) <= '0';

                else

                    Cs(c_C_WIDTH downto 1) <= Cs(c_C_WIDTH-1 downto 0);
                    Cs(0) <= '0';

                end if;

                Bs(c_B_WIDTH-1 downto 1) <= Bs(c_B_WIDTH-2 downto 0);

                counter <= counter - 1;

            else

                if counter = 1 then
                    -- Signalling ready
                    sample_rdy <= '1';
                    C <= std_logic_vector(Cs(c_C_WIDTH downto 1));

                    counter <= counter - 1;
                end if;

                if sample_rdy_in = '1' then
                    -- New input
                    As <= unsigned(A);
                    Bs <= unsigned(B);

                    Cs <= (others => '0');
                
                    counter <= to_unsigned(c_B_WIDTH+1, log2_ceil(c_B_WIDTH+2));
                end if;

            end if;

        end if;
    end process;

end Behavioral;
