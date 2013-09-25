-- TX_APB_IF.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 11.1 SP1
-- TARGET DEVICE: A2F500M3G (256 FBGA)
--   
-- Copyright (c) 2006-2013, Vanderbilt University
-- All rights reserved.
--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose, without fee, and without written agreement is
-- hereby granted, provided that the above copyright notice, the following
-- two paragraphs and the author appear in all copies of this software.
--
-- IN NO EVENT SHALL THE VANDERBILT UNIVERSITY BE LIABLE TO ANY PARTY FOR
-- DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
-- OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE VANDERBILT
-- UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-- THE VANDERBILT UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
-- INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
-- AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
-- ON AN "AS IS" BASIS, AND THE VANDERBILT UNIVERSITY HAS NO OBLIGATION TO
-- PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
------------------------------------------------------------------------------
--
-- Description: Simple OFDM-based tone-generator using 32-point IFFT.
--
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TX_APB_IF is
    generic (
         -- Default values
         g_PTRN : integer := 16#01660166#;  -- subcarrier pattern FIXME: check pattern PAPR
         g_MASK : integer := 16#7FFE7FFE#;  -- subcarrier mask
         g_GAIN : integer := 0;         -- amplitude gain = 2^g_GAIN
         g_MLEN : integer := 4          -- measurement length in symbols
    );
	port (
		 -- APB3 interface
		 PCLK    : in  std_logic;
		 PRESETn : in  std_logic;
		 PADDR	 : in  std_logic_vector(31 downto 0);
		 PSEL	 : in  std_logic;
		 PENABLE : in  std_logic;
		 PWRITE  : in  std_logic;
		 PWDATA  : in  std_logic_vector(31 downto 0);

		 PREADY  : out std_logic;
		 PRDATA  : out std_logic_vector(31 downto 0);
		 PSLVERR : out std_logic;

         TX_DONE_IRQ : out std_logic;

         TX_EN      : out std_logic;
         TX_I       : out std_logic_vector(9 downto 0);
         TX_Q       : out std_logic_vector(9 downto 0)
     );

end entity;

