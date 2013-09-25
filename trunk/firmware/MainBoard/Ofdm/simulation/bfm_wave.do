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


add wave  \
-divider {TX FSM} \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/clk \
sim:/testbench/Teton_0/TX_APB_IF_0/rst \
sim:/testbench/Teton_0/TX_APB_IF_0/s_ptrn \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mask \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mlen \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fsm_state \
sim:/testbench/Teton_0/TX_APB_IF_0/s_data_start \
sim:/testbench/Teton_0/TX_APB_IF_0/s_meas_start \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_dhold_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_ptrn_buf \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mask_buf \
sim:/testbench/Teton_0/TX_APB_IF_0/s_sym_start \
sim:/testbench/Teton_0/TX_APB_IF_0/s_sym_done \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_done

add wave  \
-divider {IFFT CTRL} \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/RST \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/CLK \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/SYM \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/MASK \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/SYM_START \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/s_sym \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/s_mask \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/SYM_DONE \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/s_state \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/s_tx_en \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/s_delay_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/s_sym_done \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/s_ifft_en \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/IFFT_RST \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/IFFT_EN \
-analog-step -min -8 -max 8 -height 100 \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/s_ifft_i \
sim:/testbench/Teton_0/TX_APB_IF_0/u_IFFT_CTRL/s_ifft_q


add wave \
-group {TX FIFO} \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_full \
sim:/testbench/Teton_0/TX_APB_IF_0/u_TX_FIFO/AFULL \
sim:/testbench/Teton_0/TX_APB_IF_0/u_TX_FIFO/s_we_n \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_wr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_in \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_empty \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_aempty \
sim:/testbench/Teton_0/TX_APB_IF_0/u_TX_FIFO/s_re_n \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_rd \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_out


add wave \
-group {TX IFFT} \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/clk \
sim:/testbench/Teton_0/TX_APB_IF_0/rst \
sim:/testbench/Teton_0/TX_APB_IF_0/s_gain \
sim:/testbench/Teton_0/TX_APB_IF_0/s_ptrn \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mask \
sim:/testbench/Teton_0/TX_APB_IF_0/s_state \
sim:/testbench/Teton_0/TX_APB_IF_0/s_ifft_rst \
sim:/testbench/Teton_0/TX_APB_IF_0/s_ifft_en \
-signed \
-analog-step -min -8 -max 8 -height 100 \
sim:/testbench/Teton_0/TX_APB_IF_0/s_i_in \
sim:/testbench/Teton_0/TX_APB_IF_0/s_q_in
add wave \
sim:/testbench/Teton_0/TX_APB_IF_0/s_vld \
sim:/testbench/Teton_0/TX_APB_IF_0/s_rdy \
-analog-step -min -8192 -max 8192 -height 100 \
sim:/testbench/Teton_0/TX_APB_IF_0/s_i_out \
sim:/testbench/Teton_0/TX_APB_IF_0/s_q_out



add wave  \
-group {AFE} \
sim:/testbench/Teton_0/AFE1_IF/TX_STROBE \
-signed \
sim:/testbench/Teton_0/AFE1_IF/CLK \
sim:/testbench/Teton_0/AFE1_IF/RST \
sim:/testbench/Teton_0/AFE1_IF/SHDN \
sim:/testbench/Teton_0/AFE1_IF/TX_STROBE \
-analog-step -min -512 -max 512 -height 100 \
sim:/testbench/Teton_0/AFE1_IF/TX_I \
sim:/testbench/Teton_0/AFE1_IF/TX_Q



#run -all
run 130 us
run 400 us

wave zoom full
