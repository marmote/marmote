from Onset_Reciprocal_min			import Onset_Reciprocal
from Proper_Packet_Table_Level_Size	import Proper_Packet_Table_Level_Size 


def Onset_Times(packet_table_best_basis, levels, N, T) :
	assert len(packet_table_best_basis) == len(levels), "packet table should have as many items as the levels variable"
	assert len(packet_table_best_basis) > 0, "packet table size should be greater than 0"
	assert N > 0, "original size of the signal should be greater than 0"

	onsets = []
	qtys = []

	for idx in xrange( len(levels) ):
		y_temp = packet_table_best_basis[idx]

		_, _, start_idx, stop_idx = Proper_Packet_Table_Level_Size( levels[idx], N, len(y_temp) )

		y_temp = y_temp[start_idx:stop_idx]
		N_temp = stop_idx - start_idx 

		T_temp = T*(2**levels[idx])
		onset, qty, curves = Onset_Reciprocal( y_temp, T_temp, skip_samples=int(N_temp*0.1) )

		onsets.append(onset)
		qtys.append(qty)

	return onsets, qtys

