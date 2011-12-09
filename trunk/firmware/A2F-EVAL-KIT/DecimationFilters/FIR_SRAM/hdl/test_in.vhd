library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;

library synplify; 
use synplify.attributes.all; 
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Entity definition
--
------------------------------------------------------------------------------
entity test_in is
    generic (
        c_WIDTH  : integer := 22
    );

   	port (
		INPUT     : in  std_logic;
        OUTPUT    : out std_logic_vector(c_WIDTH-1 downto 0)
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

    output  <=  INPUT & INPUT & INPUT & INPUT & INPUT & 
                INPUT & INPUT & INPUT & INPUT & INPUT & 
                INPUT & INPUT & INPUT & INPUT & INPUT & 
                INPUT & INPUT & INPUT & INPUT & INPUT & 
                INPUT & INPUT;

end Behavioral;
