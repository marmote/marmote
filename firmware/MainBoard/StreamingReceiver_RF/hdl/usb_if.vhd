library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

use work.common.all;   

entity USB_IF is
    generic (
--		c_FROM_ADC_SMPL_CNTR_MAX		: integer := c_FRAME_SMPLS - 1;				-- The max number of samples (if counting starts with 0) 
        c_FROM_ADC_SMPL_CNTR_WIDTH 		: integer := log2_ceil(c_FROM_ADC_SMPL_CNTR_MAX);  -- The bit width to store the above

--		c_TO_TEMPREG_SMPL_CNTR_MAX		: integer := c_FRAME_SMPLS;		-- 1 + the max number of samples (if counting starts with 0) 
																		-- (The 1+ comes from the fact that for every sample buffer we 
																		-- add a 32 bit frame counter at the beginning)
        c_TO_TEMPREG_SMPL_CNTR_WIDTH	: integer := log2_ceil(c_TO_TEMPREG_SMPL_CNTR_MAX)	-- The bit width to store the above
    );

    port (
        -- Internal interface
        CLK         		: in	std_logic;
        RST_n         		: in	std_logic;

		------------------------------------
		-- FIFO
		-- FIFO misc
		FROM_ADC_SMPL_RDY	: in	std_logic;

		-- FIFO interface
		FIFO_WE				: out	std_logic;
		FIFO_RE				: out	std_logic;
        FIFO_DATA_OUT		: in	std_logic_vector(31 downto 0);
		FIFO_EMPTY			: in	std_logic;
		FIFO_AEMPTY			: in	std_logic;

		------------------------------------
		-- USB
		-- USB misc

        -- USB (FTDI) interface
        USB_CLK_pin 		: in	std_logic;
		USB_CLK_OUT			: out	std_logic;

        USB_TXE_n_pin  		: in	std_logic;
        USB_RXF_n_pin  		: in	std_logic;
        USB_DATA_pin   		: inout	std_logic_vector(7 downto 0);
        USB_WR_n_pin   		: out	std_logic;
        USB_RD_n_pin   		: out	std_logic;
		USB_OE_n_pin		: out	std_logic;

		READ_FROM_USB_REG	: out	std_logic_vector(7 downto 0);
		FROM_USB_RDY		: out	std_logic;
		READ_SUCCESSFUL		: in	std_logic
    );
end entity;


architecture Behavioral of USB_IF is

    -- Components
    component CLKBUF
        port( PAD : in    std_logic := 'U';
              Y   : out   std_logic
          );
    end component;

    component BIBUF_LVCMOS33
        port( PAD : inout   std_logic;
              D   : in    std_logic := 'U';
              E   : in    std_logic := 'U';
              Y   : out   std_logic
          );
    end component;


    -- Constants
	constant c_TEMPREG_EMPTY		: unsigned(4 downto 0)	:= B"10000";
	constant c_TEMPREG_FIFO_READ	: unsigned(4 downto 0)	:= B"00010";
	constant c_TEMPREG_FULL			: unsigned(4 downto 0)	:= B"00001";

-- 	constant c_USBREG_EMPTY			: unsigned(0 downto 0)	:= B"1";
-- 	constant c_USBREG_FULL			: unsigned(0 downto 0)	:= B"0";

	constant c_START_OF_FRAME		: unsigned(23 downto 0)	:= x"A1BEAF";
	constant c_FRAME_TYPE			: unsigned(7 downto 0)	:= x"01";


    -- Signals
	signal s_FROM_ADC_SMPL_CNTR		: unsigned(c_FROM_ADC_SMPL_CNTR_WIDTH - 1 downto 0);	-- Count samples coming from ADC to FIFO
	signal s_FRAME_CNTR				: unsigned(31 downto 0);  								-- Continously count the number of full frames (even if not stored in FIFO)
	signal s_FRAME_CURRENT_CNTR		: unsigned(31 downto 0);  								-- Counter value for the frame currently in the FIFO
	signal s_STORE_SAMPLES			: std_logic;											-- Indicates whether samples should be stored in the FIFO or not


	signal s_TO_TEMPREG_SMPL_CNTR	: unsigned(c_TO_TEMPREG_SMPL_CNTR_WIDTH - 1 downto 0);	-- Count samples coming from FIFO to temporary register
	signal s_TEMP_REG				: std_logic_vector(31 downto 0);						-- Temp register for a sample (IQ pair) from FIFO waiting to be sent via USB
	signal s_TEMP_REG_STATE			: unsigned(4 downto 0);									-- 5 bit wide reg, shows TEMP_REG is empty, full, or FIFO read was initiated

--	signal s_READ_FROM_USB_REG		: std_logic_vector(7 downto 0);
	signal s_READ_FROM_USB_REG_FULL : std_logic;

    signal s_USB_CLK				: std_logic;
	signal s_USB_SMPL_BYTE_CNTR		: unsigned(1 downto 0);									-- USB transmits 1 byte at a time, counts were we are in the 32 bit TEMP_REG
	signal s_USB_WR_n_pin   		: std_logic;
	signal s_USB_RD_n_pin			: std_logic;

    signal s_oe     				: std_logic;
    signal s_obuf   				: std_logic_vector(7 downto 0);
    signal s_ibuf					: std_logic_vector(7 downto 0);