architecture Behavioral of TX_APB_IF is

    -- Constants

    constant c_FFT_OUT_WL   : integer := 13;
    constant c_FFT_IN_WL    : integer := 4;

	-- Addresses

	constant c_ADDR_CTRL    : std_logic_vector(7 downto 0) := x"00"; -- W (EN)
	constant c_ADDR_FIFO    : std_logic_vector(7 downto 0) := x"04"; -- W

	constant c_ADDR_PTRN    : std_logic_vector(7 downto 0) := x"10"; -- R/W
	constant c_ADDR_MASK    : std_logic_vector(7 downto 0) := x"14"; -- R/W
	constant c_ADDR_GAIN    : std_logic_vector(7 downto 0) := x"18"; -- R/W
	constant c_ADDR_MLEN    : std_logic_vector(7 downto 0) := x"1C"; -- R/W


    -- Components
    
    component FIFO_256x32 is
    generic (
        g_AFULL     : integer := 192;
        g_AEMPTY    : integer := 128
    );
    port (
        DIN    : in    std_logic_vector(31 downto 0);
        DOUT   : out   std_logic_vector(31 downto 0);
        WE     : in    std_logic;
        RE     : in    std_logic;
        WCLOCK : in    std_logic;
        RCLOCK : in    std_logic;
        FULL   : out   std_logic;
        EMPTY  : out   std_logic;
        RESET  : in    std_logic;
        AEMPTY : out   std_logic;
        AFULL  : out   std_logic
    );
    end component;

    component IFFT_CTRL is
    port (
        RST         : in  std_logic;
        CLK         : in  std_logic;

        IFFT_RST    : out std_logic;
        IFFT_EN     : out std_logic;
        IFFT_I      : out std_logic_vector(c_FFT_IN_WL-1 downto 0);
        IFFT_Q      : out std_logic_vector(c_FFT_IN_WL-1 downto 0);

        SYM         : in  std_logic_vector(31 downto 0);
        MASK        : in  std_logic_vector(31 downto 0);
        SYM_START   : in  std_logic;
        SYM_DONE    : out std_logic
    );
    end component;

    component IFFT_32 is
    port (
         clk : in std_logic;
         GlobalReset : in std_logic;
         VLD : out std_logic;
         RST : in std_logic;
         RDY : out std_logic;
         I_OUT : out std_logic_vector(c_FFT_OUT_WL-1 downto 0);
         Q_OUT : out std_logic_vector(c_FFT_OUT_WL-1 downto 0);
         I_IN : in std_logic_vector(c_FFT_IN_WL-1 downto 0);
         Q_IN : in std_logic_vector(c_FFT_IN_WL-1 downto 0);
         EN : in std_logic -- ufix1
    );
    end component IFFT_32;

	-- Registers

    signal s_ptrn       : std_logic_vector(31 downto 0);
    signal s_mask       : std_logic_vector(31 downto 0);
    signal s_gain       : std_logic_vector(3 downto 0);
    signal s_mlen       : std_logic_vector(15 downto 0);
    signal s_dlen       : std_logic_vector(15 downto 0);

    type tx_fsm_state_t is (
        st_IDLE,
        st_PREA,
        st_PYLD,
        st_MEAS,
        st_WAIT
    );

    signal s_tx_fsm_state       : tx_fsm_state_t; --:= st_IDLE;
    signal s_tx_fsm_state_next  : tx_fsm_state_t;

	-- Signals

    signal rst          : std_logic;
    alias  clk          : std_logic is PCLK;

    signal s_dout       : std_logic_vector(31 downto 0);
    signal s_state      : std_logic_vector(31 downto 0) := x"80000000";

    signal s_ifft_rst   : std_logic;
    signal s_ifft_en     : std_logic;
    signal s_i_in       : std_logic_vector(c_FFT_IN_WL-1 downto 0);
    signal s_q_in       : std_logic_vector(c_FFT_IN_WL-1 downto 0);
    signal s_vld        : std_logic;
    signal s_rdy        : std_logic;
    signal s_i_out      : std_logic_vector(c_FFT_OUT_WL-1 downto 0);
    signal s_q_out      : std_logic_vector(c_FFT_OUT_WL-1 downto 0);

    signal s_tx_i_out   : std_logic_vector(9 downto 0);
    signal s_tx_q_out   : std_logic_vector(9 downto 0);

    -- FSM
    signal s_data_start   : std_logic;
    signal s_meas_start : std_logic;
    signal s_tx_done    : std_logic;

    signal s_ptrn_buf       : std_logic_vector(31 downto 0);
    signal s_ptrn_buf_next  : std_logic_vector(31 downto 0);
    signal s_mask_buf       : std_logic_vector(31 downto 0);
    signal s_mask_buf_next  : std_logic_vector(31 downto 0);

    signal s_sym_start       : std_logic;
    signal s_sym_start_next  : std_logic;
    signal s_sym_done        : std_logic;

    signal s_tx_ctr         : unsigned(15 downto 0);
    signal s_tx_ctr_next    : unsigned(15 downto 0);

    signal s_dhold_ctr      : unsigned(15 downto 0);
    signal s_dhold_ctr_next : unsigned(15 downto 0);

    -- FIFO
    signal s_tx_fifo_in     : std_logic_vector(31 downto 0);
    signal s_tx_fifo_out    : std_logic_vector(31 downto 0);
    signal s_tx_fifo_wr     : std_logic;
    signal s_tx_fifo_rd     : std_logic;
    signal s_tx_fifo_full   : std_logic;
    signal s_tx_fifo_empty  : std_logic;
    signal s_tx_fifo_aempty : std_logic;


