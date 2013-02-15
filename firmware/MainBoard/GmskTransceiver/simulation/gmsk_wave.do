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
sim:/testbench/Teton_0/TX_APB_IF_0/s_start

#sim:/testbench/Teton_0/TX_APB_IF_0/s_buffer_next \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_buffer



add wave \
-unsigned \
-group {TX FSM} \
sim:/testbench/Teton_0/TX_APB_IF_0/rst \
sim:/testbench/Teton_0/TX_APB_IF_0/s_start \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_state \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_state_next \
sim:/testbench/Teton_0/TX_APB_IF_0/s_oct_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_oct_ctr_next \
sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr_next \
sim:/testbench/Teton_0/TX_APB_IF_0/s_payload_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_payload_ctr_next \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_rd \
-hex sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_out \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_full \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_empty \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_aempty \
sim:/testbench/Teton_0/TX_APB_IF_0/s_buffer \
sim:/testbench/Teton_0/TX_APB_IF_0/s_buffer_next \
-unsigned sim:/testbench/Teton_0/TX_APB_IF_0/s_baud_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_symbol_end \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/s_status \
sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr \
-signed \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd(15) \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_done \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_D \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_DONE_IRQ \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_EN \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_STROBE \
sim:/testbench/Teton_0/AFE1_IF/TX_STROBE \
sim:/testbench/Teton_0/AFE2_IF/TX_STROBE \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mod_en \
sim:/testbench/Teton_0/TX_APB_IF_0/s_clk_div \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_EN \
sim:/testbench/Teton_0/TX_APB_IF_0/s_baud_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mod_en \
sim:/testbench/Teton_0/TX_APB_IF_0/s_rnd \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd

add wave \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_state \
sim:/testbench/Teton_0/TX_APB_IF_0/s_oct_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/s_buffer \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd

add wave \
-signed \
-group {TX WAVE} \
sim:/testbench/Teton_0/gmsk_tx_0/TX_D \
sim:/testbench/Teton_0/gmsk_tx_0/TX_EN \
-analog-step -min -512 -max 512 -height 200 \
sim:/testbench/Teton_0/gmsk_tx_0/TX_I \
sim:/testbench/Teton_0/gmsk_tx_0/TX_Q


add wave \
-signed \
-group {INTERPOLATOR} \
sim:/testbench/Teton_0/cic_interpolator_I/rst \
sim:/testbench/Teton_0/cic_interpolator_I/clk \
sim:/testbench/Teton_0/cic_interpolator_I/clk_enable \
sim:/testbench/Teton_0/cic_interpolator_I/ce_out \
-analog-step -min -512 -max 512 -height 200 \
sim:/testbench/Teton_0/cic_interpolator_I/filter_in \
sim:/testbench/Teton_0/cic_interpolator_Q/filter_in \
sim:/testbench/Teton_0/cic_interpolator_I/filter_out \
sim:/testbench/Teton_0/cic_interpolator_Q/filter_out


