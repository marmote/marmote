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
sim:/tx_apb_if_tb/uut/s_status \
sim:/tx_apb_if_tb/uut/s_test \
sim:/tx_apb_if_tb/uut/s_tx_en \
-bin sim:/tx_apb_if_tb/uut/s_ptrn \
-bin sim:/tx_apb_if_tb/uut/s_mask \
-dec \
sim:/tx_apb_if_tb/uut/s_tx_i \
sim:/tx_apb_if_tb/uut/s_tx_q \
sim:/tx_apb_if_tb/uut/s_tx_done \
sim:/tx_apb_if_tb/uut/c_TX_HIGH \
sim:/tx_apb_if_tb/uut/c_TX_LOW \
sim:/tx_apb_if_tb/uut/s_dout \

run -all

wave zoom full
