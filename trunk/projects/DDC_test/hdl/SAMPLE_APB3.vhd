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
        c_WAIT_CYCLES       : integer := 18
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
        INPUT       : in    std_logic_vector(2*c_APB3_WIDTH-1 downto 0);

        SMPL_RDY_IN : in    std_logic_vector(1 to 2);

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

    subtype sample_type is std_logic_vector(c_APB3_WIDTH-1 downto 0);
    type sample_vector is array ( natural range <> ) of sample_type;


-- APB3 interface
    -- Addresses
    constant c_ADDR_DATA    : std_logic_vector(7 downto 0) := x"00"; -- Read only
    constant c_ADDR_COUNTER : std_logic_vector(7 downto 0) := x"04"; -- Read only

    -- Default values (based on the Matlab simulation results)
    constant c_DEFAULT_DATA      : unsigned(31 downto 0) := x"00000000"; 
    constant c_WRONGADDRESS_DATA : unsigned(31 downto 0) := x"55555555";

    signal oddeven_APB  : std_logic;
    signal recent_read  : std_logic;



-- misc

    signal oddeven_SMPL : std_logic;

    signal samples      : sample_vector(1 to 2);    -- Parallel sample data out   
    
    signal new_sample   : std_logic_vector(1 to 2);

    signal wait_counter : unsigned( log2_ceil(c_WAIT_CYCLES) downto 1 );
    
    
    signal test_counter     : unsigned(c_APB3_WIDTH-1 downto 0);  
    signal test_rev_counter : unsigned(c_APB3_WIDTH-1 downto 0);  

begin

--------------------------------------
--          APB3 interface          --
--------------------------------------

    -- APB register write
    p_REG_WRITE : process (PRESETn, PCLK)
    begin
        if PRESETn = '0' then
    --        s_start <= '0';
    --        s_correlation_delay  <= std_logic_vector(c_DEFAULT_CORD);
        elsif rising_edge(PCLK) then

            -- Default values
    --         s_start <= '0';

            -- Register writes
            -- FIXME: allow writes only when no transmission is in progress
            if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
                case PADDR(7 downto 0) is
    --                when c_ADDR_CTRL =>
    --                    s_start <= PWDATA(0);
    --                when c_ADDR_BAUD =>
    --                    s_baud <= PWDATA;
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
            PREADY <= '0';
            PRDATA <= std_logic_vector(c_DEFAULT_DATA);

            oddeven_APB <= '0';
            recent_read <= '0';

        elsif rising_edge(PCLK) then

            -- Default output
            PREADY <= '0';
            PRDATA <= std_logic_vector(c_DEFAULT_DATA);

            -- Register reads
            if PWRITE = '0' and PSEL = '1' then
                case PADDR(7 downto 0) is
                    when c_ADDR_DATA =>

--                        if oddeven_APB = '0' then
--                            PRDATA <= samples(1)(7 downto 0) & samples(1)(15 downto 8) & samples(1)(23 downto 16) & samples(1)(31 downto 24);
--                        else
--                            PRDATA <= samples(2)(7 downto 0) & samples(2)(15 downto 8) & samples(2)(23 downto 16) & samples(2)(31 downto 24);
--                        end if;
                        if oddeven_APB = '0' then
                            PRDATA <= samples(1);
                        else
                            PRDATA <= samples(2);
                        end if;


                        if recent_read = '0' then
                            recent_read <= '1';
                            PREADY <= '1';
                        end if;


                    when c_ADDR_COUNTER =>

--                        if oddeven_APB = '0' then
--                            PRDATA <= std_logic_vector(test_counter(7 downto 0)) & std_logic_vector(test_counter(15 downto 8)) & std_logic_vector(test_counter(23 downto 16)) & std_logic_vector(test_counter(31 downto 24));
--                        else
--                            PRDATA <= std_logic_vector(test_rev_counter(7 downto 0)) & std_logic_vector(test_rev_counter(15 downto 8)) & std_logic_vector(test_rev_counter(23 downto 16)) & std_logic_vector(test_rev_counter(31 downto 24));
--                        end if;
                        if oddeven_APB = '0' then
                            PRDATA <= std_logic_vector(test_counter);
                        else
                            PRDATA <= std_logic_vector(test_rev_counter);
                        end if;


                        if recent_read = '0' then
                            recent_read <= '1';
                            PREADY <= '1';
                        end if;


                    when others =>
                        PRDATA <= std_logic_vector(c_WRONGADDRESS_DATA);

                end case;
            end if;

            -- if sample was successfully read then the next sample should be from the other channel
            if PENABLE = '0' and recent_read = '1' then

                recent_read <= '0';

                oddeven_APB <= not oddeven_APB;

            end if;

        end if;

    end process p_REG_READ;


    -- APB misc
--    PREADY <= '1';
    PSLVERR <= '0';


----------------------------------
--          DDC interface       --
----------------------------------

    -- Sampling
    process(PCLK, PRESETn)
        variable i      : integer :=0;        
    begin
        if PRESETn = '0' then 
        
            test_counter <= (others => '0');
            test_rev_counter <= (others => '0');

        elsif rising_edge(PCLK) then

            i := 1;

            while i <= 2 loop
                if SMPL_RDY_IN(i) = '1' then
                    samples(i) <= INPUT( i*c_APB3_WIDTH-1 downto (i-1)*c_APB3_WIDTH );
--                    samples(i)(7 downto 0) <= (others => '1');
                end if;

                i := i + 1;
            end loop;


            if SMPL_RDY_IN(1) = '1' then
                test_counter <= test_counter + 1;
            end if;

            if SMPL_RDY_IN(2) = '1' then
                test_rev_counter <= test_rev_counter - 1;
            end if;

        end if;
    end process;


    -- indicate new sample ready
    process(PCLK, PRESETn)
        variable i      : integer :=0;        
    begin
        if PRESETn = '0' then 

            wait_counter <= to_unsigned(0, log2_ceil(c_WAIT_CYCLES));
            oddeven_SMPL <= '0';
        
        elsif rising_edge(PCLK) then

-- If minimal wait time is over and we have a new sample, indicate that read is possible
            SMPL_RDY <= '0';

            if wait_counter = 0 then

                -- Indicate new sample
                if ( oddeven_SMPL = '0' and new_sample(1) = '1' ) or ( oddeven_SMPL = '1' and new_sample(2) = '1' ) then
                    
                    SMPL_RDY <= '1';

                    wait_counter <= to_unsigned(c_WAIT_CYCLES, log2_ceil(c_WAIT_CYCLES));

                end if;


                -- Reset incoming new sample indicator
                if ( oddeven_SMPL = '0') then

                    new_sample(1) <= '0'; 

                elsif ( oddeven_SMPL = '1' ) then

                    new_sample(2) <= '0';

                end if;

                -- Switch to other channel
                oddeven_SMPL <= not oddeven_SMPL;

            else
                
                wait_counter <= wait_counter - 1;

            end if;


-- Set flag to indicate that new sample has been stored
            i := 1;

            while i <= 2 loop
                if SMPL_RDY_IN(i) = '1' then
                    new_sample(i) <= '1';
                end if;

                i := i + 1;
            end loop;

        end if;

    end process;


end Behavioral;
