add wave  \
-group {APB} \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/PCLK \
sim:/testbench/Teton_0/TX_APB_IF_0/PRESETn \
sim:/testbench/Teton_0/TX_APB_IF_0/PADDR \
sim:/testbench/Teton_0/TX_APB_IF_0/PSEL \
sim:/testbench/Teton_0/TX_APB_IF_0/PENABLE \
sim:/testbench/Teton_0/TX_APB_IF_0/PWRITE \
sim:/testbench/Teton_0/TX_APB_IF_0/PWDATA \
sim:/testbench/Teton_0/TX_APB_IF_0/PREADY \
sim:/testbench/Teton_0/TX_APB_IF_0/PRDATA \
sim:/testbench/Teton_0/TX_APB_IF_0/PSLVERR


#add wave \
#-bin sim:/tx_apb_if_tb/uut/g_PTRN \
#-bin sim:/tx_apb_if_tb/uut/g_MASK
#sim:/tx_apb_if_tb/uut/c_ADDR_CTRL \
#sim:/tx_apb_if_tb/uut/c_ADDR_TEST \
#sim:/tx_apb_if_tb/uut/c_ADDR_PTRN \
#sim:/tx_apb_if_tb/uut/c_ADDR_MASK


add wave \
-divider {TX IF} \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/clk \
sim:/testbench/Teton_0/TX_APB_IF_0/rst \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_en \
sim:/testbench/Teton_0/TX_APB_IF_0/s_test \
sim:/testbench/Teton_0/TX_APB_IF_0/s_ptrn \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mask \
sim:/testbench/Teton_0/TX_APB_IF_0/s_state \
sim:/testbench/Teton_0/TX_APB_IF_0/s_ifft_rst \
sim:/testbench/Teton_0/TX_APB_IF_0/s_ifft_en \
sim:/testbench/Teton_0/TX_APB_IF_0/s_vld \
sim:/testbench/Teton_0/TX_APB_IF_0/s_rdy \
-signed \
-analog-step -min -32768 -max 32768 -height 100 \
sim:/testbench/Teton_0/TX_APB_IF_0/s_i_in \
sim:/testbench/Teton_0/TX_APB_IF_0/s_q_in


add wave  \
-divider {AFE} \
sim:/testbench/Teton_0/AFE1_IF/TX_STROBE \
-signed \
-analog-step -min -512 -max 512 -height 100 \
sim:/testbench/Teton_0/AFE1_IF/TX_I \
sim:/testbench/Teton_0/AFE1_IF/TX_Q

run -all

wave zoom full
