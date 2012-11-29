from gnuradio import gr
import gnuradio.extras

from gruel import pmt as pmt


import numpy as np


################################################################################
class CustomTwoChannelThreshold(gr.block):

################################################################################
    def __init__(self, Threshold_val = 0.15*2**15, WashOutLength = 300):
        gr.block.__init__(self, name="Two channel Threshold", in_sig=[np.int16, np.int16], out_sig=[np.int16, np.int16])
        self.set_auto_consume(False)

        self.Threshold_val = Threshold_val
        self.WashOutLength = WashOutLength

        self.WO_counter = 0
#        self.cum = 0


################################################################################
    def __del__( self ) :
        pass


################################################################################
    def forecast(self, noutput_items, ninput_items_required):
        #setup size of input_items[i] for work call
        for i in range(len(ninput_items_required)):
            ninput_items_required[i] = noutput_items


################################################################################
    def work(self, input_items, output_items):
#        g = open('./work.txt', 'ab')
#        g.write("CustomTwoChannelThreshold start\n")
#        g.close    

        nread = self.nitems_read(0) #number of items read on port 0

        ninput_items = min( len(input_items[0]), len(input_items[1]), len(output_items[0]), len(output_items[1]) )
#        input1 = np.array(input_items[0][:ninput_items], dtype=np.int16)
#        input2 = np.array(input_items[1][:ninput_items], dtype=np.int16)
        input1 = input_items[0]
        input2 = input_items[1]

        noutput_items = 0

        for ii in xrange(ninput_items) :

            if np.abs(input1[ii]) > self.Threshold_val or np.abs(input2[ii]) > self.Threshold_val :

             #   f = open('./Th_temp.txt', 'ab')

              #  f.write('ii: %d, th_val: %d, val1: %d, val2: %d\n'%(ii, self.Threshold_val, input1[ii], input2[ii]))

#                f.close()


                if self.WO_counter == 0 :
                    offset1 = self.nitems_written(0) + noutput_items
                    offset2 = self.nitems_written(1) + noutput_items
                    key = pmt.pmt_string_to_symbol( "Threshold event" )
                    value = pmt.pmt_string_to_symbol( "" )

                    self.add_item_tag(0, offset1, key, value)
                    self.add_item_tag(1, offset2, key, value)

                self.WO_counter = self.WashOutLength

            if self.WO_counter :
                self.WO_counter -= 1

#                output_items[0][noutput_items:noutput_items+1] = [input1[ii]]
#                output_items[1][noutput_items:noutput_items+1] = [input2[ii]]
                output_items[0][noutput_items] = input1[ii]
                output_items[1][noutput_items] = input2[ii]
                noutput_items += 1

        self.consume_each(ninput_items) #or shortcut to consume on all inputs

#        self.cum += ninput_items
#        g = open('./work.txt', 'ab')
#        g.write("CustomTwoChannelThreshold stop, in: %d, total: %d, out: %d\n"%(ninput_items, self.cum, noutput_items))
#        g.close

        return noutput_items
