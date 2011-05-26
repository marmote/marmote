-------------------------------------------------------------------------------
-- (c) Copyright 2005 Actel Corporation
--
-- name:		tb_user_corespi.vhd
-- function:	User Testbench for CoreSPI, instantiates 2 cores, one operating
--				in master mode, the other in slave mode
-- comments:	best viewed with tabstops set to "4"
-- history:		8/01/03  - TFB created
--
-- Rev:			2.1 24Jan05 TFB - Production
--
-------------------------------------------------------------------------------
-- Description:
--    The testbench, instantiates two SPI cores. The first is programmed
--    as a master and the second is programmed as a slave.
--    The SPI busses of the two cores are connected together to establish
--    communication between the two cores.
--    The testbench, checks the communication for all CPOL, CPHA combinations,
--    for a single transmission rate. To check for other transmission rates,
--    set the value of the generic CLOCK_SEL to a different value - the various
--    supported values of CLOCK_SEL are shown below:
--         CLOCK_SEL      SCK frequency         CLOCK_SEL      SCK frequency
--           "000"         SysClk / 2             "100"         SysClk / 32
--           "001"         SysClk / 4             "101"         SysClk / 64
--           "010"         SysClk / 8             "110"         SysClk / 128
--           "011"         SysClk / 16            "111"         SysClk / 256
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library CoreSPI_lib;
use CoreSPI_lib.CoreSPI_pkg.all;

entity tb_vhdl is

-- constants ...
generic (
-- Choose clock select frequency (see comments in header above)
CLOCK_SEL		:integer := 1;
-- number of bytes to tx/rx between master/slave
TXRX_BYTES		:integer := 16;
-- set this to 1 to transmit lsb first, 0 to transmit msb first
TX_LSB_FIRST	:integer := 0;
-- System Clock cycle (in ns)
SYS_CLK_CYCLE	:integer := 30
);

end tb_vhdl ;

architecture behv of tb_vhdl is


-- component declarations

component CORESPI
generic (
-- master+slave	: set USE_MASTER=1, USE_SLAVE=1 (default)
-- master only	: set USE_MASTER=1, USE_SLAVE=0
-- slave only	: set USE_MASTER=0, USE_SLAVE=1
FAMILY                  : integer := 17;
USE_MASTER		: integer := 1;
USE_SLAVE		: integer := 1
);
port (
PCLK			:	in	std_logic;	-- Global clock
PRESETN			:	in	std_logic;	-- Act.low asynchronous reset
-- SPI interface signals
m_sck			:	out	std_logic;	-- SPI master generated Serial Clock
m_miso			:	in	std_logic;	-- SPI serial data (master in/slave out)
m_mosi			:	out	std_logic;	-- SPI serial data (master out/slave in)
-- SPI master generated slave select lines
m_ss			:	out	std_logic_vector(7 downto 0);
s_sck			:	in	std_logic;	-- SPI slave, Serial Clock input
s_miso			:	out	std_logic;	-- SPI serial data (master in/slave out)
s_mosi			:	in	std_logic;	-- SPI serial data (master out/slave in)
s_ss			:	in	std_logic;	-- SPI slave, act.low slave select input
enable_master	        :	out	std_logic;	-- CoreSPI operating in master mode
enable_slave	        :	out	std_logic;	-- CoreSPI operating in slave mode
-- generic microcontroller interface signals
PWDATA			:	in	std_logic_vector(7 downto 0);	-- APB read data
PRDATA	        	:	out	std_logic_vector(7 downto 0);	-- APB write data
PADDR			:	in	std_logic_vector(3 downto 0);	-- APB Address
PENABLE			:	in	std_logic;	-- APB Enable
PSEL			:	in	std_logic;	-- APB Select
PWRITE			:	in	std_logic;	-- APB Write enable
interrupt		:	out	std_logic;	-- Masked interrupt output
-- Unmasked interrupt outputs
tx_reg_empty	        :	out	std_logic;	-- transmit register empty
rx_data_ready	        :	out	std_logic	-- data received and ready to be read
);
end component;