begin

    -- Port maps

    u_USB_CLKBUF : CLKBUF
      port map(PAD => USB_CLK_pin, Y => s_USB_CLK);

	USB_CLK_OUT <= s_USB_CLK;


    g_USB_SYNC_FIFO_DATA : for i in 0 to 7 generate

        u_BIBUF_LVCMOS33 : BIBUF_LVCMOS33
        port map (
            PAD => USB_DATA_pin(i),
            D   => s_obuf(i),
            E   => s_oe,
            Y   => s_ibuf(i)
        );

    end generate g_USB_SYNC_FIFO_DATA;

        
    -- Processes

----------------------------------------------------------------------------------------
-- Read from ADC and store complete frames in the FIFO
----------------------------------------------------------------------------------------
    process (RST_n, CLK)
    begin
        if RST_n = '0' then
			s_STORE_SAMPLES			<= '1';									-- Yes, I would like to store samples in FIFO
			s_FRAME_CNTR			<= x"00000001";							-- We start with the frame 1 (one step ahead of s_FRAME_CURRENT_CNTR)
			s_FRAME_CURRENT_CNTR	<= (others => '0');						-- The very first frame is going to be stored in the FIFO
			s_FROM_ADC_SMPL_CNTR	<= (others => '0');						-- We start with the very first sample 0

        elsif rising_edge(CLK) then
			if FROM_ADC_SMPL_RDY = '1' then									-- We have a new sample

				s_FROM_ADC_SMPL_CNTR <= s_FROM_ADC_SMPL_CNTR + 1;

				if s_FROM_ADC_SMPL_CNTR = c_FROM_ADC_SMPL_CNTR_MAX then		-- This marks the end of the frame and the beginning of a new

					s_FROM_ADC_SMPL_CNTR <= (others => '0');

					s_FRAME_CNTR <= s_FRAME_CNTR + 1;						-- The frame is done, moving on to the next

					-- We have to make a decision here: Do we have enough free buffer space in the FIFO to store a new complete frame?
					-- If yes, we'll store the samples, if no, we'll discard the samples
					s_STORE_SAMPLES <= '0'; 								-- By default no
					if FIFO_AEMPTY = '1' then 								-- If however the FIFO is almost empty
						s_STORE_SAMPLES <= '1';
						s_FRAME_CURRENT_CNTR <= s_FRAME_CNTR;				-- If we decide to store samples, we'll store the frame number for them as well
					end if;

				end if;
			end if;
        end if;
    end process;


	FIFO_WE <= not (FROM_ADC_SMPL_RDY and s_STORE_SAMPLES);					-- If we store samples AND we have a new sample, then we enable FIFO write (active low)



----------------------------------------------------------------------------------------
-- Move the next 32 bit sample from FIFO to temp register, 
-- so it can get transmitted to USB in 8 bit chunks
----------------------------------------------------------------------------------------
    process (RST_n, s_USB_CLK)
    begin
        if RST_n = '0' then

			s_TEMP_REG				<= (others => '0');
			s_TO_TEMPREG_SMPL_CNTR	<= (others => '0');
			s_TEMP_REG_STATE		<= c_TEMPREG_EMPTY;						-- Start out with an empty TEMP_REG
			FIFO_RE					<= '1';									-- FIFO read is not enabled, we are not reading from the FIFO

			READ_FROM_USB_REG		<= (others => '0');
			s_READ_FROM_USB_REG_FULL <= '0';
			FROM_USB_RDY			<= '0';

			--------------------------------
			s_USB_SMPL_BYTE_CNTR	<= (others => '1');
			s_oe					<= '1';
			s_USB_WR_n_pin			<= '1';									-- We don't write to the USB
			s_USB_RD_n_pin			<= '1';									-- We don't read from the USB

        elsif rising_edge(s_USB_CLK) then

-----------------------------------------------------------
-- Move the next 32 bit sample from FIFO to temp register
--
			FIFO_RE	<= '1';													-- By default FIFO read is not enabled

			if s_TEMP_REG_STATE = c_TEMPREG_EMPTY and FIFO_EMPTY = '0' then						-- If TEMP_REG is empty but we have stuff in the FIFO

 				if s_TO_TEMPREG_SMPL_CNTR = to_unsigned(0, c_TO_TEMPREG_SMPL_CNTR_WIDTH) then  
				-- At the very beginning of the frame we send out the frame number

					s_TEMP_REG <= std_logic_vector(c_START_OF_FRAME & c_FRAME_TYPE);

					s_TEMP_REG_STATE <= c_TEMPREG_FULL;

