# External Analog Front-End interface signals

#add wave  \
#-hex \
#-divider {Internal IF} \
#sim:/usb_if_tb/uut/TX_STROBE \
#sim:/usb_if_tb/uut/TXD_I \
#sim:/usb_if_tb/uut/TXD_Q \
#sim:/usb_if_tb/uut/RX_STROBE \
#sim:/usb_if_tb/uut/RXD \
#-divider {External pins} \
#sim:/usb_if_tb/uut/USB_CLK_pin \
#sim:/usb_if_tb/uut/DATA_pin \
#sim:/usb_if_tb/uut/OE_n_pin \
#sim:/usb_if_tb/uut/RD_n_pin \
#sim:/usb_if_tb/uut/WR_n_pin \
#sim:/usb_if_tb/uut/RXF_n_pin \
#sim:/usb_if_tb/uut/TXE_n_pin \
#sim:/usb_if_tb/uut/SIWU_n_pin \
#sim:/usb_if_tb/uut/ACBUS8_pin \
#sim:/usb_if_tb/uut/ACBUS9_pin \
#-divider IOBUF \
#sim:/usb_if_tb/uut/s_oe \
#sim:/usb_if_tb/uut/s_obuf \
#sim:/usb_if_tb/uut/s_ibuf \
#-divider FIFO \
#sim:/usb_if_tb/uut/USB_CLK \
#sim:/usb_if_tb/uut/s_tx_fifo_re \
#sim:/usb_if_tb/uut/s_tx_fifo_empty \
#sim:/usb_if_tb/uut/s_rx_fifo_we \
#sim:/usb_if_tb/uut/s_rx_strobe


add wave  \
-divider {TX SM} \
-hex \
sim:/usb_if_tb/uut/RST \
sim:/usb_if_tb/uut/USB_CLK \
sim:/usb_if_tb/uut/s_tx_sm_state \
sim:/usb_if_tb/uut/s_tx_sm_state_next \
sim:/usb_if_tb/uut/TXE_n_pin \
sim:/usb_if_tb/uut/DATA_pin \
-unsigned \
sim:/usb_if_tb/uut/s_tx_sample_ctr \
-hex \
sim:/usb_if_tb/uut/s_tx_i_fifo_empty \
sim:/usb_if_tb/uut/s_tx_i_fifo_aempty \
sim:/usb_if_tb/uut/s_tx_i_fifo_afull \
sim:/usb_if_tb/uut/s_obuf \
sim:/usb_if_tb/uut/s_tx_fifo_re \
sim:/usb_if_tb/uut/s_tx_i_fifo_out \
sim:/usb_if_tb/uut/s_tx_q_fifo_out 

#add wave \
#-divider {PARAMETERS} \
#-hex \
#sim:/usb_if_tb/uut/c_FRAME_LENGTH \
#sim:/usb_if_tb/uut/c_AFULL_VAL


add wave  \
-unsigned \
-divider {TX FIFO} \
-hex \
sim:/usb_if_tb/uut/u_TX_I_FIFO/WCLOCK \
sim:/usb_if_tb/uut/TX_STROBE \
sim:/usb_if_tb/uut/TXD_I \
sim:/usb_if_tb/uut/TXD_Q \
sim:/usb_if_tb/uut/u_TX_I_FIFO/WE \
sim:/usb_if_tb/uut/u_TX_I_FIFO/RE \
sim:/usb_if_tb/uut/u_TX_I_FIFO/RCLOCK \
sim:/usb_if_tb/uut/u_TX_I_FIFO/FULL \
sim:/usb_if_tb/uut/u_TX_I_FIFO/EMPTY \
sim:/usb_if_tb/uut/s_obuf \
sim:/usb_if_tb/uut/s_ibuf \
sim:/usb_if_tb/uut/s_oe \
-divider {PINs} \
sim:/usb_if_tb/uut/USB_CLK_pin \
sim:/usb_if_tb/uut/TXE_n_pin \
-unsigned \
sim:/usb_if_tb/uut/DATA_pin \
sim:/usb_if_tb/uut/WR_n_pin \
sim:/usb_if_tb/uut/OE_n_pin 


#run 1 us
run 5700 ns
#run -all

wave zoom full
