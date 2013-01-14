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
#sim:/usb_if_tb/uut/s_tx_i_fifo_re \
#sim:/usb_if_tb/uut/s_tx_q_fifo_re \
#sim:/usb_if_tb/uut/s_tx_fifo_empty \
#sim:/usb_if_tb/uut/s_rx_fifo_we \
#sim:/usb_if_tb/uut/s_rx_strobe

add wave  \
-hex \
-divider {APB} \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/USB_CONN \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/USB_RST \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/RXC_EMPTY \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/RXC_DATA \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/RXC_RD \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/TXC_FULL \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/TXC_DATA \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/TXC_WR \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PCLK \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PRESETn \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PADDR \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PSEL \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PENABLE \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PWRITE \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PWDATA \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PREADY \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PRDATA \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/PSLVERR \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/s_txc_data \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/s_txc_wr \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/s_txc_wr_prev \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/s_rxc_rd \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/s_rxc_rd_prev \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/s_dout \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/s_pready \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/c_ADDR_STAT \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/c_ADDR_TXC \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/c_ADDR_RXC \
sim:/testbench/Teton_0/USB_IF_0/u_CTRL_IF_APB/c_ADDR_TEST


#run -all
run 10000 ns

wave zoom full
