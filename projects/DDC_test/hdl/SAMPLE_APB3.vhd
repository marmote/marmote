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
entity SAMPLE_APB3 is
    generic (
        c_WAIT_CYCLES       : integer := 18;
        c_BIT_SHIFT         : integer := c_APB3_INPUT_WIDTH - c_APB3_WIDTH/2 + 1
    );

    port (

        PCLK        : in    std_logic;
        PRESETn     : in    std_logic;


-- APB3 interface
        PADDR       : in    std_logic_vector(31 downto 0);
        PSEL        : in    std_logic;
        PENABLE     : in    std_logic;
        PWRITE      : in    std_logic;
        PWDATA      : in    std_logic_vector(31 downto 0);

        PREADY      : out   std_logic;
        PRDATA      : out   std_logic_vector(31 downto 0);
        PSLVERR     : out   std_logic;


-- DDC interface
        INPUT       : in    std_logic_vector(2*c_APB3_INPUT_WIDTH-1 downto 0);
--        shift       : in    std_logic_vector(log2_ceil(c_BIT_SHIFT)-1 downto 0);   
        DPHASE      : out   std_logic_vector(15 downto 0);
        DC_OFFSETI  : out   std_logic_vector(13 downto 0);
        DC_OFFSETQ  : out   std_logic_vector(13 downto 0);


        SMPL_RDY_IN : in    std_logic;


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
architecture Behavioral of SAMPLE_APB3 is

    subtype sample_type is std_logic_vector(c_APB3_INPUT_WIDTH-1 downto 0);
    type sample_vector is array ( natural range <> ) of sample_type;

    subtype sample_out_type is std_logic_vector(15 downto 0);
    type sample_out_vector is array ( natural range <> ) of sample_out_type;

-- APB3 interface
    -- Addresses
    constant c_ADDR_DATA    : std_logic_vector(7 downto 0) := x"00"; -- Read only
--    constant c_ADDR_COUNTER : std_logic_vector(7 downto 0) := x"04"; -- Read only  -- NO MORE SPACE LEFT :(
    constant c_ADDR_SHIFT   : std_logic_vector(7 downto 0) := x"08"; -- Write only
    constant c_ADDR_DPHASE  : std_logic_vector(7 downto 0) := x"0C"; -- Write only
    constant c_ADDR_DCOFFset: std_logic_vector(7 downto 0) := x"10"; -- Write only

    -- Default values (based on the Matlab simulation results)
    constant c_DEFAULT_DATA      : unsigned(31 downto 0) := x"00000000"; 
    constant c_WRONGADDRESS_DATA : unsigned(31 downto 0) := x"55555555";


-- misc
    signal samples          : sample_vector(1 to 2);    -- Parallel sample data out
    signal samples_out      : sample_out_vector(1 to 2);   
    
    signal SMPL_RDY_signal  : std_logic;

    signal shift            : unsigned(log2_ceil(c_BIT_SHIFT)-1 downto 0);   
    signal shift_counter    : unsigned(log2_ceil(c_BIT_SHIFT)-1 downto 0);   
    
--    signal test_counter     : unsigned(15 downto 0);  -- NO MORE SPACE LEFT :(
--    signal test_rev_counter : unsigned(15 downto 0);  -- NO MORE SPACE LEFT :(

begin

--------------------------------------
--          APB3 interface          --
--------------------------------------

    -- APB register write
    p_REG_WRITE : process (PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            shift <= (others => '0');
            DPHASE <= (others => '0');

        elsif rising_edge(PCLK) then

            -- Default values
    --         s_start <= '0';

            -- Register writes
            -- FIXME: allow writes only when no transmission is in progress
            if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
                case PADDR(7 downto 0) is
                    when c_ADDR_SHIFT =>
                        shift <= unsigned(PWDATA(log2_ceil(c_BIT_SHIFT)-1 downto 0));
                    when c_ADDR_DPHASE =>
                        DPHASE <= PWDATA(15 downto 0);
                    when c_ADDR_DCOFFset =>
                        DC_OFFSETQ <= PWDATA(13 downto 0);
                        DC_OFFSETI <= PWDATA(29 downto 16);
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;


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
            if PWRITE = '0' and PSEL = '1' then
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
            shift_counter <= (others => '0'); 
        
--            test_counter <= (others => '0');
--            test_rev_counter <= (others => '0');

            SMPL_RDY_signal <= '0';

        elsif rising_edge(PCLK) then

            SMPL_RDY_signal <= '0';

            if shift_counter > 0 then

                shift_counter <= shift_counter - 1;

                i := 1;
                while i <= 2 loop
                    samples(i)(c_APB3_INPUT_WIDTH-1 downto 1) <= samples(i)(c_APB3_INPUT_WIDTH-2 downto 0);

                    i := i + 1;
                end loop;

                if shift_counter = 1 then
                    SMPL_RDY_signal <= '1';
                end if;
                

            elsif SMPL_RDY_IN = '1' then

                i := 1;
                while i <= 2 loop
                    samples(i) <= INPUT( i*c_APB3_INPUT_WIDTH-1 downto (i-1)*c_APB3_INPUT_WIDTH );

                    i := i + 1;
                end loop;

                if unsigned(shift) = 0 then
                    SMPL_RDY_signal <= '1';
                end if;

                shift_counter <= shift;   

--                test_counter <= test_counter + 1;
--                test_rev_counter <= test_rev_counter - 1;

            end if;

        end if;
    end process;


    process(PCLK, PRESETn)
        variable i      : integer :=0;        
    begin
        if PRESETn = '0' then 
        
            SMPL_RDY <= '0';

        elsif rising_edge(PCLK) then

            SMPL_RDY <= SMPL_RDY_signal;

            if SMPL_RDY_signal = '1' then

                i := 1;
                while i <= 2 loop
                    samples_out(i) <= samples(i)(c_APB3_INPUT_WIDTH-1 downto c_APB3_INPUT_WIDTH-16);

                    i := i + 1;
                end loop;                

            end if;

        end if;
    end process;

end Behavioral;
