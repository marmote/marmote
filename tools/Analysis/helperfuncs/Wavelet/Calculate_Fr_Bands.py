def Calculate_Fr_Bands(levels, Fs) :
	assert len(levels) > 0, "levels variable size should be greater than 0"
	assert Fs > 0, "original sampling frequency of signal should be greater than 0"

	bands = []

	fr = 0

	for idx in xrange( len(levels) ):
		band_width = ( Fs/2 ) / ( 2**levels[idx] )

		start_fr = fr
		stop_fr = fr + band_width

		fr += band_width

		bands.append((start_fr,stop_fr))

	return bands

