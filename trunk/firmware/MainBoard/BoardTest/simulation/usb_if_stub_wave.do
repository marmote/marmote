# External Analog Front-End interface signals

#add wave  \
#-hex \
#-divider {Internal IF} \
#sim:/usb_if_stub_tb/uut/TX_STROBE \
#sim:/usb_if_stub_tb/uut/TXD \
#sim:/usb_if_stub_tb/uut/RX_STROBE \
#sim:/usb_if_stub_tb/uut/RXD \
#-divider {External pins} \
#sim:/usb_if_stub_tb/uut/USB_CLK_pin \
#sim:/usb_if_stub_tb/uut/DATA_pin \
#sim:/usb_if_stub_tb/uut/OE_n_pin \
#sim:/usb_if_stub_tb/uut/RD_n_pin \
#sim:/usb_if_stub_tb/uut/WR_n_pin \
#sim:/usb_if_stub_tb/uut/RXF_n_pin \
#sim:/usb_if_stub_tb/uut/TXE_n_pin \
#sim:/usb_if_stub_tb/uut/SIWU_n_pin \
#sim:/usb_if_stub_tb/uut/ACBUS8_pin \
#sim:/usb_if_stub_tb/uut/ACBUS9_pin \
#-divider IOBUF \
#sim:/usb_if_stub_tb/uut/s_oe \
#sim:/usb_if_stub_tb/uut/s_obuf \
#sim:/usb_if_stub_tb/uut/s_ibuf \
#-divider FIFO \
#sim:/usb_if_stub_tb/uut/USB_CLK \
#sim:/usb_if_stub_tb/uut/s_tx_fifo_re \
#sim:/usb_if_stub_tb/uut/s_tx_fifo_empty \
#sim:/usb_if_stub_tb/uut/s_rx_fifo_we \
#sim:/usb_if_stub_tb/uut/s_rx_strobe

add wave  \
-divider {BIBUF} \
-hex \
sim:/usb_if_stub_tb/uut/s_obuf \
sim:/usb_if_stub_tb/uut/s_ibuf \
sim:/usb_if_stub_tb/uut/s_oe \
-divider {TX SM} \
-unsigned \
sim:/usb_if_stub_tb/uut/s_ctr_en \
sim:/usb_if_stub_tb/uut/s_ctr \
-divider {PINs} \
sim:/usb_if_stub_tb/uut/USB_CLK_pin \
sim:/usb_if_stub_tb/uut/DATA_pin \
sim:/usb_if_stub_tb/uut/WR_n_pin \
sim:/usb_if_stub_tb/uut/TXE_n_pin


#run 10 us
run -all

wave zoom full