-- apb_write and apb_read procedures, as defined in CoreSPI package
--procedure apb_write	(
--	constant	addr:	in		bit_vector(1 downto 0);
--	constant	d:		in		bit_vector(7 downto 0);
--	signal		clk:	in		std_logic;
--	signal		a:		out		std_logic_vector (1 downto 0);
--	signal		do:		out		std_logic_vector (7 downto 0);
--	signal		wr:		out		std_logic;
--	signal		rd:		out		std_logic
--) is
--begin
--	a		<= to_stdlogicvector(addr(1 downto 0));
--	wr		<= '1';
--	rd		<= '0';
--	do		<= to_stdlogicvector(d);
--	wait until clk = '1';
--	wait until clk = '0';
--	a		<= (others => '0');
--	wr 		<= '0';
--	do		<= (others => '0');
--end apb_write;
--
--procedure apb_read	(
--	constant	addr:		in		bit_vector(1 downto 0);
--	constant	d:			in		bit_vector(7 downto 0);
--	signal		clk:		in		std_logic;
--	signal		a:			out		std_logic_vector (1 downto 0);
--	signal		di:			in		std_logic_vector (7 downto 0);
--	signal		wr:			out		std_logic;
--	signal		rd:			out		std_logic;
--				simerrors:	inout	integer
--) is
--	variable	dvar:				std_logic_vector(7 downto 0);
--begin
--	a		<= to_stdlogicvector(addr(1 downto 0));
--	wr		<= '0';
--	rd		<= '1';
--	wait until clk = '1';
--	wait until clk = '0';
--	dvar	:= di;
--	checksig(dvar,"CPU Data Bus",d,simerrors);
--	a		<= (others => '0');
--	rd 		<= '0';
--end apb_read;


-- SIGNAL Declarations
signal GND_sig				:std_logic;
signal pclk           	:std_logic;
signal presetn           	:std_logic;
signal cpol             	:std_logic;
signal cpha             	:std_logic;
signal m_sck				:std_logic;
signal m_miso				:std_logic;
signal m_mosi				:std_logic;
signal m_ss					:std_logic_vector(7 downto 0);
signal s_sck				:std_logic;
signal s_miso				:std_logic;
signal s_mosi				:std_logic;
signal s_ss					:std_logic;
signal enable_master1		:std_logic;
signal enable_master2		:std_logic;
signal enable_slave1		:std_logic;
signal enable_slave2		:std_logic;


signal pwdata1				:std_logic_vector(7 downto 0);
signal pwdata2				:std_logic_vector(7 downto 0);
signal prdata1			        :std_logic_vector(7 downto 0);
signal prdata2			        :std_logic_vector(7 downto 0);
signal paddr1				:std_logic_vector(1 downto 0);
signal paddr2				:std_logic_vector(1 downto 0);
signal paddr14				:std_logic_vector(3 downto 0);
signal paddr24				:std_logic_vector(3 downto 0);
signal penable1				:std_logic;
signal penable2				:std_logic;
signal psel1				:std_logic;
signal psel2				:std_logic;
signal pwrite1				:std_logic;
signal pwrite2				:std_logic;

--signal we1					:std_logic;
--signal we2					:std_logic;
--signal re1					:std_logic;
--signal re2					:std_logic;


signal interrupt1			:std_logic;
signal interrupt2			:std_logic;
signal tx_reg_empty1		:std_logic;
signal tx_reg_empty2		:std_logic;
signal rx_data_ready1		:std_logic;
signal rx_data_ready2		:std_logic;

signal clocksel				:std_logic_vector(2 downto 0);
signal lsb_first			:std_logic;
signal stopsim				:boolean;
-- timeout in case something catastrophic happens
constant TIMEOUT			:natural := 8191;

-- string related signals
constant dash_str			:string(1 to 77)	:=
"-----------------------------------------------------------------------------";
constant uline_str			:string(1 to 77)	:=
"_____________________________________________________________________________";
constant pound_str			:string(1 to 77)	:=
"#############################################################################";
constant space77_str		:string(1 to 77)	:=
"                                                                             ";
constant copyright_str		:string(1 to 77)	:=
"(c) Copyright 2005 Actel Corporation. All rights reserved.                   ";
constant tb_name_str		:string(1 to 77)	:=
"User Testbench for: CoreSPI                                                  ";
constant tb_ver_str			:string(1 to 77)	:=
"Version: 2.1 24Jan05                                                         ";
constant lsb_str			:string(1 to 3)		:= "LSB";
constant msb_str			:string(1 to 3)		:= "MSB";

type	STR_ARRAY1 is array (integer range 0 to 11) of string (1 to 77);

-- initialization of testbench string
constant	init_str_mem:	STR_ARRAY1	:= (
space77_str,space77_str,uline_str,space77_str,copyright_str,space77_str,
tb_name_str,tb_ver_str,uline_str,space77_str,space77_str,space77_str
);