#add wave  \
#-signed \
#-group {Gauss filter} \
#sim:/testbench/Teton_0/gmsk_tx_0/GlobalEnable1 \
#sim:/testbench/Teton_0/gmsk_tx_0/GlobalEnable20 \
#sim:/testbench/Teton_0/gmsk_tx_0/GlobalReset \
#sim:/testbench/Teton_0/gmsk_tx_0/TX_D \
#sim:/testbench/Teton_0/gmsk_tx_0/TX_EN \
#sim:/testbench/Teton_0/gmsk_tx_0/TXD_decimated \
#sim:/testbench/Teton_0/gmsk_tx_0/Gaussian_Filter_FIR1_block/myGaussian_Filter_FIR1/clk \
#sim:/testbench/Teton_0/gmsk_tx_0/Gaussian_Filter_FIR1_block/myGaussian_Filter_FIR1/enBuf \
#sim:/testbench/Teton_0/gmsk_tx_0/Gaussian_Filter_FIR1_block/myGaussian_Filter_FIR1/gEnable \
#sim:/testbench/Teton_0/gmsk_tx_0/Gaussian_Filter_FIR1_block/myGaussian_Filter_FIR1/gReset \
#sim:/testbench/Teton_0/gmsk_tx_0/Gaussian_Filter_FIR1_block/myGaussian_Filter_FIR1/rstBuf \
#sim:/testbench/Teton_0/gmsk_tx_0/Gaussian_Filter_FIR1_block/myGaussian_Filter_FIR1/enBuf \
#sim:/testbench/Teton_0/gmsk_tx_0/Gaussian_Filter_FIR1_block/tmpIn \
#-analog-step -min -17000 -max 17000 -height 100 \
#sim:/testbench/Teton_0/gmsk_tx_0/Gaussian_Filter_FIR1_block/tmpOut \
#-analog-step -min -512 -max 512 -height 100 \
#sim:/testbench/Teton_0/gmsk_tx_0/TX_I \
#sim:/testbench/Teton_0/gmsk_tx_0/TX_Q

#add wave \
#-signed \
#sim:/testbench/Teton_0/TX_APB_IF_0_TX_D \
#sim:/testbench/Teton_0/TX_APB_IF_0_TX_EN \
#sim:/testbench/Teton_0/Teton_MSS_0_FAB_CLK \
#-analog-step -min -512 -max 512 -height 100 \
#sim:/testbench/Teton_0/top_gmsk_tx_0_TX_I \
#sim:/testbench/Teton_0/top_gmsk_tx_0_TX_Q



#sim:/testbench/Teton_0/TX_APB_IF_0/s_data_buffer \

add wave  \
-group {AFE2} \
-decimal \
-analog-step -min -512 -max 512 -height 50 \
sim:/testbench/Teton_0/AFE2_IF/TX_STROBE \
sim:/testbench/Teton_0/AFE2_IF/TX_I \
sim:/testbench/Teton_0/AFE2_IF/TX_Q \
-unsigned \
-analog-step -min 0 -max 1023 -height 50 \
sim:/testbench/Teton_0/AFE2_IF/s_obuf \
sim:/testbench/Teton_0/AFE2_IF/s_tx_i \
sim:/testbench/Teton_0/AFE2_IF/s_tx_q

#-analog-step -min -16384 -max 16384 -height 50 \
#-label {Gaussian FIR in} sim:/testbench/Teton_0/TX_APB_IF_0/u_GMSK_TX/Gaussian_Filter_FIR_block/myGaussian_Filter_FIR/inp \
#-analog-step -min -16384 -max 16384 -height 50 \
#-label {Gaussian FIR out} sim:/testbench/Teton_0/TX_APB_IF_0/u_GMSK_TX/Gaussian_Filter_FIR_block/myGaussian_Filter_FIR/outp \
#-analog-step -min -4294967296 -max 4294967296 -height 50 \
#-label {Integrator out} \
#sim:/testbench/Teton_0/TX_APB_IF_0/u_GMSK_TX/N_5 \

#add wave \
#-group {TX WAVEFORMS} \
#-analog-step -min -512 -max 512 -height 100 \
#-label {TX I} sim:/testbench/Teton_0/TX_APB_IF_0/TX_I \
#-label {TX Q} sim:/testbench/Teton_0/TX_APB_IF_0/TX_Q \
#-unsigned \
#-label {TX STROBE} sim:/testbench/Teton_0/TX_APB_IF_0/TX_STROBE 

add wave  \
-group {RX WAVEFORMS} \
sim:/testbench/Teton_0/RX_APB_IF_0/RX_STROBE \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_RX/Port_Out \
-analog-step -min -512 -max 512 -height 100 \
sim:/testbench/Teton_0/RX_APB_IF_0/RX_I \
sim:/testbench/Teton_0/RX_APB_IF_0/RX_Q

