add wave  \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/PCLK \
sim:/testbench/Teton_0/TX_APB_IF_0/PRESETn \
sim:/testbench/Teton_0/TX_APB_IF_0/PADDR \
sim:/testbench/Teton_0/TX_APB_IF_0/PSEL \
sim:/testbench/Teton_0/TX_APB_IF_0/PENABLE \
sim:/testbench/Teton_0/TX_APB_IF_0/PWRITE \
sim:/testbench/Teton_0/TX_APB_IF_0/PWDATA \
sim:/testbench/Teton_0/TX_APB_IF_0/PREADY \
sim:/testbench/Teton_0/TX_APB_IF_0/PRDATA \
sim:/testbench/Teton_0/TX_APB_IF_0/PSLVERR \
sim:/testbench/Teton_0/TX_APB_IF_0/rst \
sim:/testbench/Teton_0/TX_APB_IF_0/s_start \
sim:/testbench/Teton_0/TX_APB_IF_0/s_symbol_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_symbol_end \
sim:/testbench/Teton_0/TX_APB_IF_0/s_data_buffer \
sim:/testbench/Teton_0/TX_APB_IF_0/s_data \
sim:/testbench/Teton_0/TX_APB_IF_0/s_status \
sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd_en \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_STROBE 
add wave \
-analog-step -min -512 -max 512 -height 100 \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_I \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_Q
add wave \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/s_busy \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd_next \
sim:/testbench/Teton_0/TX_APB_IF_0/s_dout \
sim:/testbench/Teton_0/TX_APB_IF_0/c_DATA_LENGTH \
sim:/testbench/Teton_0/TX_APB_IF_0/c_SYMBOL_DIV

run 200 us
wave zoom range {80 us} {130 us}