---------------------------------------------------------------------
-- Run simulation for given number of clock cycles
-- (procedure description here in architecture to use SYS_CLK_CYCLE generic)
---------------------------------------------------------------------
procedure cyc	(
	constant	c:			in	integer range 0 to 65536) is
begin
	cloop: for i in 1 to c loop
		wait for SYS_CLK_CYCLE * 1 ns ;
	end loop cloop;
end cyc;

---------------------------------------------------------------------


begin
	GND_sig	<= '0';

	-- generate the system clock
	pclk_proc: process
	begin
		if (stopsim) then
			wait;	-- end simulation
		else
			pclk <= '0';
			wait for ((SYS_CLK_CYCLE * 1 ns)/2);
			pclk <= '1';
			wait for ((SYS_CLK_CYCLE * 1 ns)/2);
		end if;
	end process;

	---------------------------------------------------------------------

	paddr14 <= paddr1 & "00";
	paddr24 <= paddr2 & "00";
	
	-- instantiating CORESPI 1, (Master only)
	corespi_master: CORESPI generic map(USE_MASTER=>1,USE_SLAVE=>0)
	port map(
		pclk=>pclk,presetn=>presetn,m_sck=>m_sck,
		m_miso=>m_miso,m_mosi=>m_mosi,m_ss=>m_ss,s_sck=>GND_sig,
		s_miso=>open,s_mosi=>GND_sig,s_ss=>GND_sig,
		enable_master=>enable_master1,enable_slave=>enable_slave1,
		interrupt=>interrupt1,
                PADDR=>paddr14,PSEL=>psel1,PENABLE=>penable1,PWRITE=>pwrite1,PWDATA=>pwdata1,PRDATA=>prdata1,
		tx_reg_empty=>tx_reg_empty1,rx_data_ready=>rx_data_ready1
	);
	s_sck	<= m_sck;
	s_mosi	<= m_mosi;
	s_ss	<= m_ss(1);

	---------------------------------------------------------------------

	-- instantiating CORESPI 2, (Slave only)
	corespi_slave: CORESPI generic map(USE_MASTER=>0,USE_SLAVE=>1)
	port map(
		pclk=>pclk,presetn=>presetn,m_sck=>open,
		m_miso=>GND_sig,m_mosi=>open,m_ss=>open,s_sck=>s_sck,
		s_miso=>s_miso,s_mosi=>s_mosi,s_ss=>s_ss,
		enable_master=>enable_master2,enable_slave=>enable_slave2,
		interrupt=>interrupt2,
                PADDR=> paddr24,PSEL=>psel2,PENABLE=>penable2,PWRITE=>pwrite2,PWDATA=>pwdata2,PRDATA=>prdata2,
		tx_reg_empty=>tx_reg_empty2,rx_data_ready=>rx_data_ready2
	);
	m_miso	<= s_miso;

	---------------------------------------------------------------------


-- Primary stimuli
primary_proc: process
variable simerrors	:natural range 0 to 2047;
variable divnum		:natural range 0 to 511;
variable dtmp		:bit_vector (7 downto 0);
variable dtmp_mx	:bit_vector (7 downto 0);
variable dtmp2		:std_logic_vector (7 downto 0);
variable lmsb_str	:string(1 to 3);
begin
	stopsim		<= false;
	simerrors	:= 0;

	-- print out copyright info, testbench version, name of testbench, etc.
	for i in 0 to 11 loop
		printf("%s",fmt(init_str_mem(i)));
	end loop;

	clocksel	<= int2slv(CLOCK_SEL,3);
	divnum		:= 2 ** (CLOCK_SEL+1);
	cpol		<= '0';
	cpha		<= '0';
	if (TX_LSB_FIRST=1) then
		lsb_first		<= '1';
		lmsb_str		:= "LSB";
	else
		lsb_first		<= '0';
		lmsb_str		:= "MSB";
	end if;

	-- loop 4 times for different values of cpol and cpha
	for j in 0 to 3 loop
		-- initialize signals
		presetn			<= '0';
		pwdata1		<= (others=>'0');
		pwdata2		<= (others=>'0');
		paddr1		<= (others=>'0');
		paddr2		<= (others=>'0');
                penable1        <= '0';
                penable2        <= '0';
                pwrite1         <= '0';
                pwrite2         <= '0';
                psel1           <= '0';
                psel2           <= '0';
