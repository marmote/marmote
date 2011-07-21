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
entity SIGN_CORRECTOR is
	port (
		CLK       : in  std_logic;
		RST       : in  std_logic;

		INV_EN    : in  std_logic;
        RDY_IN    : in  std_logic;
  		COS_IN    : in  std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
		SIN_IN    : in  std_logic_vector(c_CORDIC_WIDTH-1 downto 0);

		COS_OUT   : out std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
		SIN_OUT   : out std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
        RDYOUT    : out std_logic
	);
end entity; 


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of SIGN_CORRECTOR is

--	constant c_ZERO : signed(c_CORDIC_WIDTH-1 downto 0) :=
--		to_signed(0, c_CORDIC_WIDTH);

    signal s_RDY_IN         : std_logic;

begin
	invert_sincos : process (rst, clk)
	begin
		if rst = '1' then
			COS_OUT <= (others => '0');
			SIN_OUT <= (others => '0');
            RDYOUT <= '0';

		elsif rising_edge(clk) then
            s_RDY_IN <= RDY_IN;
            RDYOUT <= s_RDY_IN;

            if s_RDY_IN = '1' then
                if INV_EN = '1' then
                    COS_OUT <= std_logic_vector(to_signed(0, c_CORDIC_WIDTH) - signed(COS_IN));
                    SIN_OUT <= std_logic_vector(to_signed(0, c_CORDIC_WIDTH) - signed(SIN_IN));
                else
                    COS_OUT <= COS_IN;
                    SIN_OUT <= SIN_IN;
                end if;
			end if;
		end if;
	end process invert_sincos;

end Behavioral;
