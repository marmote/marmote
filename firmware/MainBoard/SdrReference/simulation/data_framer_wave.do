#sim:/data_framer_tb/uut/CLK \
#sim:/data_framer_tb/uut/TX_I \
#sim:/data_framer_tb/uut/TX_Q \
#sim:/data_framer_tb/uut/TX_STROBE \

add wave \
-hex \
-divider IF \
sim:/data_framer_tb/uut/RST \
sim:/data_framer_tb/uut/USB_CLK \
sim:/data_framer_tb/uut/TXD_REQ \
sim:/data_framer_tb/uut/TXD_EN \
sim:/data_framer_tb/uut/TXD_RD \
sim:/data_framer_tb/uut/TXD \
-divider INTERNAL \
sim:/data_framer_tb/uut/s_state \
sim:/data_framer_tb/uut/s_state_next \
sim:/data_framer_tb/uut/s_chk_a \
sim:/data_framer_tb/uut/s_chk_b \
sim:/data_framer_tb/uut/s_txd \
sim:/data_framer_tb/uut/s_txd_next \
sim:/data_framer_tb/uut/s_txd_req \
sim:/data_framer_tb/uut/s_txd_req_next \
sim:/data_framer_tb/uut/s_seq_fifo_aempty \
-divider CONSTANTS \
sim:/data_framer_tb/uut/c_SYNC_CHAR_1 \
sim:/data_framer_tb/uut/c_SYNC_CHAR_2 \
sim:/data_framer_tb/uut/c_MSG_CLASS \
sim:/data_framer_tb/uut/c_MSG_ID \
sim:/data_framer_tb/uut/c_MSG_LEN

run -all

wave zoom full


