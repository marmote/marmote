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
entity ADDERSUBTRACTOR is
    generic (
        c_A_WIDTH       : integer := 22;
        c_B_WIDTH       : integer := 22;
        c_C_WIDTH       : integer := 23 -- MUST BE max(c_A_WIDTH,c_B_WIDTH)+1
    );

    port (
		CLK             : in    std_logic;
		RST             : in    std_logic;

        addsubtract     : in    std_logic; -- 0 subtract, 1 add

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
architecture Behavioral of ADDERSUBTRACTOR is
    signal As       : signed(c_A_WIDTH downto 0);
    signal Bs       : signed(c_B_WIDTH downto 0);

begin

    process(RST, CLK)
--    process(CLK)
    begin
        if RST = '1' then

            C <= (others => '0');

        elsif rising_edge(CLK) then
--        if rising_edge(CLK) then

            if addsubtract = '1' then

                C <= std_logic_vector(As + Bs);

            else

                C <= std_logic_vector(As - Bs);

            end if;

        end if;
    end process;

    As(c_A_WIDTH-1 downto 0) <= signed(A);
    As(c_A_WIDTH) <= A(c_A_WIDTH-1);
    Bs(c_B_WIDTH-1 downto 0) <= signed(B);
    Bs(c_B_WIDTH) <= B(c_B_WIDTH-1);

end Behavioral;
