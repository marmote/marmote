add wave -group {CONSTANTS} \
-hex \
sim:/tx_apb_if_tb/uut/c_PREAMBLE \
sim:/tx_apb_if_tb/uut/c_TX_HIGH \
sim:/tx_apb_if_tb/uut/c_TX_LOW \
sim:/tx_apb_if_tb/uut/c_ADDR_CTRL \
sim:/tx_apb_if_tb/uut/c_ADDR_FIFO \
sim:/tx_apb_if_tb/uut/c_ADDR_TEST \
sim:/tx_apb_if_tb/uut/c_ADDR_MOD_MUX \
sim:/tx_apb_if_tb/uut/c_ADDR_PRE_LEN \
sim:/tx_apb_if_tb/uut/c_ADDR_PAY_LEN \
sim:/tx_apb_if_tb/uut/c_ADDR_CHIP_DIV \
sim:/tx_apb_if_tb/uut/c_ADDR_SF \
sim:/tx_apb_if_tb/uut/c_ADDR_MASK \
sim:/tx_apb_if_tb/uut/c_ADDR_SEED \
-dec \
sim:/tx_apb_if_tb/uut/s_preamble_len \
sim:/tx_apb_if_tb/uut/s_payload_len \
sim:/tx_apb_if_tb/uut/s_chip_div \
sim:/tx_apb_if_tb/uut/s_sf


add wave \
-group {APB} \
sim:/tx_apb_if_tb/uut/PCLK \
sim:/tx_apb_if_tb/uut/PRESETn \
sim:/tx_apb_if_tb/uut/PADDR \
sim:/tx_apb_if_tb/uut/PWRITE \
sim:/tx_apb_if_tb/uut/PSEL \
sim:/tx_apb_if_tb/uut/PENABLE \
sim:/tx_apb_if_tb/uut/PWDATA \
sim:/tx_apb_if_tb/uut/PREADY \
sim:/tx_apb_if_tb/uut/PRDATA \
sim:/tx_apb_if_tb/uut/PSLVERR

add wave \
-divider {STATE MACHINE} \
sim:/tx_apb_if_tb/uut/clk \
sim:/tx_apb_if_tb/uut/rst \
sim:/tx_apb_if_tb/uut/s_start \
sim:/tx_apb_if_tb/uut/s_tx_done \
sim:/tx_apb_if_tb/uut/s_tx_state \
-hex \
sim:/tx_apb_if_tb/uut/s_tx_fifo_aempty \
sim:/tx_apb_if_tb/uut/s_tx_fifo_out \
sim:/tx_apb_if_tb/uut/s_tx_fifo_rd \
sim:/tx_apb_if_tb/uut/s_buffer \
-unsigned \
sim:/tx_apb_if_tb/uut/s_tx_en \
sim:/tx_apb_if_tb/uut/s_chip_ctr \
sim:/tx_apb_if_tb/uut/s_chip_end \
sim:/tx_apb_if_tb/uut/s_sym_ctr \
sim:/tx_apb_if_tb/uut/s_sym_end \
sim:/tx_apb_if_tb/uut/s_bit_ctr \
sim:/tx_apb_if_tb/uut/s_oct_ctr

add wave \
-divider {TX WAVEFORMS} \
sim:/tx_apb_if_tb/uut/s_buffer(7) \
sim:/tx_apb_if_tb/uut/s_diff_enc \
sim:/tx_apb_if_tb/uut/s_pn_seq \
-format analog-step \
-height 50 -min -768 -max 768 \
sim:/tx_apb_if_tb/uut/s_tx_i \
sim:/tx_apb_if_tb/uut/s_tx_q \

add wave \
-divider {PN GENERATOR} \
sim:/tx_apb_if_tb/uut/clk \
sim:/tx_apb_if_tb/uut/rst \
-hex \
sim:/tx_apb_if_tb/uut/s_lfsr \
sim:/tx_apb_if_tb/uut/s_lfsr(0) \
sim:/tx_apb_if_tb/uut/s_mask \
sim:/tx_apb_if_tb/uut/s_seed

run -all

wave zoom full

