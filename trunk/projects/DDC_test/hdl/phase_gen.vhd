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
entity PHASE_GEN is

    generic (
        c_COUNTER_WIDTH   : integer := log2_ceil(c_CORDIC_WIDTH+2)
    );

	port (
		CLK       : in  std_logic;
		RST       : in  std_logic;

		DPHASE    : in  std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
		DPHASE_EN : in  std_logic;

		MAGNITUDE : out std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
		PHASE     : out std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
		PHASE_EN  : out std_logic;
        INV_EN    : out std_logic
	);
end entity; 


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of PHASE_GEN is

	-- Constants
	constant c_MAGNITUDE    : unsigned(c_CORDIC_WIDTH-1 downto 0) := x"26DD";

	-- Signals
	signal s_phase_acc      : unsigned(c_CORDIC_WIDTH-1 downto 0);
	signal s_phase_en_ctr   : unsigned(c_COUNTER_WIDTH-1 downto 0);
	signal s_phase_en       : std_logic;

    signal s_inv_en         : std_logic;

begin

	-- Generate phase_en periodically
    -- WARNING!! 
    -- ASSUMING THAT BIT WIDTH IS THE SAME AS NUMBER OF ITERATIONS FOR CORDIC!!!
    -- WARNING!! 
	p_phase_en : process (rst, clk)
	begin
		if rst = '1' then
			s_phase_en_ctr <= (others => '0');
		elsif rising_edge(clk) then

			s_phase_en <= '0';
			if s_phase_en_ctr < c_CORDIC_WIDTH + 1 then
				s_phase_en_ctr <= s_phase_en_ctr + 1;
			else
                s_phase_en <= '1';
				s_phase_en_ctr <= (others => '0');
			end if;

            phase_en    <= s_phase_en;

		end if;
	end process p_phase_en;



	p_phase_acc : process (rst, clk)
	begin
		if rst = '1' then
			s_phase_acc     <= (others => '0');
--			s_phase_acc     <= x"BF8F";
            s_inv_en        <= '0';
		elsif rising_edge(clk) then

			if dphase_en = '1' and s_phase_en = '1' then

				s_phase_acc <= s_phase_acc + unsigned(dphase);

                s_inv_en   <= '0';
                if s_phase_acc(s_phase_acc'high) = not s_phase_acc(s_phase_acc'high-1) then
                    s_inv_en <= '1';
                end if;

    	    end if;

		end if;
	end process p_phase_acc;

	-- Assign the output signals
	magnitude   <= std_logic_vector(c_MAGNITUDE);
	phase       <= s_phase_acc(s_phase_acc'high - 1) & std_logic_vector(s_phase_acc(c_CORDIC_WIDTH-2 downto 0));
    INV_EN      <= s_inv_en;

end Behavioral;
