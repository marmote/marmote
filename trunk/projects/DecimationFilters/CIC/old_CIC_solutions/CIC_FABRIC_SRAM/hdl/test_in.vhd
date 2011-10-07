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
entity test_in is
    generic (
        c_CIC_INNER_WIDTH  : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER
    );

   	port (
		INPUT     : in  std_logic;
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
architecture Behavioral of test_in is
begin

    output  <= INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT & INPUT;

end Behavioral;
