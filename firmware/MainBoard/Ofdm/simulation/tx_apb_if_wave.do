add wave  \
-group {APB} \
-hex \
sim:/tx_apb_if_tb/uut/PCLK \
sim:/tx_apb_if_tb/uut/PRESETn \
sim:/tx_apb_if_tb/uut/PADDR \
sim:/tx_apb_if_tb/uut/PSEL \
sim:/tx_apb_if_tb/uut/PENABLE \
sim:/tx_apb_if_tb/uut/PWRITE \
sim:/tx_apb_if_tb/uut/PWDATA \
sim:/tx_apb_if_tb/uut/PREADY \
sim:/tx_apb_if_tb/uut/PRDATA \
sim:/tx_apb_if_tb/uut/PSLVERR \
sim:/tx_apb_if_tb/uut/TX_DONE_IRQ \
sim:/tx_apb_if_tb/uut/TX_EN \
sim:/tx_apb_if_tb/uut/TX_I \
sim:/tx_apb_if_tb/uut/TX_Q

#add wave \
#-bin sim:/tx_apb_if_tb/uut/g_PTRN \
#-bin sim:/tx_apb_if_tb/uut/g_MASK
#sim:/tx_apb_if_tb/uut/c_ADDR_CTRL \
#sim:/tx_apb_if_tb/uut/c_ADDR_TEST \
#sim:/tx_apb_if_tb/uut/c_ADDR_PTRN \
#sim:/tx_apb_if_tb/uut/c_ADDR_MASK

add wave \
sim:/tx_apb_if_tb/uut/clk \
sim:/tx_apb_if_tb/uut/rst \
sim:/tx_apb_if_tb/uut/s_tx_en \
-hex sim:/tx_apb_if_tb/uut/s_state \
-dec \
-bin sim:/tx_apb_if_tb/uut/s_ptrn \
-bin sim:/tx_apb_if_tb/uut/s_mask \
-hex \
sim:/tx_apb_if_tb/uut/c_TX_POS \
sim:/tx_apb_if_tb/uut/c_TX_NEG \
sim:/tx_apb_if_tb/uut/s_dout \

add wave \
-divider {IFFT} \
sim:/tx_apb_if_tb/uut/s_ifft_en \
-signed \
-analog-step -min -32768 -max 32768 -height 100 \
sim:/tx_apb_if_tb/uut/s_i_in \
sim:/tx_apb_if_tb/uut/s_q_in

add wave \
-hex \
sim:/tx_apb_if_tb/uut/s_rdy \
sim:/tx_apb_if_tb/uut/s_vld \
-signed \
-analog-step -min -512 -max 512 -height 100 \
sim:/tx_apb_if_tb/uut/s_i_out \
sim:/tx_apb_if_tb/uut/s_q_out

add wave  \
-signed \
sim:/tx_apb_if_tb/TX_EN \
-analog-step -min -512 -max 512 -height 100 \
sim:/tx_apb_if_tb/TX_I \
sim:/tx_apb_if_tb/TX_Q \
sim:/tx_apb_if_tb/uut/LED


run -all

wave zoom full
