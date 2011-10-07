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
entity test is
    generic (
        c_CIC_INNER_WIDTH  : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER
    );

   	port (
		INPUT     : in  std_logic_vector(c_CIC_INNER_WIDTH-1 downto 0);
        OUTPUT    : out std_logic  
	);
end entity; 


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of test is
begin

    output  <= INPUT(37) and INPUT(36) and INPUT(35) and INPUT(34) and INPUT(33) and INPUT(32) and INPUT(31) and INPUT(30) and INPUT(29) and INPUT(28) and INPUT(27) and INPUT(26) and INPUT(25) and INPUT(24) and INPUT(23) and INPUT(22) and INPUT(21) and INPUT(20) and INPUT(19) and INPUT(18) and INPUT(17) and INPUT(16) and INPUT(15) and INPUT(14) and INPUT(13) and INPUT(12) and INPUT(11) and INPUT(10) and INPUT(9) and INPUT(8) and INPUT(7) and INPUT(6) and INPUT(5) and INPUT(4) and INPUT(3) and INPUT(2) and INPUT(1) and INPUT(0);

end Behavioral;
