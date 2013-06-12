add wave  \
sim:/pn_generator_tb/CLK \
sim:/pn_generator_tb/RST \
sim:/pn_generator_tb/EN \
sim:/pn_generator_tb/MASK \
sim:/pn_generator_tb/SEED \
-decimal \
sim:/pn_generator_tb/SEQ

add wave  \
sim:/pn_generator_tb/uut/s_lfsr \
sim:/pn_generator_tb/uut/s_lfsr(0) \
sim:/pn_generator_tb/uut/s_lfsr(4) \

wave zoom full

