from Onset_Time.Onset_Reciprocal_min        import Onset_Reciprocal
from Onset_Time.Onset_AIC                   import Onset_AIC
from Wavelet.Proper_Packet_Table_Level_Size import Proper_Packet_Table_Level_Size 
from Wavelet.Calculate_Fr_Bands             import Calculate_Fr_Bands


def Get_Trimmed_Packet(packet_table_best_basis, levels, N, idx) :
    assert len(packet_table_best_basis) == len(levels), "packet table should have as many items as the levels variable"
    assert len(packet_table_best_basis) > 0, "packet table size should be greater than 0"
    assert N > 0, "original size of the signal should be greater than 0"

    y_temp = packet_table_best_basis[idx]

    _, _, start_idx, stop_idx = Proper_Packet_Table_Level_Size( levels[idx], N, len(y_temp) )

    y_temp = y_temp[start_idx:stop_idx]
    N_temp = stop_idx - start_idx 

    return y_temp, N_temp


def Onset_Times(packet_table_best_basis, levels, N, T, qty_th) :
    assert len(packet_table_best_basis) == len(levels), "packet table should have as many items as the levels variable"
    assert len(packet_table_best_basis) > 0, "packet table size should be greater than 0"
    assert N > 0, "original size of the signal should be greater than 0"

    all_bands = Calculate_Fr_Bands(levels, 1.0/T)

    onsets  = []
    qtys    = []
    bands   = []

    for idx in xrange( len(levels) ):
        y_temp, N_temp = Get_Trimmed_Packet(packet_table_best_basis, levels, N, idx)

        T_temp = T*(2**levels[idx])
        onset, qty, curves = Onset_AIC( y_temp, T_temp, skip_samples=int(N_temp*0.05) )

        if qty >= qty_th:
            onsets.append(onset)
            qtys.append(qty)
            bands.append(all_bands[idx])

    return onsets, qtys, bands

