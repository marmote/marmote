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
-group {TX FIFO} \
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



#add wave \
#-unsigned \
#-group {TX FSM} \
#sim:/testbench/Teton_0/TX_APB_IF_0/rst \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_start \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_state \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_state_next \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_oct_ctr \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_oct_ctr_next \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr_next \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_rd \
#-hex sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_out \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_full \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_empty \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_fifo_aempty \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_buffer \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_buffer_next \
#-unsigned sim:/testbench/Teton_0/TX_APB_IF_0/s_baud_ctr \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_symbol_end \
#-hex \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_status \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr \
#-signed \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_txd(15) \
#-unsigned \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_done \
#sim:/testbench/Teton_0/TX_APB_IF_0/TX_D \
#sim:/testbench/Teton_0/TX_APB_IF_0/TX_DONE_IRQ \
#sim:/testbench/Teton_0/TX_APB_IF_0/TX_EN \
#sim:/testbench/Teton_0/TX_APB_IF_0/TX_STROBE \
#sim:/testbench/Teton_0/AFE1_IF/TX_STROBE \
#sim:/testbench/Teton_0/AFE2_IF/TX_STROBE \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_mod_en \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_clk_div \
#sim:/testbench/Teton_0/TX_APB_IF_0/TX_EN \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_baud_ctr \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_mod_en \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_rnd \
#sim:/testbench/Teton_0/TX_APB_IF_0/s_txd

add wave \
-group {TX FSM (reduced)} \
-unsigned \
sim:/testbench/Teton_0/TX_APB_IF_0/s_tx_state \
sim:/testbench/Teton_0/TX_APB_IF_0/s_oct_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_bit_ctr \
sim:/testbench/Teton_0/TX_APB_IF_0/s_payload_length \
-hex \
sim:/testbench/Teton_0/TX_APB_IF_0/s_buffer \
sim:/testbench/Teton_0/TX_APB_IF_0/s_txd

add wave \
-signed \
-label {TX WAVEFORMS} \
sim:/testbench/Teton_0/qpsk_tx_0/TX_D \
sim:/testbench/Teton_0/qpsk_tx_0/TX_EN \
-analog-step -min -512 -max 512 -height 200 \
sim:/testbench/Teton_0/qpsk_tx_0/TX_I \
sim:/testbench/Teton_0/qpsk_tx_0/TX_Q \

add wave \
sim:/testbench/Teton_0/qpsk_tx_0/GlobalEnable1 \
sim:/testbench/Teton_0/qpsk_tx_0/GlobalEnable10 \
sim:/testbench/Teton_0/qpsk_tx_0/GlobalEnable20 \
sim:/testbench/Teton_0/qpsk_tx_0/TX_Q \
sim:/testbench/Teton_0/qpsk_tx_0/TX_I \
sim:/testbench/Teton_0/qpsk_tx_0/TX_EN \
sim:/testbench/Teton_0/qpsk_tx_0/TX_D \
sim:/testbench/Teton_0/qpsk_tx_0/q_slow \
sim:/testbench/Teton_0/qpsk_tx_0/i_slow \
sim:/testbench/Teton_0/qpsk_tx_0/symbol



add wave  \
-group {RX WAVEFORMS} \
sim:/testbench/Teton_0/gmsk_rx_0/GlobalEnable1 \
sim:/testbench/Teton_0/gmsk_rx_0/RX_D \
-analog-step -min -512 -max 512 -height 100 \
sim:/testbench/Teton_0/gmsk_rx_0/RX_I \
sim:/testbench/Teton_0/gmsk_rx_0/RX_Q

#sim:/testbench/Teton_0/TX_APB_IF_0/s_txd(15) \
add wave \
-group {RX SYNC} \
-unsigned \
sim:/testbench/Teton_0/GMSK_SYNC_0/RX_D_IN \
sim:/testbench/Teton_0/GMSK_SYNC_0/RX_D_VALID \
sim:/testbench/Teton_0/GMSK_SYNC_0/RX_D_OUT \
-analog-step -min 0 -max 24 -height 100 \
sim:/testbench/Teton_0/GMSK_SYNC_0/Correlation_metric_e0 \
sim:/testbench/Teton_0/GMSK_SYNC_0/Correlation_metric_e1 \
sim:/testbench/Teton_0/GMSK_SYNC_0/Correlation_metric_e2 \
sim:/testbench/Teton_0/GMSK_SYNC_0/Correlation_metric_e3 \
sim:/testbench/Teton_0/GMSK_SYNC_0/Correlation_metric_e4 \
sim:/testbench/Teton_0/GMSK_SYNC_0/Correlation_metric_e5 \
sim:/testbench/Teton_0/GMSK_SYNC_0/Correlation_metric_e6 \
sim:/testbench/Teton_0/GMSK_SYNC_0/Correlation_metric_e7

#add wave -label {RX FSM}

add wave  \
-unsigned \
sim:/testbench/Teton_0/RX_APB_IF_0/rst \
sim:/testbench/Teton_0/RX_APB_IF_0/clk \
sim:/testbench/Teton_0/RX_APB_IF_0/s_payload_length \
sim:/testbench/Teton_0/RX_APB_IF_0/s_payload_ctr \
sim:/testbench/Teton_0/RX_APB_IF_0/RX_D_VALID


add wave  \
-group {RX FIFO} \
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
sim:/testbench/Teton_0/TX_APB_IF_0/TX_DONE_IRQ \
sim:/testbench/Teton_0/RX_APB_IF_0/SFD_IRQ \
sim:/testbench/Teton_0/RX_APB_IF_0/RX_DONE_IRQ

#add wave \
#-signed sim:/testbench/Teton_0/RX_APB_IF_0/RXD \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_symbol \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_symbol_valid \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_strobe_div8 \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_byte_valid \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_payload_ctr \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_payload_ctr_next \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_state \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_sync_rst \
#-unsigned sim:/testbench/Teton_0/RX_APB_IF_0/s_bit_ctr \
#-hex \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_data_buffer \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_wr \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_in \
#sim:/testbench/Teton_0/RX_APB_IF_0/PREADY \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_pready \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_rd \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_fetch \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_fetch_prev \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_out \
#sim:/testbench/Teton_0/RX_APB_IF_0/s_rx_fifo_empty

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


run 2000 us
wave zoom full
