#-analog-step -min -512 -max 512 -height 50 

add wave  \
-signed \
sim:/testbench/Teton_0/CORECORDIC_0/CLK \
sim:/testbench/Teton_0/CORECORDIC_0/RST \
sim:/testbench/Teton_0/CORECORDIC_0/A0 \
sim:/testbench/Teton_0/CORECORDIC_0/X0 \
sim:/testbench/Teton_0/CORECORDIC_0/Y0


#add wave sim:/testbench/Teton_0/CORECORDIC_0/*

add wave  \
-signed \
-analog-step -min -512 -max 512 -height 50 \
sim:/testbench/Teton_0/CORECORDIC_0/AN \
sim:/testbench/Teton_0/CORECORDIC_0/XN \
sim:/testbench/Teton_0/CORECORDIC_0/YN

add wave  \
-signed \
-analog-step -min -512 -max 512 -height 50 \
sim:/testbench/Teton_0/SIGN_INV_0/CLK \
sim:/testbench/Teton_0/SIGN_INV_0/EN0 \
sim:/testbench/Teton_0/SIGN_INV_0/ENN \
sim:/testbench/Teton_0/SIGN_INV_0/INVERT \
sim:/testbench/Teton_0/SIGN_INV_0/X0 \
sim:/testbench/Teton_0/SIGN_INV_0/Y0 \
sim:/testbench/Teton_0/SIGN_INV_0/XN \
sim:/testbench/Teton_0/SIGN_INV_0/YN

add wave  \
sim:/testbench/Teton_0/AFE1_IF/CLK \
-signed \
-analog-step -min -512 -max 512 -height 50 \
sim:/testbench/Teton_0/AFE1_IF/TX_I \
sim:/testbench/Teton_0/AFE1_IF/TX_Q

add wave \
-unsigned \
-analog-step -min 0 -max 1024 -height 50 \
sim:/testbench/Teton_0/AFE1_IF/s_tx_i \
sim:/testbench/Teton_0/AFE1_IF/s_tx_q


run 100 us
# run -all

wave zoom full
