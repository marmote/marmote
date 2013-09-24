-- FIFO_256x32.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 11.1 SP2
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
-- Description: 256 x 32 bit FIFO
--
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity FIFO_256x32 is
    generic (
        g_AFULL     : integer := 192;
        g_AEMPTY    : integer := 128
    );
    port(
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
end FIFO_256x32;

architecture Structural of FIFO_256x32 is 

  component FIFO4K18
    port( AEVAL11 : in    std_logic := 'U';
          AEVAL10 : in    std_logic := 'U';
          AEVAL9  : in    std_logic := 'U';
          AEVAL8  : in    std_logic := 'U';
          AEVAL7  : in    std_logic := 'U';
          AEVAL6  : in    std_logic := 'U';
          AEVAL5  : in    std_logic := 'U';
          AEVAL4  : in    std_logic := 'U';
          AEVAL3  : in    std_logic := 'U';
          AEVAL2  : in    std_logic := 'U';
          AEVAL1  : in    std_logic := 'U';
          AEVAL0  : in    std_logic := 'U';
          AFVAL11 : in    std_logic := 'U';
          AFVAL10 : in    std_logic := 'U';
          AFVAL9  : in    std_logic := 'U';
          AFVAL8  : in    std_logic := 'U';
          AFVAL7  : in    std_logic := 'U';
          AFVAL6  : in    std_logic := 'U';
          AFVAL5  : in    std_logic := 'U';
          AFVAL4  : in    std_logic := 'U';
          AFVAL3  : in    std_logic := 'U';
          AFVAL2  : in    std_logic := 'U';
          AFVAL1  : in    std_logic := 'U';
          AFVAL0  : in    std_logic := 'U';
          WD17    : in    std_logic := 'U';
          WD16    : in    std_logic := 'U';
          WD15    : in    std_logic := 'U';
          WD14    : in    std_logic := 'U';
          WD13    : in    std_logic := 'U';
          WD12    : in    std_logic := 'U';
          WD11    : in    std_logic := 'U';
          WD10    : in    std_logic := 'U';
          WD9     : in    std_logic := 'U';
          WD8     : in    std_logic := 'U';
          WD7     : in    std_logic := 'U';
          WD6     : in    std_logic := 'U';
          WD5     : in    std_logic := 'U';
          WD4     : in    std_logic := 'U';
          WD3     : in    std_logic := 'U';
          WD2     : in    std_logic := 'U';
          WD1     : in    std_logic := 'U';
          WD0     : in    std_logic := 'U';
          WW0     : in    std_logic := 'U';
          WW1     : in    std_logic := 'U';
          WW2     : in    std_logic := 'U';
          RW0     : in    std_logic := 'U';
          RW1     : in    std_logic := 'U';
          RW2     : in    std_logic := 'U';
          RPIPE   : in    std_logic := 'U';
          WEN     : in    std_logic := 'U';
          REN     : in    std_logic := 'U';
          WBLK    : in    std_logic := 'U';
          RBLK    : in    std_logic := 'U';
          WCLK    : in    std_logic := 'U';
          RCLK    : in    std_logic := 'U';
          RESET   : in    std_logic := 'U';
          ESTOP   : in    std_logic := 'U';
          FSTOP   : in    std_logic := 'U';
          RD17    : out   std_logic;
          RD16    : out   std_logic;
          RD15    : out   std_logic;
          RD14    : out   std_logic;
          RD13    : out   std_logic;
          RD12    : out   std_logic;
          RD11    : out   std_logic;
          RD10    : out   std_logic;
          RD9     : out   std_logic;
          RD8     : out   std_logic;
          RD7     : out   std_logic;
          RD6     : out   std_logic;
          RD5     : out   std_logic;
          RD4     : out   std_logic;
          RD3     : out   std_logic;
          RD2     : out   std_logic;
          RD1     : out   std_logic;
          RD0     : out   std_logic;
          FULL    : out   std_logic;
          AFULL   : out   std_logic;
          EMPTY   : out   std_logic;
          AEMPTY  : out   std_logic
        );
  end component;


    constant c_AFULL    : std_logic_vector(7 downto 0) :=
        std_logic_vector(to_unsigned(g_AFULL, 8));
    constant c_AEMPTY   : std_logic_vector(7 downto 0) :=
        std_logic_vector(to_unsigned(g_AEMPTY, 8));

    signal s_reset_n                : std_logic;

    signal s_we_n                   : std_logic;
    signal s_full                   : std_logic;
    signal s_full_0, s_full_1       : std_logic;
    signal s_afull_0, s_afull_1     : std_logic;

    signal s_re_n                   : std_logic;
    signal s_empty                  : std_logic;
    signal s_empty_0, s_empty_1     : std_logic;
    signal s_aempty_0, s_aempty_1   : std_logic;


begin 

    s_reset_n <= not RESET;

    s_full <= s_full_0 or s_full_1;
    s_we_n <= not WE or s_full;
    FULL <= s_full;
    AFULL <= s_afull_0 or s_afull_1;

    s_empty <= s_empty_0 or s_empty_1;
    s_re_n <= RE and not s_empty;
    EMPTY <= s_empty;
    AEMPTY <= s_aempty_0 or s_aempty_1;

    -- Port maps
    
    u_FIFO4K18_0 : FIFO4K18
      port map (
        AEVAL11 => c_AEMPTY(7),
        AEVAL10 => c_AEMPTY(6),
        AEVAL9 => c_AEMPTY(5),
        AEVAL8 => c_AEMPTY(4),
        AEVAL7 => c_AEMPTY(3),
        AEVAL6 => c_AEMPTY(2),
        AEVAL5 => c_AEMPTY(1),
        AEVAL4 => c_AEMPTY(0),
        AEVAL3 => '0',
        AEVAL2 => '0',
        AEVAL1 => '0',
        AEVAL0 => '0',
        AFVAL11 => c_AFULL(7),
        AFVAL10 => c_AFULL(6),
        AFVAL9 => c_AFULL(5),
        AFVAL8 => c_AFULL(4),
        AFVAL7 => c_AFULL(3),
        AFVAL6 => c_AFULL(2),
        AFVAL5 => c_AFULL(1),
        AFVAL4 => c_AFULL(0),
        AFVAL3 => '0',
        AFVAL2 => '0',
        AFVAL1 => '0',
        AFVAL0 => '0',
        WD17 => '0',
        WD16 => '0', 
        WD15 => DIN(15),
        WD14 => DIN(14),
        WD13 => DIN(13), 
        WD12 => DIN(12),
        WD11 => DIN(11),
        WD10 => DIN(10),
        WD9 => DIN(9),
        WD8 => DIN(8),
        WD7 => DIN(7),
        WD6 => DIN(6),
        WD5 => DIN(5),
        WD4 => DIN(4),
        WD3 => DIN(3), 
        WD2 => DIN(2),
        WD1 => DIN(1),
        WD0 => DIN(0),
        WW0 => '0',
        WW1 => '0',
        WW2 => '1',
        RW0 => '0',
        RW1 => '0',
        RW2 => '1',
        RPIPE => '0',
        WEN => s_we_n,
        REN => s_re_n,
        WBLK => '0',
        RBLK => '0',
        WCLK => WCLOCK,
        RCLK => RCLOCK,
        RESET => s_reset_n,
        ESTOP => '1',
        FSTOP => '1',
        RD17 => OPEN,
        RD16 => OPEN,
        RD15 => DOUT(15),
        RD14 => DOUT(14),
        RD13 => DOUT(13),
        RD12 => DOUT(12),
        RD11 => DOUT(11), 
        RD10 => DOUT(10),
        RD9 => DOUT(9),
        RD8 => DOUT(8),
        RD7 => DOUT(7),
        RD6 => DOUT(6),
        RD5 => DOUT(5),
        RD4 => DOUT(4),
        RD3 => DOUT(3),
        RD2 => DOUT(2),
        RD1 => DOUT(1),
        RD0 => DOUT(0),
        FULL => s_full_0,
        AFULL => s_afull_0,
        EMPTY => s_empty_0,
        AEMPTY => s_aempty_0
    );

    u_FIFO4K18_1 : FIFO4K18
      port map (
        AEVAL11 => c_AEMPTY(7),
        AEVAL10 => c_AEMPTY(6),
        AEVAL9 => c_AEMPTY(5),
        AEVAL8 => c_AEMPTY(4),
        AEVAL7 => c_AEMPTY(3),
        AEVAL6 => c_AEMPTY(2),
        AEVAL5 => c_AEMPTY(1),
        AEVAL4 => c_AEMPTY(0),
        AEVAL3 => '0',
        AEVAL2 => '0',
        AEVAL1 => '0',
        AEVAL0 => '0',
        AFVAL11 => c_AFULL(7),
        AFVAL10 => c_AFULL(6),
        AFVAL9 => c_AFULL(5),
        AFVAL8 => c_AFULL(4),
        AFVAL7 => c_AFULL(3),
        AFVAL6 => c_AFULL(2),
        AFVAL5 => c_AFULL(1),
        AFVAL4 => c_AFULL(0),
        AFVAL3 => '0',
        AFVAL2 => '0',
        AFVAL1 => '0',
        AFVAL0 => '0',
        WD17 => '0',
        WD16 => '0', 
        WD15 => DIN(31),
        WD14 => DIN(30),
        WD13 => DIN(29), 
        WD12 => DIN(28),
        WD11 => DIN(27),
        WD10 => DIN(26),
        WD9 => DIN(25),
        WD8 => DIN(24),
        WD7 => DIN(23),
        WD6 => DIN(22),
        WD5 => DIN(21),
        WD4 => DIN(20),
        WD3 => DIN(19), 
        WD2 => DIN(18),
        WD1 => DIN(17),
        WD0 => DIN(16),
        WW0 => '0',
        WW1 => '0',
        WW2 => '1',
        RW0 => '0',
        RW1 => '0',
        RW2 => '1',
        RPIPE => '0',
        WEN => s_we_n,
        REN => s_re_n,
        WBLK => '0',
        RBLK => '0',
        WCLK => WCLOCK,
        RCLK => RCLOCK,
        RESET => s_reset_n,
        ESTOP => '1',
        FSTOP => '1',
        RD17 => OPEN,
        RD16 => OPEN,
        RD15 => DOUT(31),
        RD14 => DOUT(30),
        RD13 => DOUT(29),
        RD12 => DOUT(28),
        RD11 => DOUT(27), 
        RD10 => DOUT(26),
        RD9 => DOUT(25),
        RD8 => DOUT(24),
        RD7 => DOUT(23),
        RD6 => DOUT(22),
        RD5 => DOUT(21),
        RD4 => DOUT(20),
        RD3 => DOUT(19),
        RD2 => DOUT(18),
        RD1 => DOUT(17),
        RD0 => DOUT(16),
        FULL => s_full_1,
        AFULL => s_afull_1,
        EMPTY => s_empty_1,
        AEMPTY => s_aempty_1
    );
end Structural; 