--					s_TO_TEMPREG_SMPL_CNTR <= s_TO_TEMPREG_SMPL_CNTR + 1;	-- Increase sample counter
					s_TO_TEMPREG_SMPL_CNTR <= to_unsigned(1, c_TO_TEMPREG_SMPL_CNTR_WIDTH);	-- Increase sample counter

 				elsif s_TO_TEMPREG_SMPL_CNTR = to_unsigned(1, c_TO_TEMPREG_SMPL_CNTR_WIDTH) then  
				-- Second 32 bits of the frame we send out the frame number

					s_TEMP_REG <= std_logic_vector(s_FRAME_CURRENT_CNTR);	-- Copy current frame counter to the temporary register

					s_TEMP_REG_STATE <= c_TEMPREG_FULL;

--					s_TO_TEMPREG_SMPL_CNTR <= s_TO_TEMPREG_SMPL_CNTR + 1;	-- Increase sample counter
					s_TO_TEMPREG_SMPL_CNTR <= to_unsigned(2, c_TO_TEMPREG_SMPL_CNTR_WIDTH);	-- Increase sample counter

				else														-- Else we start a reading sequence to get one sample
					FIFO_RE <= '0';
					s_TEMP_REG_STATE(4 downto 0) <= s_TEMP_REG_STATE(0) & s_TEMP_REG_STATE(4 downto 1);
				end if;
	
			end if;

			-- If we initiated a reading sequence earlier we keep counting down until TEMP_REG gets filled
			if s_TEMP_REG_STATE(4) = '0' and  s_TEMP_REG_STATE(0) = '0' then
				s_TEMP_REG_STATE(4 downto 0) <= s_TEMP_REG_STATE(0) & s_TEMP_REG_STATE(4 downto 1);
			end if;

			-- If we initiated a reading sequence earlier once we've waited 3 cycles, we have one sample on the FIFO output,
			-- which we copy to the TEMP_REG
			if s_TEMP_REG_STATE = c_TEMPREG_FIFO_READ then
				s_TEMP_REG <= FIFO_DATA_OUT;

--				s_TEMP_REG <= x"DEADBEAF";							-- DEBUG

				s_TO_TEMPREG_SMPL_CNTR <= s_TO_TEMPREG_SMPL_CNTR + 1; 

				if s_TO_TEMPREG_SMPL_CNTR = c_TO_TEMPREG_SMPL_CNTR_MAX then
					s_TO_TEMPREG_SMPL_CNTR <= (others => '0');
				end if;
			end if;

-----------------------------------------------------------
-- Move 32 bit sample from temp register to USB in 8 bit chunks
--
			s_oe			<= '1';
			s_USB_WR_n_pin	<= '1';											-- By default we don't write to the USB
			s_USB_RD_n_pin	<= '1';											-- By default we don't read from the USB


			if USB_RXF_n_pin = '0' and s_USB_WR_n_pin = '1' and	-- If there is stuff to read from the FTDI and no writing is currently going on
				s_READ_FROM_USB_REG_FULL = '0' and READ_SUCCESSFUL = '0' then	-- If USB temp read reg is empty and last read already finished

				s_oe			<= '0';

				if s_oe = '0' then 
					s_USB_RD_n_pin	<= '0';
				end if;

			elsif s_TEMP_REG_STATE = c_TEMPREG_FULL and USB_TXE_n_pin = '0' then	-- If we have stuff to write (TEMP_REG is not empty) AND we can start writing to USB
--				s_oe			<= '1';
--				s_USB_WR_n_pin	<= '0';
			end if;


-----------------------------------------------------------
			if USB_TXE_n_pin = '0' and s_USB_WR_n_pin = '0' then			-- If write to USB was actually successfull

				s_TEMP_REG(31 downto 8) <= s_TEMP_REG(23 downto 0); 
--				s_TEMP_REG(23 downto 0) <= s_TEMP_REG(31 downto 8); 

				s_USB_SMPL_BYTE_CNTR <= s_USB_SMPL_BYTE_CNTR - 1;

				if s_USB_SMPL_BYTE_CNTR = to_unsigned(0, 2) then
					s_TEMP_REG_STATE <= c_TEMPREG_EMPTY;

--					s_oe			<= '0';									-- There is actually nothing left to write to USB
					s_USB_WR_n_pin	<= '1';		
				end if;

			end if;

-----------------------------------------------------------
			FROM_USB_RDY <= s_READ_FROM_USB_REG_FULL;						-- We're doing it in the process so we have one clck cycle delay to the actual data

			if USB_RXF_n_pin = '0' and s_USB_RD_n_pin = '0' then			-- If read from USB was actually successfull

				READ_FROM_USB_REG <= s_ibuf;
				s_READ_FROM_USB_REG_FULL <= '1';
				
				s_oe			<= '1';
				s_USB_RD_n_pin	<= '1';	
			end if;

			if READ_SUCCESSFUL = '1' then
				s_READ_FROM_USB_REG_FULL <= '0';
				FROM_USB_RDY <= '0';
			end if;


        end if;
    end process;

	s_obuf <= s_TEMP_REG(31 downto 24);
--	s_obuf <= s_TEMP_REG(7 downto 0);
	USB_WR_n_pin <= s_USB_WR_n_pin;
	USB_RD_n_pin <= s_USB_RD_n_pin;
	USB_OE_n_pin <= s_oe;

	
end Behavioral;