--		we1				<= '0';
--		we2				<= '0';
--		re1				<= '0';
--		re2				<= '0';

		dtmp2			:= int2slv(j,8);
		-- synch to falling edge of clock
		wait until pclk = '1';
		wait until pclk = '0';
		cyc(2);
		checksig(m_mosi,"m_mosi",'0',simerrors);
		checksig(m_ss,"m_ss",x"ff",simerrors);
		checksig(s_miso,"s_miso",'0',simerrors);
		checksig(enable_master1,"enable_master1",'0',simerrors);
		checksig(enable_master2,"enable_master2",'0',simerrors);
		checksig(enable_slave1,"enable_slave1",'0',simerrors);
		checksig(enable_slave2,"enable_slave2",'0',simerrors);
		checksig(prdata1,"data_out1",x"00",simerrors);
		checksig(prdata2,"data_out2",x"00",simerrors);
		checksig(interrupt1,"interrupt1",'0',simerrors);
		checksig(interrupt2,"interrupt2",'0',simerrors);
		checksig(tx_reg_empty1,"tx_reg_empty1",'0',simerrors);
		checksig(tx_reg_empty2,"tx_reg_empty2",'0',simerrors);
		checksig(rx_data_ready1,"rx_data_ready1",'0',simerrors);
		checksig(rx_data_ready2,"rx_data_ready2",'0',simerrors);
		-- Disable SPI, Clear errors
		cyc(1);
		cpha			<= dtmp2(1);
		cpol			<= dtmp2(0);
		cyc(1);
		printf("%s",fmt(dash_str));
		printf("Testing CoreSPI Tx/Rx (%d bytes) with:%s first,CPHA=%d,CPOL=%d",
		fmt(TXRX_BYTES)&fmt(lmsb_str)&fmt(cpha)&fmt(cpol));
		printf("Clock selector set to: %d (source clock divided by %d)",
		fmt(CLOCK_SEL)&fmt(divnum));
		printf("%s",fmt(dash_str));
		cyc(4);
		presetn			<= '1';
		cyc(2);
		-- read the various registers to verify reset values
		apb_read("00",x"00",pclk,paddr1,prdata1,pwrite1,penable1,psel1,simerrors);
		apb_read("00",x"00",pclk,paddr2,prdata2,pwrite2,penable2,psel2,simerrors);
		apb_read("01",x"00",pclk,paddr1,prdata1,pwrite1,penable1,psel1,simerrors);
		apb_read("01",x"00",pclk,paddr2,prdata2,pwrite2,penable2,psel2,simerrors);
		apb_read("10",x"00",pclk,paddr1,prdata1,pwrite1,penable1,psel1,simerrors);
		apb_read("10",x"00",pclk,paddr2,prdata2,pwrite2,penable2,psel2,simerrors);
		apb_read("11",x"00",pclk,paddr1,prdata1,pwrite1,penable1,psel1,simerrors);
		apb_read("11",x"00",pclk,paddr2,prdata2,pwrite2,penable2,psel2,simerrors);
		-- setup CoreSPI master (enable interrupt pin, master mode,
		-- lsb/msb first,
		-- cpha(0: 0 degree, no delay; 1: 90 degree delay),
		-- cpol(0: act.high clock, 1: act.low clock),
		-- clock rate selection
		dtmp:= "11" & to_bit(lsb_first) & to_bit(cpha) & to_bit(cpol) &
				to_bitvector(clocksel);
		cyc(1);
		apb_write("01",dtmp,pclk,paddr1,pwdata1,pwrite1,penable1,psel1);
		-- do a readback to verify written values
		apb_read("01",dtmp,pclk,paddr1,prdata1,pwrite1,penable1,psel1,simerrors);
		-- setup CoreSPI slave (enable interrupt pin, slave mode,
		-- lsb/msb first,
		-- cpha(0: 0 degree, no delay; 1: 90 degree delay),
		-- cpol(0: act.high clock, 1: act.low clock),
		-- clock rate selection
		dtmp:= "10" & to_bit(lsb_first) & to_bit(cpha) & to_bit(cpol) &
				to_bitvector(clocksel);
		cyc(1);
		apb_write("01",dtmp,pclk,paddr2,pwdata2,pwrite2,penable2,psel2);
		-- do a readback to verify written values
		apb_read("01",dtmp,pclk,paddr2,prdata2,pwrite2,penable2,psel2,simerrors);
		-- Enable SPI, Clear errors
		apb_write("10",x"81",pclk,paddr1,pwdata1,pwrite1,penable1,psel1);
		apb_write("10",x"81",pclk,paddr2,pwdata2,pwrite2,penable2,psel2);
		cyc(1);
		-- enable_master1 should be high, enable_slave1 should be low,
		-- enable_master2 should be low, enable_slave2 should be high,
		checksig(enable_master1,"enable_master1",'1',simerrors);
		checksig(enable_slave1,"enable_slave1",'0',simerrors);
		checksig(enable_master2,"enable_master2",'0',simerrors);
		checksig(enable_slave2,"enable_slave2",'1',simerrors);
		-- CoreSPI master selects to communicate with slave on select line 1
		apb_write("11",x"02",pclk,paddr1,pwdata1,pwrite1,penable1,psel1);
		-- send bytes from master to slave (have slave send complement)
		for i in 0 to TXRX_BYTES-1 loop
			dtmp	:= to_bitvector(int2slv(i,8));
			cyc(1);
			if lsb_first='1' then
				dtmp_mx	:= not(dtmp(0) & dtmp(1) & dtmp(2) & dtmp(3) &
							dtmp(4) & dtmp(5) & dtmp(6) & dtmp(7));
			else
				dtmp_mx	:= not(dtmp);
			end if;
			cyc(1);
			-- Write data to be transmitted from CoreSPI master to CoreSPI slave
			apb_write("00",dtmp,pclk,paddr1,pwdata1,pwrite1,penable1,psel1);
			-- Write complement for CoreSPI slave to reply
			--(flip around if lsb first for CoreSPI slave tx to CoresSPI master)
			apb_write("00",dtmp_mx,pclk,paddr2,pwdata2,pwrite2,penable2,psel2);
			-- read master status reg (SPI enabled, "000", master mode busy
			-- transmitting, tx reg not empty, rx data not ready, no error)
			apb_read("10",x"88",pclk,paddr1,prdata1,pwrite1,penable1,psel1,simerrors);
			-- Wait for CoreSPI master to receive data
			-- (put in timeout in case rx_data_ready1 never happens ...)
			tloop1: for t in 0 to TIMEOUT loop
				cyc(1);
				if rx_data_ready1='1' then
					-- read master status reg (SPI enabled,"000",
					-- master mode not busy transmitting, tx reg empty,
					-- rx data ready, no error)
					apb_read("10",x"86",pclk,paddr1,prdata1,pwrite1,penable1,psel1,
					simerrors);
					-- rx data available, so read it
					apb_read("00",not(dtmp),pclk,paddr1,prdata1,pwrite1,penable1,psel1,
					simerrors);
					exit tloop1;
				end if;
				if t=TIMEOUT then
					printf("*** Timed out waiting for rx_data_ready1.");
					simerrors := simerrors + 1;
				end if;
			end loop tloop1;
			-- Wait for CoreSPI slave to receive data
			-- (put in timeout in case rx_data_ready2 never happens ...)
			tloop2: for t in 0 to TIMEOUT loop
				cyc(1);
				if rx_data_ready2='1' then
					-- read slave status reg (SPI enabled,"000",
					-- master mode not busy transmitting, tx reg empty,
					-- rx data ready, no error)
					apb_read("10",x"86",pclk,paddr2,prdata2,pwrite2,penable2,psel2,
					simerrors);
					-- rx data available, so read it
					apb_read("00",not(dtmp_mx),pclk,paddr2,prdata2,pwrite2,penable2,psel2,
					simerrors);
					exit tloop2;
				end if;
				if t=TIMEOUT then
					printf("*** Timed out waiting for rx_data_ready2.");
					simerrors := simerrors + 1;
				end if;
			end loop tloop2;
			cyc(1);
		end loop;
	end loop;

	-- print out number of simulation errors (if any) at end of sim
	printf(" ");
	printf("%s",fmt(pound_str));
	printf("All Tests complete.");
	printf("%s",fmt(pound_str));
	printf(" ");
	printf("%s",fmt(uline_str));
	printf(" ");
	printf("Number of simulation mis-match errors encountered: %0d",
	fmt(simerrors));
	printf(" ");
	printf("Done with simulation.");
	printf("%s",fmt(uline_str));
	printf(" ");
	printf(" ");
	cyc(1);
	stopsim	<= true;
	wait;

end process primary_proc;


end behv;
