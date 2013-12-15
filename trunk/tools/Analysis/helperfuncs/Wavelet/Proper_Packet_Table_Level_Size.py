def Proper_Packet_Table_Level_Size(Level, N, packet_size) :

	div_fact = 1. / 2**Level
	level_N = int(N * div_fact)

	start_idx = int((packet_size - level_N)/2)
	stop_idx = start_idx + level_N

	return div_fact, level_N, start_idx, stop_idx
