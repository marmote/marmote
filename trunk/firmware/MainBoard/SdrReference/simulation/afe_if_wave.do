# External Analog Front-End interface signals


add wave  \
-unsigned \
sim:/afe_if_tb/CLK \
sim:/afe_if_tb/RST \
sim:/afe_if_tb/ENABLE \
sim:/afe_if_tb/READY \
sim:/afe_if_tb/TX_RXn \
-divider RX \
sim:/afe_if_tb/RX_STROBE \
sim:/afe_if_tb/RX_I \
sim:/afe_if_tb/RX_Q \
-divider TX \
sim:/afe_if_tb/TX_STROBE \
sim:/afe_if_tb/TX_I \
sim:/afe_if_tb/TX_Q \
-divider {AFE interface} \
sim:/afe_if_tb/CLKOUT \
sim:/afe_if_tb/SHDN_n \
sim:/afe_if_tb/TR_n \
sim:/afe_if_tb/DATA \
-divider STUB \
sim:/afe_if_tb/s_afe_ctr \
sim:/afe_if_tb/s_afe_txd \
sim:/afe_if_tb/stop_the_clock 

add wave  \
-unsigned \
-divider INTERNAL \
sim:/afe_if_tb/uut/s_oe \
sim:/afe_if_tb/uut/s_do \
sim:/afe_if_tb/uut/s_di \
sim:/afe_if_tb/uut/s_enable_d \
sim:/afe_if_tb/uut/s_ready \
sim:/afe_if_tb/uut/s_tx_rxn \
sim:/afe_if_tb/uut/s_tx_i \
sim:/afe_if_tb/uut/s_tx_q \
sim:/afe_if_tb/uut/s_rx_strobe \
sim:/afe_if_tb/uut/s_rx_i \
sim:/afe_if_tb/uut/s_rx_q

#sim:/afe_if_tb/uut/s_obuf \
#sim:/afe_if_tb/uut/s_ibuf \

run -all

wave zoom full
