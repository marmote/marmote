from Diff import Diff

def Diff2(y) :
	(dy, sample_shift) = Diff(y)
	(ddy, sample_shift2) = Diff(dy)
	return (ddy, sample_shift + sample_shift2)
