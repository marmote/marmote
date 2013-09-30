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
sim:/testbench/Teton_0/TX_APB_IF_0/s_ptrn_buf \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mask_buf \
sim:/testbench/Teton_0/TX_APB_IF_0/s_cp_add \
sim:/testbench/Teton_0/TX_APB_IF_0/s_symb_start \
sim:/testbench/Teton_0/TX_APB_IF_0/s_symb_done \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_done


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
-divider {TX OFDM} \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/clk \
sim:/testbench/Teton_0/TX_APB_IF_0/rst \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_start(0) \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_gain \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_mask \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_symb \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_cp_len \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/RST \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/clk \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/SYMB_START \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/SYMB_DONE \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/SYMB \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/MASK \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/GAIN \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/CP_ADD \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/CP_LEN \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_ifft_rst \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_ifft_en \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/IFFT_timing_controller_block/myIFFT_timing_controller/s_hold_off_ifft_en \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/IFFT_timing_controller_block/myIFFT_timing_controller/s_ifft_en \
-signed -analog-step -min -8 -max 8 -height 30 \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/IFFT_timing_controller_block/myIFFT_timing_controller/s_cp_len_reg \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_ifft_i_in \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_ifft_q_in \
-hex -literal -height 17 \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_symb_start_d \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_symb_done \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_ifft_rdy \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_ifft_vld \
-signed -analog-step -min -128 -max 128 -height 100 \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_ifft_i_out \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_ifft_q_out \
-hex -literal -height 17 \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_cp_start \
-signed -analog-step -min -128 -max 128 -height 100 \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_cp_i_in \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_cp_q_in \
-hex -literal -height 17 \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_tx_strobe(0) \
-signed -analog-step -min -128 -max 128 -height 100 \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_cp_i_out \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/s_cp_q_out \
-hex -literal -height 17 \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/TX_STROBE \
sim:/testbench/Teton_0/TX_APB_IF_0/u_OFDM/TX_DONE



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
#run 400 us

wave zoom full
