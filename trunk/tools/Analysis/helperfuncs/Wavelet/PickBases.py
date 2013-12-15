def PickBases(PacketTable, levels, items) :
	Packets = []

	for ii in xrange(len(levels)) :
		Packets.append(PacketTable[levels[ii]][items[ii]])
		
	return Packets
