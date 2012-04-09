# External Analog Front-End interface signals

add wave  \
sim:/usb_if_tb/uut/RST \
\
sim:/usb_if_tb/sys_clk \
-divider {Internal IF} \
sim:/usb_if_tb/uut/TX_STROBE \
sim:/usb_if_tb/uut/TXD \
sim:/usb_if_tb/uut/RX_STROBE \
sim:/usb_if_tb/uut/RXD \
-divider {External pins} \
sim:/usb_if_tb/uut/USB_CLK_pin \
sim:/usb_if_tb/uut/DATA_pin \
sim:/usb_if_tb/uut/OE_n_pin \
sim:/usb_if_tb/uut/RD_n_pin \
sim:/usb_if_tb/uut/WR_n_pin \
sim:/usb_if_tb/uut/RXF_n_pin \
sim:/usb_if_tb/uut/TXE_n_pin \
sim:/usb_if_tb/uut/SIWU_n_pin \
sim:/usb_if_tb/uut/ACBUS8_pin \
sim:/usb_if_tb/uut/ACBUS9_pin \
-divider IOBUF \
sim:/usb_if_tb/uut/s_oe \
sim:/usb_if_tb/uut/s_obuf \
sim:/usb_if_tb/uut/s_ibuf \
-divider FIFO \
sim:/usb_if_tb/uut/USB_CLK \
sim:/usb_if_tb/uut/s_tx_fifo_re \
sim:/usb_if_tb/uut/s_rx_fifo_we \
sim:/usb_if_tb/uut/s_rx_strobe \
sim:/usb_if_tb/uut/s_rx_fifo_empty


#run 10 us
run -all

wave zoom full
