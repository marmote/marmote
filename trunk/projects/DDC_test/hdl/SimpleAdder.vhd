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
entity SimpleAdder is
    generic (
        c_A_WIDTH       : integer := 14;
        c_B_WIDTH       : integer := 14;
        c_C_WIDTH       : integer := 14 -- MUST BE max(c_A_WIDTH,c_B_WIDTH)+1
    );

    port (
		CLK             : in    std_logic;


        A               : in    std_logic_vector(c_A_WIDTH-1 downto 0);
        B               : in    std_logic_vector(c_B_WIDTH-1 downto 0);
        
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
architecture Behavioral of SimpleAdder is

begin

    process(CLK)
    begin
        if rising_edge(CLK) then

            C <= std_logic_vector(signed(A) + signed(B));

        end if;
    end process;

end Behavioral;
