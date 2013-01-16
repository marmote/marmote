add wave  \
-unsigned \
-group {APB} \
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


add wave \
-group {FIFO CONTROL} \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/rst \
sim:/testbench/Teton_0/TX_APB_IF_0/clk \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_empty \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_wr \
-hex sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_in \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_rd \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_out \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_full \
sim:/testbench/Teton_0/TX_APB_IF_0/s_start \
sim:/testbench/Teton_0/TX_APB_IF_0/s_start_prev \
sim:/testbench/Teton_0/TX_APB_IF_0/s_data_buffer_next \
sim:/testbench/Teton_0/TX_APB_IF_0/s_data_buffer



add wave \
-unsigned \
-group {DATA BITS} \
sim:/testbench/Teton_0/TX_APB_IF_0/rst \
sim:/testbench/Teton_0/TX_APB_IF_0/s_start \
sim:/testbench/Teton_0/TX_APB_IF_0/s_symbol_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_symbol_end \
sim:/testbench/Teton_0/TX_APB_IF_0/s_data_buffer \
sim:/testbench/Teton_0/TX_APB_IF_0/s_status \
sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr \
-signed \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd_en \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mod_en

add wave \
-group {WAVEFORMS} \
-analog-step -min -16384 -max 16384 -height 50 \
-label {Gaussian FIR in} sim:/testbench/Teton_0/TX_APB_IF_0/u_GMSK_MOD_LUT/Gaussian_Filter_FIR_block/myGaussian_Filter_FIR/inp \
-analog-step -min -16384 -max 16384 -height 50 \
-label {Gaussian FIR out} sim:/testbench/Teton_0/TX_APB_IF_0/u_GMSK_MOD_LUT/Gaussian_Filter_FIR_block/myGaussian_Filter_FIR/outp \
-analog-step -min -4294967296 -max 4294967296 -height 50 \
-label {Integrator out} \
sim:/testbench/Teton_0/TX_APB_IF_0/u_GMSK_MOD_LUT/N_5 \
-analog-step -min -512 -max 512 -height 100 \
-label {TX I} sim:/testbench/Teton_0/TX_APB_IF_0/TX_I \
-label {TX Q} sim:/testbench/Teton_0/TX_APB_IF_0/TX_Q \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_STROBE 


add wave \
-group {OTHER} \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/s_busy \
-signed \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd_next \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/s_dout \
sim:/testbench/Teton_0/TX_APB_IF_0/c_DATA_LENGTH \
sim:/testbench/Teton_0/TX_APB_IF_0/c_SYMBOL_DIV

run 120 us
wave zoom range {80 us} {130 us}
