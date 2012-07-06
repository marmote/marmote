library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Entity definition
--
------------------------------------------------------------------------------
entity SAMPLE_APB is

    port (

        PCLK        : in    std_logic; -- Fast clock, >80MHz
        PRESETn     : in    std_logic;

-- APB3 interface
        PADDR       : in    std_logic_vector(31 downto 0);
        PSELx       : in    std_logic;
        PENABLE     : in    std_logic;
        PWRITE      : in    std_logic;
        PWDATA      : in    std_logic_vector(31 downto 0);

        PREADY      : out   std_logic;
        PRDATA      : out   std_logic_vector(31 downto 0);
        PSLVERR     : out   std_logic;


-- DDC interface
        INPUT       : in    std_logic_vector(7 downto 0);
		READ_SUCCESSFUL : out std_logic;
		FROM_USB_RDY : in	std_logic;


-- Misc
        SMPL_RDY    : out   std_logic
        

         );
end entity;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of SAMPLE_APB is

-- APB3 interface
    -- Addresses
    constant c_ADDR_DATA    : std_logic_vector(7 downto 0) := x"00"; -- Read only
   -- constant c_ADDR_COUNTER : std_logic_vector(7 downto 0) := x"04"; -- Read only  -- NO MORE SPACE LEFT :(

    -- Default values (based on the Matlab simulation results)
    constant c_DEFAULT_DATA      : unsigned(31 downto 0) := x"00000000"; 
    constant c_WRONGADDRESS_DATA : unsigned(31 downto 0) := x"55555555";


-- misc
    signal REG      		: std_logic_vector(7 downto 0);
	signal s_REG_FULL		: std_logic;  
	signal s_READ_SUCCESSFUL : std_logic;

    
begin

--------------------------------------
--          APB3 interface          --
--------------------------------------

    -- APB register read
    p_REG_READ : process (PRESETn, PCLK)
    begin
        if PRESETn = '0' then
      --     PREADY <= '0';
           PRDATA <= std_logic_vector(c_DEFAULT_DATA);

			SMPL_RDY <= '0';
			s_READ_SUCCESSFUL <= '0';
			s_REG_FULL <= '0';

        elsif rising_edge(PCLK) then

            -- Default output
     --       PREADY <= '0';
            PRDATA <= std_logic_vector(c_DEFAULT_DATA);

            -- Register reads
            if PWRITE = '0' and PSELx = '1' then
                case PADDR(7 downto 0) is
                    when c_ADDR_DATA =>
                        PRDATA <= x"000000" & REG;

						s_REG_FULL <= '0';

    --            when c_ADDR_COUNTER =>
    --                PRDATA <= std_logic_vector(test_counter) & std_logic_vector(test_rev_counter);

                  when others =>
                      PRDATA <= std_logic_vector(c_WRONGADDRESS_DATA);

                end case;
            end if;


----------------------------------
--          DDC interface       --
----------------------------------

			
			SMPL_RDY <= '0';

			if s_REG_FULL = '0' then
				if FROM_USB_RDY = '1' and s_READ_SUCCESSFUL = '0' then
					REG <= INPUT;
					SMPL_RDY <= '1';

					s_REG_FULL <= '1';
					s_READ_SUCCESSFUL <= '1';
				end if;

				if FROM_USB_RDY = '0' and s_READ_SUCCESSFUL = '1' then
					s_READ_SUCCESSFUL <= '0';
				end if;
			end if;

        end if;

    end process p_REG_READ;


	READ_SUCCESSFUL <= s_READ_SUCCESSFUL;


    -- APB misc
    PREADY <= '1';
    PSLVERR <= '0';

end Behavioral;