begin

    assert c_FFT_OUT_WL >= TX_I'length + 3
    report "c_FFT_OUT_WL >= TX_I'length + 3 condition was not met"
    severity failure;

    -- Port maps

    u_TX_FIFO : FIFO_256x32
    generic map (
        g_AFULL  => 248,
        g_AEMPTY => 4 -- FIXME
    )
    port map (
    	RESET   => RST,
    	DIN     => s_tx_fifo_in,
    	DOUT    => s_tx_fifo_out,
	    WCLOCK  => CLK,
    	WE      => s_tx_fifo_wr,
    	RCLOCK  => CLK,
    	RE      => s_tx_fifo_rd,
    	FULL    => s_tx_fifo_full,
    	EMPTY   => s_tx_fifo_empty,
        AFULL   => open,
        AEMPTY  => s_tx_fifo_aempty
	);

    u_IFFT_CTRL : IFFT_CTRL
    port map (
        RST         => RST,
        CLK         => CLK,
        IFFT_RST    => s_ifft_rst,
        IFFT_EN     => s_ifft_en,
        IFFT_I      => s_i_in,
        IFFT_Q      => s_q_in,

        SYM         => s_ptrn_buf,
        MASK        => s_mask_buf,
        SYM_START   => s_sym_start,
        SYM_DONE    => s_sym_done
    );


    u_IFFT_32 : IFFT_32
    port map (
         clk => clk,
         GlobalReset => rst,
         VLD => s_vld,
         RST => s_ifft_rst,
         RDY => s_rdy,
         I_IN => s_i_in,
         Q_IN => s_q_in,
         I_OUT => s_i_out,
         Q_OUT => s_q_out,
         EN => s_ifft_en
    );
    
    rst <= NOT PRESETn;

    -- Processes

    --------------------------------------------------------------------------
	-- Register write
    --------------------------------------------------------------------------
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
            s_data_start <= '0';
            s_meas_start <= '0';
            s_tx_fifo_in <= (others => '0');
            s_tx_fifo_wr <= '0';
            s_ptrn <= std_logic_vector(to_unsigned(g_PTRN, s_ptrn'length));
            s_mask <= std_logic_vector(to_unsigned(g_MASK, s_mask'length));
            s_gain <= std_logic_vector(to_unsigned(g_GAIN, s_gain'length));
            s_mlen <= std_logic_vector(to_unsigned(g_MLEN, s_mlen'length));
		elsif rising_edge(PCLK) then
			-- Default values
            s_data_start <= '0';
            s_meas_start <= '0';
            s_tx_fifo_wr <= '0';
			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate transmission
                        s_data_start <= PWDATA(1);
                        s_meas_start <= PWDATA(0);
					when c_ADDR_FIFO =>
                        s_tx_fifo_in <= PWDATA(31 downto 0);
                        s_tx_fifo_wr <= '1';
					when c_ADDR_PTRN =>
                        s_ptrn <= PWDATA(31 downto 0);
					when c_ADDR_MASK =>
                        s_mask <= PWDATA(31 downto 0);
					when c_ADDR_GAIN =>
                        s_gain <= PWDATA(3 downto 0);
					when c_ADDR_MLEN =>
                        s_mlen <= PWDATA(15 downto 0);
                        s_dlen <= PWDATA(31 downto 16);
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;

    --------------------------------------------------------------------------
	-- Register read
    --------------------------------------------------------------------------
	p_REG_READ : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_dout <= (others => '0');
		elsif rising_edge(PCLK) then

			-- Default output
			s_dout <= (others => '0');

			-- Register reads
			if PWRITE = '0' and PSEL = '1' then
				case PADDR(7 downto 0) is
                    -- Status
					when c_ADDR_CTRL => 
						--s_dout(0) <= s_tx_en;
					when c_ADDR_PTRN =>
						s_dout(31 downto 0) <= s_ptrn;
					when c_ADDR_MASK =>
						s_dout(31 downto 0) <= s_mask;
					when c_ADDR_GAIN =>
						s_dout(3 downto 0) <= s_gain;
					when c_ADDR_MLEN =>
						s_dout(31 downto 16) <= s_dlen;
						s_dout(15 downto 0) <= s_mlen;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

	-----------------------------------------------------------------------------
	-- High-level FSM coordinating the transmission (synchronous)
	-----------------------------------------------------------------------------
	p_TRANSMIT_FSM_SYNC : process (rst, clk)
	begin
		if rst = '1' then
            s_tx_fsm_state <= st_IDLE;
            s_ptrn_buf <= (others => '0');
            s_mask_buf <= (others => '0');
            s_tx_ctr <= (others => '0');
            s_dhold_ctr <= (others => '0');
            s_sym_start <= '0';
		elsif rising_edge(clk) then
            s_tx_fsm_state <= s_tx_fsm_state_next;
            s_ptrn_buf <= s_ptrn_buf_next;
            s_mask_buf <= s_mask_buf_next;
            s_tx_ctr <= s_tx_ctr_next;
            s_dhold_ctr <= s_dhold_ctr_next;
            s_sym_start <= s_sym_start_next;
		end if;
	end process p_TRANSMIT_FSM_SYNC;

	-----------------------------------------------------------------------------
	-- High-level FSM coordinating the transmission (combinational)
	-----------------------------------------------------------------------------
	p_TRANSMIT_FSM_COMB : process (
		s_tx_fsm_state,
		s_data_start,
		s_meas_start,
        s_ptrn_buf,
        s_mask_buf,
        s_ifft_en,
        s_ptrn,
        s_mask,
        s_mlen,
        s_sym_done,
        s_tx_fifo_out,
        s_tx_fifo_aempty,
        s_tx_ctr,
        s_dhold_ctr
	)
	begin
		-- Default values
        s_tx_fsm_state_next <= s_tx_fsm_state;
        s_sym_start_next <= '0';

        s_tx_fifo_rd <= '0';
        s_tx_done <= '0';

        s_ptrn_buf_next <= s_ptrn_buf;
        s_mask_buf_next <= s_mask_buf;

        s_tx_ctr_next <= s_tx_ctr;
        s_dhold_ctr_next <= s_dhold_ctr;

		case (s_tx_fsm_state) is
			
				when st_IDLE =>
					if s_data_start = '1' and s_tx_fifo_aempty = '0' then
                        -- DATA branch
                        s_tx_fifo_rd <= '1'; -- Fetch FIFO data
                        s_tx_ctr_next <= unsigned(s_mlen);
                        s_dhold_ctr_next <= unsigned(s_dlen);
                        s_ptrn_buf_next <= s_ptrn;
                        s_mask_buf_next <= s_mask;
						s_tx_fsm_state_next <= st_PREA;
                    elsif s_meas_start = '1' then
                        -- MEAS branch
                        s_sym_start_next <= '1';
                        s_tx_ctr_next <= unsigned(s_mlen);
                        s_ptrn_buf_next <= s_ptrn;
                        s_mask_buf_next <= s_mask;
						s_tx_fsm_state_next <= st_MEAS;
					end if;

				when st_PREA =>
                    -- Used as DATA FETCH for now
                    s_sym_start_next <= '1';
                    s_tx_fifo_rd <= '1';
                    s_ptrn_buf_next <= s_ptrn;
                    s_mask_buf_next <= s_tx_fifo_out;
                    s_tx_fsm_state_next <= st_PYLD;

				when st_PYLD =>
                    if s_sym_done = '1' then
                        -- NOTE: FIFO is read regardless if it being empty
                        s_dhold_ctr_next <= s_dhold_ctr - 1;
                        if s_dhold_ctr = 0 then
                            s_dhold_ctr_next <= unsigned(s_dlen);
                            s_tx_ctr_next <= s_tx_ctr - 1;
                            if s_tx_ctr = 1 then
                                s_tx_fsm_state_next <= st_WAIT;
                            else
                                s_sym_start_next <= '1';
                                s_tx_fifo_rd <= '1';
                                s_mask_buf_next <= s_tx_fifo_out;
                            end if;
                        else
                            s_sym_start_next <= '1';
                        end if;
                    end if;

				when st_MEAS => 
                    if s_sym_done = '1' then
                        s_tx_ctr_next <= s_tx_ctr - 1;
                        if s_tx_ctr = 1 then
                            s_tx_fsm_state_next <= st_WAIT;
                        else
                            s_sym_start_next <= '1';
                        end if;
                    end if;

				when st_WAIT => 
                    if s_ifft_en = '0' then
                        s_tx_fsm_state_next <= st_IDLE;
                        s_tx_done <= '1';
                    end if;
			
				when others =>
                    null;
			
			end case ;	

	end process p_TRANSMIT_FSM_COMB;

    --------------------------------------------------------------------------
    -- Process multiplexing the IFFT block output based on s_gain
    --------------------------------------------------------------------------
    p_IFFT_GAIN : process (rst, clk)
    begin
        if rst = '1' then
            s_tx_i_out <= (others => '0');
            s_tx_q_out <= (others => '0');
        elsif rising_edge(clk) then
            s_tx_i_out <= (others => '0');
            s_tx_q_out <= (others => '0');

            if s_vld = '1' then

                case s_gain is

                    -- x8
                    when x"3" =>
                        s_tx_i_out <= s_i_out(c_FFT_OUT_WL-4 downto c_FFT_OUT_WL-TX_I'length-3);
                        s_tx_q_out <= s_q_out(c_FFT_OUT_WL-4 downto c_FFT_OUT_WL-TX_Q'length-3);

                    -- x4
                    when x"2" =>
                        s_tx_i_out <= s_i_out(c_FFT_OUT_WL-3 downto c_FFT_OUT_WL-TX_I'length-2);
                        s_tx_q_out <= s_q_out(c_FFT_OUT_WL-3 downto c_FFT_OUT_WL-TX_Q'length-2);

                    -- x2
                    when x"1" =>
                        s_tx_i_out <= s_i_out(c_FFT_OUT_WL-2 downto c_FFT_OUT_WL-TX_I'length-1);
                        s_tx_q_out <= s_q_out(c_FFT_OUT_WL-2 downto c_FFT_OUT_WL-TX_Q'length-1);

                    -- x1
                    when others =>
                        s_tx_i_out <= s_i_out(c_FFT_OUT_WL-1 downto c_FFT_OUT_WL-TX_I'length);
                        s_tx_q_out <= s_q_out(c_FFT_OUT_WL-1 downto c_FFT_OUT_WL-TX_Q'length);

                end case;
            end if;

        end if;
    end process p_IFFT_GAIN;


    -- Output assignment

	PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

    TX_EN <= s_vld;
    TX_I <= s_tx_i_out;
    TX_Q <= s_tx_q_out;

    TX_DONE_IRQ <= s_tx_done;

end Behavioral;
