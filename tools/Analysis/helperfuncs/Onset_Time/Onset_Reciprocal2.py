import numpy as np
from Fitnes_Reciprocal import Fitnes_Reciprocal
from Diff import Diff


def Onset_Reciprocal(y, T, skip_samples=20) :
	fitnes, sample_shift = Fitnes_Reciprocal(y, skip_samples=skip_samples)


#Calculate onset time and quality
# Alternative 1
#	sums_num = 3
#
#	start_idx = sums_num
#	stop_idx = fitnes.size - sums_num
#
#	fitnes2 = np.zeros(stop_idx-start_idx+1)
#	for i in xrange(fitnes2.size):
#		idx = start_idx + i
#		fitnes2[i] = np.sum(fitnes[idx-sums_num:idx]) / np.sum(fitnes[idx:idx+sums_num])
#
#	onset_idx = np.argmax(fitnes2)
#	quality = np.amax(fitnes2)
#
#	sample_shift2 = sums_num - 0.5

# Alternative 2
#	start_idx = np.argmin(fitnes)
#	for ii in xrange(start_idx,fitnes.size):
#		onset_idx = ii
#		if fitnes[ii] >= -0.2:
#			break
#
#	sums_num = 3
#	idx = onset_idx
#	quality = np.sum(fitnes[idx-sums_num:idx]) / np.sum(fitnes[idx:idx+sums_num])

# Alternative 3
	sums_num = 1

	start_idx = sums_num
	stop_idx = fitnes.size - sums_num

	fitnes2 = np.zeros(stop_idx-start_idx+1)
	for i in xrange(fitnes2.size):
		idx = start_idx + i
		fitnes2[i] = np.sum(fitnes[idx-sums_num:idx]) / np.sum(fitnes[idx:idx+sums_num])

	fitnes2 -= 1
	onset_idx = np.argmax(fitnes2)
	quality = np.amax(fitnes2)

	sample_shift2 = sums_num - 0.5

#####################

	fitnes3, sample_shift3 = Diff(fitnes)



	fitnes4 = fitnes3 * fitnes2 * 100
	onset_idx = np.argmax(fitnes4)
	quality = np.amax(fitnes4)


	curves = []
	curves.append(('Fitnes based on Reciprocal approach', fitnes, sample_shift))
	curves.append(('Quality values', fitnes2, sample_shift+sample_shift2))
	curves.append(('Derivative of Fitnes', fitnes3, sample_shift+sample_shift3))
	curves.append(('Derivative times Fitnes', fitnes4, sample_shift+sample_shift3))

	return (sample_shift + sample_shift2 + onset_idx)*T, quality, curves
#	return (sample_shift + onset_idx)*T, quality, curves