add wave \
-group {RX SYNC} \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd(15) \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/bit_in_reg \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/Correlation_metric_e0 \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/Correlation_metric_e1 \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/Correlation_metric_e2 \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/Correlation_metric_e3 \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/Correlation_metric_e4 \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/Correlation_metric_e5 \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/Correlation_metric_e6 \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/Correlation_metric_e7 \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/bit_valid_reg \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/bit_out_reg


add wave  \
-group {RX BUFFER} \
-hex \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_symbol_valid \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_strobe_div8 \
sim:/testbench/Teton_0/RX_APB_IF_0/s_data_buffer \
-unsigned \
sim:/testbench/Teton_0/RX_APB_IF_0/s_bit_ctr \
-hex \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_wr \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_in \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_full \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_rd \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_out \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_empty \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_fetch \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_fetch_prev

add wave  \
-unsigned \
-group {RX FSM} \
sim:/testbench/Teton_0/RX_APB_IF_0/rst \
sim:/testbench/Teton_0/RX_APB_IF_0/clk \
sim:/testbench/Teton_0/RX_APB_IF_0/u_GMSK_SYNC/bit_valid

add wave  \
sim:/testbench/Teton_0/TX_APB_IF_0/TX_DONE_IRQ \
sim:/testbench/Teton_0/RX_APB_IF_0/SFD_IRQ \
sim:/testbench/Teton_0/RX_APB_IF_0/RX_DONE_IRQ

#sim:/testbench/Teton_0/RX_APB_IF_0/RXD_STROBE \
add wave \
-signed sim:/testbench/Teton_0/RX_APB_IF_0/RXD \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_symbol \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_symbol_valid \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_strobe_div8 \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_byte_valid \
sim:/testbench/Teton_0/RX_APB_IF_0/s_payload_ctr \
sim:/testbench/Teton_0/RX_APB_IF_0/s_payload_ctr_next \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_state \
sim:/testbench/Teton_0/RX_APB_IF_0/s_sync_rst \
-unsigned sim:/testbench/Teton_0/RX_APB_IF_0/s_bit_ctr \
-hex \
sim:/testbench/Teton_0/RX_APB_IF_0/s_data_buffer \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_wr \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_in \
sim:/testbench/Teton_0/RX_APB_IF_0/PREADY \
sim:/testbench/Teton_0/RX_APB_IF_0/s_pready \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_rd \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_fetch \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_fetch_prev \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_out \
sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_empty

add wave  \
-group {RX APB} \
-hex \
sim:/testbench/Teton_0/RX_APB_IF_0/PCLK \
sim:/testbench/Teton_0/RX_APB_IF_0/PRESETn \
sim:/testbench/Teton_0/RX_APB_IF_0/PADDR \
sim:/testbench/Teton_0/RX_APB_IF_0/PSEL \
sim:/testbench/Teton_0/RX_APB_IF_0/PENABLE \
sim:/testbench/Teton_0/RX_APB_IF_0/PWRITE \
sim:/testbench/Teton_0/RX_APB_IF_0/PWDATA \
sim:/testbench/Teton_0/RX_APB_IF_0/PREADY \
sim:/testbench/Teton_0/RX_APB_IF_0/PRDATA \
sim:/testbench/Teton_0/RX_APB_IF_0/PSLVERR \
sim:/testbench/Teton_0/RX_APB_IF_0/SFD_IRQ

add wave  \
-group {MOD MUX} \
sim:/testbench/Teton_0/TX_APB_IF_0/s_lfsr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mod_en \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mod_in \
sim:/testbench/Teton_0/TX_APB_IF_0/s_mod_in_mux \
sim:/testbench/Teton_0/TX_APB_IF_0/s_rnd \
sim:/testbench/Teton_0/TX_APB_IF_0/s_symbol_end


run 1500 us
wave zoom full
