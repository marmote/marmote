-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity CIC is

    port( CLK      : in    std_logic;
          RST      : in    std_logic;
          SMPL_RDY : out   std_logic;
          INPUT    : in    std_logic_vector(22 downto 0);
          OUTPUT   : out   std_logic_vector(26 downto 0)
        );

end CIC;

architecture DEF_ARCH of CIC is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CIC_COMB_mem
    port( WD    : in    std_logic_vector(35 downto 0) := (others => 'U');
          RD    : out   std_logic_vector(35 downto 0);
          WEN   : in    std_logic := 'U';
          REN   : in    std_logic := 'U';
          WADDR : in    std_logic_vector(1 downto 0) := (others => 'U');
          RADDR : in    std_logic_vector(1 downto 0) := (others => 'U');
          RWCLK : in    std_logic := 'U';
          RESET : in    std_logic := 'U'
        );
  end component;

    signal \CIC_COMB_control_0_RADDR_0_[1]\, 
        \CIC_COMB_control_0_RADDR_0_[0]\, CIC_COMB_control_0_REN, 
        \CIC_COMB_control_0_WADDR_0_[1]\, 
        \CIC_COMB_control_0_WADDR_0_[0]\, 
        \CIC_COMB_control_0_WD_[35]\, 
        \CIC_COMB_control_0_WD_[34]\, 
        \CIC_COMB_control_0_WD_[33]\, 
        \CIC_COMB_control_0_WD_[32]\, 
        \CIC_COMB_control_0_WD_[31]\, 
        \CIC_COMB_control_0_WD_[30]\, 
        \CIC_COMB_control_0_WD_[29]\, 
        \CIC_COMB_control_0_WD_[28]\, 
        \CIC_COMB_control_0_WD_[27]\, 
        \CIC_COMB_control_0_WD_[26]\, 
        \CIC_COMB_control_0_WD_[25]\, 
        \CIC_COMB_control_0_WD_[24]\, 
        \CIC_COMB_control_0_WD_[23]\, 
        \CIC_COMB_control_0_WD_[22]\, 
        \CIC_COMB_control_0_WD_[21]\, 
        \CIC_COMB_control_0_WD_[20]\, 
        \CIC_COMB_control_0_WD_[19]\, 
        \CIC_COMB_control_0_WD_[18]\, 
        \CIC_COMB_control_0_WD_[17]\, 
        \CIC_COMB_control_0_WD_[16]\, 
        \CIC_COMB_control_0_WD_[15]\, 
        \CIC_COMB_control_0_WD_[14]\, 
        \CIC_COMB_control_0_WD_[13]\, 
        \CIC_COMB_control_0_WD_[12]\, 
        \CIC_COMB_control_0_WD_[11]\, 
        \CIC_COMB_control_0_WD_[10]\, \CIC_COMB_control_0_WD_[9]\, 
        \CIC_COMB_control_0_WD_[8]\, \CIC_COMB_control_0_WD_[7]\, 
        \CIC_COMB_control_0_WD_[6]\, \CIC_COMB_control_0_WD_[5]\, 
        \CIC_COMB_control_0_WD_[4]\, \CIC_COMB_control_0_WD_[3]\, 
        \CIC_COMB_control_0_WD_[2]\, \CIC_COMB_control_0_WD_[1]\, 
        \CIC_COMB_control_0_WD_[0]\, CIC_COMB_control_0_WEN, 
        \CIC_COMB_mem_0_RD_[35]\, \CIC_COMB_mem_0_RD_[34]\, 
        \CIC_COMB_mem_0_RD_[33]\, \CIC_COMB_mem_0_RD_[32]\, 
        \CIC_COMB_mem_0_RD_[31]\, \CIC_COMB_mem_0_RD_[30]\, 
        \CIC_COMB_mem_0_RD_[29]\, \CIC_COMB_mem_0_RD_[28]\, 
        \CIC_COMB_mem_0_RD_[27]\, \CIC_COMB_mem_0_RD_[26]\, 
        \CIC_COMB_mem_0_RD_[25]\, \CIC_COMB_mem_0_RD_[24]\, 
        \CIC_COMB_mem_0_RD_[23]\, \CIC_COMB_mem_0_RD_[22]\, 
        \CIC_COMB_mem_0_RD_[21]\, \CIC_COMB_mem_0_RD_[20]\, 
        \CIC_COMB_mem_0_RD_[19]\, \CIC_COMB_mem_0_RD_[18]\, 
        \CIC_COMB_mem_0_RD_[17]\, \CIC_COMB_mem_0_RD_[16]\, 
        \CIC_COMB_mem_0_RD_[15]\, \CIC_COMB_mem_0_RD_[14]\, 
        \CIC_COMB_mem_0_RD_[13]\, \CIC_COMB_mem_0_RD_[12]\, 
        \CIC_COMB_mem_0_RD_[11]\, \CIC_COMB_mem_0_RD_[10]\, 
        \CIC_COMB_mem_0_RD_[9]\, \CIC_COMB_mem_0_RD_[8]\, 
        \CIC_COMB_mem_0_RD_[7]\, \CIC_COMB_mem_0_RD_[6]\, 
        \CIC_COMB_mem_0_RD_[5]\, \CIC_COMB_mem_0_RD_[4]\, 
        \CIC_COMB_mem_0_RD_[3]\, \CIC_COMB_mem_0_RD_[2]\, 
        \CIC_COMB_mem_0_RD_[1]\, \CIC_COMB_mem_0_RD_[0]\, 
        \CIC_control_0_clk_counter_out_[5]\, 
        \CIC_control_0_clk_counter_out_[4]\, 
        \CIC_control_0_clk_counter_out_[3]\, 
        \CIC_control_0_clk_counter_out_[2]\, 
        \CIC_control_0_clk_counter_out_[1]\, 
        \CIC_control_0_dec_counter_out_0_[2]\, 
        \CIC_control_0_dec_counter_out_0_[1]\, 
        \CIC_INT_0_OUTPUT_1_[26]\, \CIC_INT_0_OUTPUT_1_[25]\, 
        \CIC_INT_0_OUTPUT_1_[24]\, \CIC_INT_0_OUTPUT_1_[23]\, 
        \CIC_INT_0_OUTPUT_1_[22]\, \CIC_INT_0_OUTPUT_1_[21]\, 
        \CIC_INT_0_OUTPUT_1_[20]\, \CIC_INT_0_OUTPUT_1_[19]\, 
        \CIC_INT_0_OUTPUT_1_[18]\, \CIC_INT_0_OUTPUT_1_[17]\, 
        \CIC_INT_0_OUTPUT_1_[16]\, \CIC_INT_0_OUTPUT_1_[15]\, 
        \CIC_INT_0_OUTPUT_1_[14]\, \CIC_INT_0_OUTPUT_1_[13]\, 
        \CIC_INT_0_OUTPUT_1_[12]\, \CIC_INT_0_OUTPUT_1_[11]\, 
        \CIC_INT_0_OUTPUT_1_[10]\, \CIC_INT_0_OUTPUT_1_[9]\, 
        \CIC_INT_0_OUTPUT_1_[8]\, \CIC_INT_0_OUTPUT_1_[7]\, 
        \CIC_INT_0_OUTPUT_1_[6]\, \CIC_INT_0_OUTPUT_1_[5]\, 
        \CIC_INT_0_OUTPUT_1_[4]\, \CIC_INT_0_OUTPUT_1_[3]\, 
        \CIC_INT_0_OUTPUT_1_[2]\, \CIC_INT_0_OUTPUT_1_[1]\, 
        \CIC_INT_0_OUTPUT_1_[0]\, GND_net, VCC_net : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    CIC_control_0 : entity work.CIC_control
      port map(CLK => CLK, RST => RST, clk_counter_out(5) => 
        \CIC_control_0_clk_counter_out_[5]\, clk_counter_out(4)
         => \CIC_control_0_clk_counter_out_[4]\, 
        clk_counter_out(3) => \CIC_control_0_clk_counter_out_[3]\, 
        clk_counter_out(2) => \CIC_control_0_clk_counter_out_[2]\, 
        clk_counter_out(1) => \CIC_control_0_clk_counter_out_[1]\, 
        dec_counter_out(2) => 
        \CIC_control_0_dec_counter_out_0_[2]\, dec_counter_out(1)
         => \CIC_control_0_dec_counter_out_0_[1]\);
    
    CIC_COMB_control_0 : entity work.CIC_COMB_control
      port map(CLK => CLK, RST => RST, clk_counter(5) => 
        \CIC_control_0_clk_counter_out_[5]\, clk_counter(4) => 
        \CIC_control_0_clk_counter_out_[4]\, clk_counter(3) => 
        \CIC_control_0_clk_counter_out_[3]\, clk_counter(2) => 
        \CIC_control_0_clk_counter_out_[2]\, clk_counter(1) => 
        \CIC_control_0_clk_counter_out_[1]\, dec_counter(2) => 
        \CIC_control_0_dec_counter_out_0_[2]\, dec_counter(1) => 
        \CIC_control_0_dec_counter_out_0_[1]\, WD(35) => 
        \CIC_COMB_control_0_WD_[35]\, WD(34) => 
        \CIC_COMB_control_0_WD_[34]\, WD(33) => 
        \CIC_COMB_control_0_WD_[33]\, WD(32) => 
        \CIC_COMB_control_0_WD_[32]\, WD(31) => 
        \CIC_COMB_control_0_WD_[31]\, WD(30) => 
        \CIC_COMB_control_0_WD_[30]\, WD(29) => 
        \CIC_COMB_control_0_WD_[29]\, WD(28) => 
        \CIC_COMB_control_0_WD_[28]\, WD(27) => 
        \CIC_COMB_control_0_WD_[27]\, WD(26) => 
        \CIC_COMB_control_0_WD_[26]\, WD(25) => 
        \CIC_COMB_control_0_WD_[25]\, WD(24) => 
        \CIC_COMB_control_0_WD_[24]\, WD(23) => 
        \CIC_COMB_control_0_WD_[23]\, WD(22) => 
        \CIC_COMB_control_0_WD_[22]\, WD(21) => 
        \CIC_COMB_control_0_WD_[21]\, WD(20) => 
        \CIC_COMB_control_0_WD_[20]\, WD(19) => 
        \CIC_COMB_control_0_WD_[19]\, WD(18) => 
        \CIC_COMB_control_0_WD_[18]\, WD(17) => 
        \CIC_COMB_control_0_WD_[17]\, WD(16) => 
        \CIC_COMB_control_0_WD_[16]\, WD(15) => 
        \CIC_COMB_control_0_WD_[15]\, WD(14) => 
        \CIC_COMB_control_0_WD_[14]\, WD(13) => 
        \CIC_COMB_control_0_WD_[13]\, WD(12) => 
        \CIC_COMB_control_0_WD_[12]\, WD(11) => 
        \CIC_COMB_control_0_WD_[11]\, WD(10) => 
        \CIC_COMB_control_0_WD_[10]\, WD(9) => 
        \CIC_COMB_control_0_WD_[9]\, WD(8) => 
        \CIC_COMB_control_0_WD_[8]\, WD(7) => 
        \CIC_COMB_control_0_WD_[7]\, WD(6) => 
        \CIC_COMB_control_0_WD_[6]\, WD(5) => 
        \CIC_COMB_control_0_WD_[5]\, WD(4) => 
        \CIC_COMB_control_0_WD_[4]\, WD(3) => 
        \CIC_COMB_control_0_WD_[3]\, WD(2) => 
        \CIC_COMB_control_0_WD_[2]\, WD(1) => 
        \CIC_COMB_control_0_WD_[1]\, WD(0) => 
        \CIC_COMB_control_0_WD_[0]\, WADDR(1) => 
        \CIC_COMB_control_0_WADDR_0_[1]\, WADDR(0) => 
        \CIC_COMB_control_0_WADDR_0_[0]\, RADDR(1) => 
        \CIC_COMB_control_0_RADDR_0_[1]\, RADDR(0) => 
        \CIC_COMB_control_0_RADDR_0_[0]\, WEN => 
        CIC_COMB_control_0_WEN, REN => CIC_COMB_control_0_REN, 
        RD(35) => \CIC_COMB_mem_0_RD_[35]\, RD(34) => 
        \CIC_COMB_mem_0_RD_[34]\, RD(33) => 
        \CIC_COMB_mem_0_RD_[33]\, RD(32) => 
        \CIC_COMB_mem_0_RD_[32]\, RD(31) => 
        \CIC_COMB_mem_0_RD_[31]\, RD(30) => 
        \CIC_COMB_mem_0_RD_[30]\, RD(29) => 
        \CIC_COMB_mem_0_RD_[29]\, RD(28) => 
        \CIC_COMB_mem_0_RD_[28]\, RD(27) => 
        \CIC_COMB_mem_0_RD_[27]\, RD(26) => 
        \CIC_COMB_mem_0_RD_[26]\, RD(25) => 
        \CIC_COMB_mem_0_RD_[25]\, RD(24) => 
        \CIC_COMB_mem_0_RD_[24]\, RD(23) => 
        \CIC_COMB_mem_0_RD_[23]\, RD(22) => 
        \CIC_COMB_mem_0_RD_[22]\, RD(21) => 
        \CIC_COMB_mem_0_RD_[21]\, RD(20) => 
        \CIC_COMB_mem_0_RD_[20]\, RD(19) => 
        \CIC_COMB_mem_0_RD_[19]\, RD(18) => 
        \CIC_COMB_mem_0_RD_[18]\, RD(17) => 
        \CIC_COMB_mem_0_RD_[17]\, RD(16) => 
        \CIC_COMB_mem_0_RD_[16]\, RD(15) => 
        \CIC_COMB_mem_0_RD_[15]\, RD(14) => 
        \CIC_COMB_mem_0_RD_[14]\, RD(13) => 
        \CIC_COMB_mem_0_RD_[13]\, RD(12) => 
        \CIC_COMB_mem_0_RD_[12]\, RD(11) => 
        \CIC_COMB_mem_0_RD_[11]\, RD(10) => 
        \CIC_COMB_mem_0_RD_[10]\, RD(9) => 
        \CIC_COMB_mem_0_RD_[9]\, RD(8) => \CIC_COMB_mem_0_RD_[8]\, 
        RD(7) => \CIC_COMB_mem_0_RD_[7]\, RD(6) => 
        \CIC_COMB_mem_0_RD_[6]\, RD(5) => \CIC_COMB_mem_0_RD_[5]\, 
        RD(4) => \CIC_COMB_mem_0_RD_[4]\, RD(3) => 
        \CIC_COMB_mem_0_RD_[3]\, RD(2) => \CIC_COMB_mem_0_RD_[2]\, 
        RD(1) => \CIC_COMB_mem_0_RD_[1]\, RD(0) => 
        \CIC_COMB_mem_0_RD_[0]\, INPUT(26) => 
        \CIC_INT_0_OUTPUT_1_[26]\, INPUT(25) => 
        \CIC_INT_0_OUTPUT_1_[25]\, INPUT(24) => 
        \CIC_INT_0_OUTPUT_1_[24]\, INPUT(23) => 
        \CIC_INT_0_OUTPUT_1_[23]\, INPUT(22) => 
        \CIC_INT_0_OUTPUT_1_[22]\, INPUT(21) => 
        \CIC_INT_0_OUTPUT_1_[21]\, INPUT(20) => 
        \CIC_INT_0_OUTPUT_1_[20]\, INPUT(19) => 
        \CIC_INT_0_OUTPUT_1_[19]\, INPUT(18) => 
        \CIC_INT_0_OUTPUT_1_[18]\, INPUT(17) => 
        \CIC_INT_0_OUTPUT_1_[17]\, INPUT(16) => 
        \CIC_INT_0_OUTPUT_1_[16]\, INPUT(15) => 
        \CIC_INT_0_OUTPUT_1_[15]\, INPUT(14) => 
        \CIC_INT_0_OUTPUT_1_[14]\, INPUT(13) => 
        \CIC_INT_0_OUTPUT_1_[13]\, INPUT(12) => 
        \CIC_INT_0_OUTPUT_1_[12]\, INPUT(11) => 
        \CIC_INT_0_OUTPUT_1_[11]\, INPUT(10) => 
        \CIC_INT_0_OUTPUT_1_[10]\, INPUT(9) => 
        \CIC_INT_0_OUTPUT_1_[9]\, INPUT(8) => 
        \CIC_INT_0_OUTPUT_1_[8]\, INPUT(7) => 
        \CIC_INT_0_OUTPUT_1_[7]\, INPUT(6) => 
        \CIC_INT_0_OUTPUT_1_[6]\, INPUT(5) => 
        \CIC_INT_0_OUTPUT_1_[5]\, INPUT(4) => 
        \CIC_INT_0_OUTPUT_1_[4]\, INPUT(3) => 
        \CIC_INT_0_OUTPUT_1_[3]\, INPUT(2) => 
        \CIC_INT_0_OUTPUT_1_[2]\, INPUT(1) => 
        \CIC_INT_0_OUTPUT_1_[1]\, INPUT(0) => 
        \CIC_INT_0_OUTPUT_1_[0]\, OUTPUT(26) => OUTPUT(26), 
        OUTPUT(25) => OUTPUT(25), OUTPUT(24) => OUTPUT(24), 
        OUTPUT(23) => OUTPUT(23), OUTPUT(22) => OUTPUT(22), 
        OUTPUT(21) => OUTPUT(21), OUTPUT(20) => OUTPUT(20), 
        OUTPUT(19) => OUTPUT(19), OUTPUT(18) => OUTPUT(18), 
        OUTPUT(17) => OUTPUT(17), OUTPUT(16) => OUTPUT(16), 
        OUTPUT(15) => OUTPUT(15), OUTPUT(14) => OUTPUT(14), 
        OUTPUT(13) => OUTPUT(13), OUTPUT(12) => OUTPUT(12), 
        OUTPUT(11) => OUTPUT(11), OUTPUT(10) => OUTPUT(10), 
        OUTPUT(9) => OUTPUT(9), OUTPUT(8) => OUTPUT(8), OUTPUT(7)
         => OUTPUT(7), OUTPUT(6) => OUTPUT(6), OUTPUT(5) => 
        OUTPUT(5), OUTPUT(4) => OUTPUT(4), OUTPUT(3) => OUTPUT(3), 
        OUTPUT(2) => OUTPUT(2), OUTPUT(1) => OUTPUT(1), OUTPUT(0)
         => OUTPUT(0), SMPL_RDY => SMPL_RDY);
    
    CIC_INT_0 : entity work.CIC_INT
      port map(CLK => CLK, RST => RST, clk_counter(5) => 
        \CIC_control_0_clk_counter_out_[5]\, clk_counter(4) => 
        \CIC_control_0_clk_counter_out_[4]\, clk_counter(3) => 
        \CIC_control_0_clk_counter_out_[3]\, clk_counter(2) => 
        \CIC_control_0_clk_counter_out_[2]\, clk_counter(1) => 
        \CIC_control_0_clk_counter_out_[1]\, INPUT(22) => 
        INPUT(22), INPUT(21) => INPUT(21), INPUT(20) => INPUT(20), 
        INPUT(19) => INPUT(19), INPUT(18) => INPUT(18), INPUT(17)
         => INPUT(17), INPUT(16) => INPUT(16), INPUT(15) => 
        INPUT(15), INPUT(14) => INPUT(14), INPUT(13) => INPUT(13), 
        INPUT(12) => INPUT(12), INPUT(11) => INPUT(11), INPUT(10)
         => INPUT(10), INPUT(9) => INPUT(9), INPUT(8) => INPUT(8), 
        INPUT(7) => INPUT(7), INPUT(6) => INPUT(6), INPUT(5) => 
        INPUT(5), INPUT(4) => INPUT(4), INPUT(3) => INPUT(3), 
        INPUT(2) => INPUT(2), INPUT(1) => INPUT(1), INPUT(0) => 
        INPUT(0), OUTPUT(26) => \CIC_INT_0_OUTPUT_1_[26]\, 
        OUTPUT(25) => \CIC_INT_0_OUTPUT_1_[25]\, OUTPUT(24) => 
        \CIC_INT_0_OUTPUT_1_[24]\, OUTPUT(23) => 
        \CIC_INT_0_OUTPUT_1_[23]\, OUTPUT(22) => 
        \CIC_INT_0_OUTPUT_1_[22]\, OUTPUT(21) => 
        \CIC_INT_0_OUTPUT_1_[21]\, OUTPUT(20) => 
        \CIC_INT_0_OUTPUT_1_[20]\, OUTPUT(19) => 
        \CIC_INT_0_OUTPUT_1_[19]\, OUTPUT(18) => 
        \CIC_INT_0_OUTPUT_1_[18]\, OUTPUT(17) => 
        \CIC_INT_0_OUTPUT_1_[17]\, OUTPUT(16) => 
        \CIC_INT_0_OUTPUT_1_[16]\, OUTPUT(15) => 
        \CIC_INT_0_OUTPUT_1_[15]\, OUTPUT(14) => 
        \CIC_INT_0_OUTPUT_1_[14]\, OUTPUT(13) => 
        \CIC_INT_0_OUTPUT_1_[13]\, OUTPUT(12) => 
        \CIC_INT_0_OUTPUT_1_[12]\, OUTPUT(11) => 
        \CIC_INT_0_OUTPUT_1_[11]\, OUTPUT(10) => 
        \CIC_INT_0_OUTPUT_1_[10]\, OUTPUT(9) => 
        \CIC_INT_0_OUTPUT_1_[9]\, OUTPUT(8) => 
        \CIC_INT_0_OUTPUT_1_[8]\, OUTPUT(7) => 
        \CIC_INT_0_OUTPUT_1_[7]\, OUTPUT(6) => 
        \CIC_INT_0_OUTPUT_1_[6]\, OUTPUT(5) => 
        \CIC_INT_0_OUTPUT_1_[5]\, OUTPUT(4) => 
        \CIC_INT_0_OUTPUT_1_[4]\, OUTPUT(3) => 
        \CIC_INT_0_OUTPUT_1_[3]\, OUTPUT(2) => 
        \CIC_INT_0_OUTPUT_1_[2]\, OUTPUT(1) => 
        \CIC_INT_0_OUTPUT_1_[1]\, OUTPUT(0) => 
        \CIC_INT_0_OUTPUT_1_[0]\);
    
    CIC_COMB_mem_0 : CIC_COMB_mem
      port map(WD(35) => \CIC_COMB_control_0_WD_[35]\, WD(34) => 
        \CIC_COMB_control_0_WD_[34]\, WD(33) => 
        \CIC_COMB_control_0_WD_[33]\, WD(32) => 
        \CIC_COMB_control_0_WD_[32]\, WD(31) => 
        \CIC_COMB_control_0_WD_[31]\, WD(30) => 
        \CIC_COMB_control_0_WD_[30]\, WD(29) => 
        \CIC_COMB_control_0_WD_[29]\, WD(28) => 
        \CIC_COMB_control_0_WD_[28]\, WD(27) => 
        \CIC_COMB_control_0_WD_[27]\, WD(26) => 
        \CIC_COMB_control_0_WD_[26]\, WD(25) => 
        \CIC_COMB_control_0_WD_[25]\, WD(24) => 
        \CIC_COMB_control_0_WD_[24]\, WD(23) => 
        \CIC_COMB_control_0_WD_[23]\, WD(22) => 
        \CIC_COMB_control_0_WD_[22]\, WD(21) => 
        \CIC_COMB_control_0_WD_[21]\, WD(20) => 
        \CIC_COMB_control_0_WD_[20]\, WD(19) => 
        \CIC_COMB_control_0_WD_[19]\, WD(18) => 
        \CIC_COMB_control_0_WD_[18]\, WD(17) => 
        \CIC_COMB_control_0_WD_[17]\, WD(16) => 
        \CIC_COMB_control_0_WD_[16]\, WD(15) => 
        \CIC_COMB_control_0_WD_[15]\, WD(14) => 
        \CIC_COMB_control_0_WD_[14]\, WD(13) => 
        \CIC_COMB_control_0_WD_[13]\, WD(12) => 
        \CIC_COMB_control_0_WD_[12]\, WD(11) => 
        \CIC_COMB_control_0_WD_[11]\, WD(10) => 
        \CIC_COMB_control_0_WD_[10]\, WD(9) => 
        \CIC_COMB_control_0_WD_[9]\, WD(8) => 
        \CIC_COMB_control_0_WD_[8]\, WD(7) => 
        \CIC_COMB_control_0_WD_[7]\, WD(6) => 
        \CIC_COMB_control_0_WD_[6]\, WD(5) => 
        \CIC_COMB_control_0_WD_[5]\, WD(4) => 
        \CIC_COMB_control_0_WD_[4]\, WD(3) => 
        \CIC_COMB_control_0_WD_[3]\, WD(2) => 
        \CIC_COMB_control_0_WD_[2]\, WD(1) => 
        \CIC_COMB_control_0_WD_[1]\, WD(0) => 
        \CIC_COMB_control_0_WD_[0]\, RD(35) => 
        \CIC_COMB_mem_0_RD_[35]\, RD(34) => 
        \CIC_COMB_mem_0_RD_[34]\, RD(33) => 
        \CIC_COMB_mem_0_RD_[33]\, RD(32) => 
        \CIC_COMB_mem_0_RD_[32]\, RD(31) => 
        \CIC_COMB_mem_0_RD_[31]\, RD(30) => 
        \CIC_COMB_mem_0_RD_[30]\, RD(29) => 
        \CIC_COMB_mem_0_RD_[29]\, RD(28) => 
        \CIC_COMB_mem_0_RD_[28]\, RD(27) => 
        \CIC_COMB_mem_0_RD_[27]\, RD(26) => 
        \CIC_COMB_mem_0_RD_[26]\, RD(25) => 
        \CIC_COMB_mem_0_RD_[25]\, RD(24) => 
        \CIC_COMB_mem_0_RD_[24]\, RD(23) => 
        \CIC_COMB_mem_0_RD_[23]\, RD(22) => 
        \CIC_COMB_mem_0_RD_[22]\, RD(21) => 
        \CIC_COMB_mem_0_RD_[21]\, RD(20) => 
        \CIC_COMB_mem_0_RD_[20]\, RD(19) => 
        \CIC_COMB_mem_0_RD_[19]\, RD(18) => 
        \CIC_COMB_mem_0_RD_[18]\, RD(17) => 
        \CIC_COMB_mem_0_RD_[17]\, RD(16) => 
        \CIC_COMB_mem_0_RD_[16]\, RD(15) => 
        \CIC_COMB_mem_0_RD_[15]\, RD(14) => 
        \CIC_COMB_mem_0_RD_[14]\, RD(13) => 
        \CIC_COMB_mem_0_RD_[13]\, RD(12) => 
        \CIC_COMB_mem_0_RD_[12]\, RD(11) => 
        \CIC_COMB_mem_0_RD_[11]\, RD(10) => 
        \CIC_COMB_mem_0_RD_[10]\, RD(9) => 
        \CIC_COMB_mem_0_RD_[9]\, RD(8) => \CIC_COMB_mem_0_RD_[8]\, 
        RD(7) => \CIC_COMB_mem_0_RD_[7]\, RD(6) => 
        \CIC_COMB_mem_0_RD_[6]\, RD(5) => \CIC_COMB_mem_0_RD_[5]\, 
        RD(4) => \CIC_COMB_mem_0_RD_[4]\, RD(3) => 
        \CIC_COMB_mem_0_RD_[3]\, RD(2) => \CIC_COMB_mem_0_RD_[2]\, 
        RD(1) => \CIC_COMB_mem_0_RD_[1]\, RD(0) => 
        \CIC_COMB_mem_0_RD_[0]\, WEN => CIC_COMB_control_0_WEN, 
        REN => CIC_COMB_control_0_REN, WADDR(1) => 
        \CIC_COMB_control_0_WADDR_0_[1]\, WADDR(0) => 
        \CIC_COMB_control_0_WADDR_0_[0]\, RADDR(1) => 
        \CIC_COMB_control_0_RADDR_0_[1]\, RADDR(0) => 
        \CIC_COMB_control_0_RADDR_0_[0]\, RWCLK => CLK, RESET => 
        RST);
    

end DEF_ARCH; 
