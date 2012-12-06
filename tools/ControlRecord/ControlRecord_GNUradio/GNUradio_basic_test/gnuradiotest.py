#bring in blocks from the main gnu radio package
from gnuradio import gr
#bring in the audio source/sink
from gnuradio import audio

#create the flow graph
tb = gr.top_block()

#create the signal sources
#parameters: samp_rate, type, output freq, amplitude, offset
src1 = gr.sig_source_f(32000, gr.GR_SIN_WAVE, 350, .5, 0)
src2 = gr.sig_source_f(32000, gr.GR_SIN_WAVE, 440, .5, 0)

#an adder to combine the sources
#the _ff indicates float input and float output
adder = gr.add_ff()

#create a signal sink
sink = audio.sink(32000)

#connect the adder
#the adder has multiple inputs...
#we must use this syntax to choose which input to use
tb.connect(src1, (adder, 0))
tb.connect(src2, (adder, 1))

#connect the adder to the sink
tb.connect(adder, sink)

#run the flow graph
tb.run()