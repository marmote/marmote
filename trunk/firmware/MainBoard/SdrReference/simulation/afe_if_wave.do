# External Analog Front-End interface signals


add wave  \
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

run -all

wave zoom full
