from gnuradio import gr
import gnuradio.extras
import numpy
from time import sleep



class custom_block(gr.block):
    
    def __init__(self, args):
        gr.block.__init__(self, name="my adder",
        in_sig=[numpy.int8],
        out_sig=[numpy.int8])


    def work(self, input_items, output_items):
        #buffer references
        input = input_items[0]
        output = output_items[0]

        #process data
        output[:] = input

        #return produced
        return len(output)


class msg_blocks(gr.top_block):

    def __init__(self):
        gr.top_block.__init__(self, 'Message Blocks Test')

        # initialize the queues
        self.sink_queue = gr.msg_queue()
        self.source_queue = gr.msg_queue()

        # initialize the blocks
        self.msg_source = gr.message_source(gr.sizeof_char, self.source_queue)
        self.msg_sink = gr.message_sink(gr.sizeof_char, self.sink_queue, True)

        self.testblock = custom_block(None)

#        self.connect((self.msg_source, 0), (self.msg_sink, 0))
        self.connect((self.msg_source, 0), (self.testblock, 0))
        self.connect((self.testblock, 0), (self.msg_sink, 0))

    def send_pkt(self, payload):
        self.source_queue.insert_tail(gr.message_from_string(payload))

    def recv_pkt(self):
        pkt = ""

        if self.sink_queue.count():
            pkt = self.sink_queue.delete_head().to_string()

        return pkt            

if __name__=="__main__":
    tb = msg_blocks()
    tb.start()

    # operate on queues directly
    print 'operating on the queues directly'
    print 'sink queue count:', tb.sink_queue.count()

    print 'inkserting:', 'a'
    tb.source_queue.insert_tail(gr.message_from_string('a'))
#    tb.source_queue.insert_tail(gr.message(type=1))

#    sleep(1) # sleep to yield to tb thread
#    tb.wait()

    print 'sink queue count:', tb.sink_queue.count()

    print 'received:', tb.sink_queue.delete_head().to_string()

    # operate using methods
    print 'operating with fuctions supplied by the top block'
    print 'sending:', 'a'*512
    tb.send_pkt('a'*512)
    sleep(1)

    print 'received:', tb.recv_pkt()