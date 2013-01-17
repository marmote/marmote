library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity FIFO_512x8 is
    generic (
        g_AFULL     : integer := 496;
        g_AEMPTY    : integer := 16
    );
    port(
        DATA   : in    std_logic_vector(7 downto 0);
        Q      : out   std_logic_vector(7 downto 0);
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
end FIFO_512x8;

architecture Structural of FIFO_512x8 is 

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

    signal WENP, RESETP : std_logic;

    constant c_AFULL    : std_logic_vector(8 downto 0) :=
        std_logic_vector(to_unsigned(g_AFULL, 9));
    constant c_AEMPTY   : std_logic_vector(8 downto 0) :=
        std_logic_vector(to_unsigned(g_AEMPTY, 9));
    

begin 

      WENP <= not WE;
      RESETP <= not RESET;

      -- Port maps
    
      u_FIFO4K18 : FIFO4K18
      port map(
          AEVAL11 => c_AEMPTY(8),
          AEVAL10 => c_AEMPTY(7),
          AEVAL9 => c_AEMPTY(6),
          AEVAL8 => c_AEMPTY(5),
          AEVAL7 => c_AEMPTY(4),
          AEVAL6 => c_AEMPTY(3),
          AEVAL5 => c_AEMPTY(2),
          AEVAL4 => c_AEMPTY(1),
          AEVAL3 => c_AEMPTY(0),
          AEVAL2 => '0',
          AEVAL1 => '0',
          AEVAL0 => '0',
          AFVAL11 => c_AFULL(8),
          AFVAL10 => c_AFULL(7),
          AFVAL9 => c_AFULL(6),
          AFVAL8 => c_AFULL(5),
          AFVAL7 => c_AFULL(4),
          AFVAL6 => c_AFULL(3),
          AFVAL5 => c_AFULL(2),
          AFVAL4 => c_AFULL(1),
          AFVAL3 => c_AFULL(0),
          AFVAL2 => '0',
          AFVAL1 => '0',
          AFVAL0 => '0',
          WD17 => '0',
          WD16 => '0', 
          WD15 => '0',
          WD14 => '0',
          WD13 => '0',
          WD12 => '0',
          WD11 => '0',
          WD10 => '0',
          WD9 => '0',
          WD8 => '0',
          WD7 => DATA(7),
          WD6 => DATA(6),
          WD5 => DATA(5), 
          WD4 => DATA(4),
          WD3 => DATA(3),
          WD2 => DATA(2),
          WD1 => DATA(1),
          WD0 => DATA(0),
          WW0 => '1',
          WW1 => '1',
          WW2 => '0',
          RW0 => '1',
          RW1 => '1',
          RW2 => '0',
          RPIPE => '0',
          WEN => WENP,
          REN => RE,
          WBLK => '0',
          RBLK => '0',
          WCLK => WCLOCK,
          RCLK => RCLOCK,
          RESET => RESETP,
          ESTOP => '1',
          FSTOP => '1',
          RD17 => OPEN, 
          RD16 => OPEN,
          RD15 => OPEN,
          RD14 => OPEN,
          RD13 => OPEN, 
          RD12 => OPEN,
          RD11 => OPEN,
          RD10 => OPEN,
          RD9 => OPEN, 
          RD8 => OPEN,
          RD7 => Q(7),
          RD6 => Q(6),
          RD5 => Q(5),
          RD4 => Q(4),
          RD3 => Q(3),
          RD2 => Q(2),
          RD1 => Q(1),
          RD0 => Q(0),
          FULL => FULL,
          AFULL => AFULL,
          EMPTY => EMPTY,
          AEMPTY => AEMPTY
      );
    

end Structural; 
