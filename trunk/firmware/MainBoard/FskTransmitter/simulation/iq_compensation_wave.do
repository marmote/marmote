#-analog-step -min -512 -max 512 -height 50 

add wave  \
-group {APB interface} \
-unsigned \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PCLK \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PRESETn \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PADDR \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PSEL \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PENABLE \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PWRITE \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PWDATA \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PREADY \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PRDATA \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/PSLVERR

add wave \
-group {I/Q signals} \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/IN_STROBE \
-signed \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/RST \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/CLK \
-analog-step -min -512 -max 512 -height 100 \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/IN_I \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/IN_Q \
-analog-step -min -512 -max 512 -height 100 \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_i_delayed \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_q_delayed \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/OUT_I \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/OUT_Q \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/OUT_STROBE

add wave \
-group {Parameters} \
-signed \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_ampl_i \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_ampl_q \
-unsigned \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_delay_i \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_delay_q

add wave \
-group {Delay FIFO} \
-unsigned \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_rd_en \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_wr_en \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_wr_addr \
-signed \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/IN_I \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/IN_Q \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_rd_addr_i \
-signed \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_i_delayed \
-unsigned \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_rd_addr_q \
-signed \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_q_delayed \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_en_d \
sim:/testbench/Teton_0/IQ_COMPENSATION_0/s_strobe 


run 100 us
# run -all

wave zoom full
