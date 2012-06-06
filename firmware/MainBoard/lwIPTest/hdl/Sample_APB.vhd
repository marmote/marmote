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
    generic (
    	c_APB3_INPUT_WIDTH     : integer := 16
    );

    port (

        PCLK        : in    std_logic;
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
        INPUT       : in    std_logic_vector(2*c_APB3_INPUT_WIDTH-1 downto 0);

--        SMPL_RDY_IN : in    std_logic;


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

    subtype sample_type is std_logic_vector(c_APB3_INPUT_WIDTH-1 downto 0);
    type sample_vector is array ( natural range <> ) of sample_type;

    subtype sample_out_type is std_logic_vector(15 downto 0);
    type sample_out_vector is array ( natural range <> ) of sample_out_type;

-- APB3 interface
    -- Addresses
    constant c_ADDR_DATA    : std_logic_vector(7 downto 0) := x"00"; -- Read only
--    constant c_ADDR_COUNTER : std_logic_vector(7 downto 0) := x"04"; -- Read only  -- NO MORE SPACE LEFT :(

    -- Default values (based on the Matlab simulation results)
    constant c_DEFAULT_DATA      : unsigned(31 downto 0) := x"00000000"; 
    constant c_WRONGADDRESS_DATA : unsigned(31 downto 0) := x"55555555";


-- misc
    signal samples_out      : sample_out_vector(1 to 2);   
    
--    signal test_counter     : unsigned(15 downto 0);  -- NO MORE SPACE LEFT IN FPGA FABRIC :(
--    signal test_rev_counter : unsigned(15 downto 0);  -- NO MORE SPACE LEFT IN FPGA FABRIC :(

begin

--------------------------------------
--          APB3 interface          --
--------------------------------------

    -- APB register read
    p_REG_READ : process (PRESETn, PCLK)
    begin
        if PRESETn = '0' then
--            PREADY <= '0';
            PRDATA <= std_logic_vector(c_DEFAULT_DATA);

        elsif rising_edge(PCLK) then

            -- Default output
--            PREADY <= '0';
            PRDATA <= std_logic_vector(c_DEFAULT_DATA);

            -- Register reads
            if PWRITE = '0' and PSELx = '1' then
                case PADDR(7 downto 0) is
                    when c_ADDR_DATA =>
                        PRDATA <= samples_out(1) & samples_out(2);

--                    when c_ADDR_COUNTER =>
--                        PRDATA <= std_logic_vector(test_counter) & std_logic_vector(test_rev_counter);

                    when others =>
                        PRDATA <= std_logic_vector(c_WRONGADDRESS_DATA);

                end case;
            end if;

        end if;

    end process p_REG_READ;


    -- APB misc
    PREADY <= '1';
    PSLVERR <= '0';


----------------------------------
--          DDC interface       --
----------------------------------

    -- Sampling
    process(PCLK, PRESETn)
        variable i      : integer :=0;        
    begin
        if PRESETn = '0' then 
        
            SMPL_RDY <= '0';

        elsif rising_edge(PCLK) then

            SMPL_RDY <= '1';

            i := 1;
            while i <= 2 loop
            	samples_out(i) <= INPUT( i*c_APB3_INPUT_WIDTH-1 downto (i-1)*c_APB3_INPUT_WIDTH );

                i := i + 1;
            end loop;                

        end if;
    end process;

end Behavioral;
