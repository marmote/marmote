from optparse import OptionParser

from gnuradio import gr
import gnuradio.extras


from gnuradio.gr import firdes
from gnuradio.wxgui import fftsink2
from gnuradio.wxgui import scopesink2
from grc_gnuradio import wxgui as grc_wxgui


import tools.FileSource     as FS
import GNUradio_blocks.FrameSource   as FrameS


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


################################################################################
class Top_Block(grc_wxgui.top_block_gui):

    def __init__(self, Source):
        grc_wxgui.top_block_gui.__init__(self, title="Top Block")

        ##################################################
        # Variables
        ##################################################
        self.samp_rate = samp_rate = 750e3
        self.transition = transition = 100e3
        self.cutoff = cutoff = 100000

        ##################################################
        # Blocks
        ##################################################
        self.frame_source = FrameS.FrameSource(Source)

        self.wxgui_scopesink2_0 = scopesink2.scope_sink_f(
			self.GetWin(),
			title="Scope Plot",
			sample_rate=samp_rate,
			v_scale=0.2,
			v_offset=0,
			t_scale=0.0000500,
			ac_couple=False,
			xy_mode=False,
			num_inputs=1,
			trig_mode=gr.gr_TRIG_MODE_AUTO,
			y_axis_label="Counts",
		)

        self.Add(self.wxgui_scopesink2_0.win)

        self.wxgui_fftsink2_0 = fftsink2.fft_sink_f(
			self.GetWin(),
			baseband_freq=0,
			y_per_div=10,
			y_divs=10,
			ref_level=0,
			ref_scale=2.0,
			sample_rate=samp_rate,
			fft_size=512,
			fft_rate=10*480,
			average=False,
			avg_alpha=None,
			title="FFT Plot",
			peak_hold=False,
		)

        self.Add(self.wxgui_fftsink2_0.win)

        self.wxgui_fftsink2_1 = fftsink2.fft_sink_f(
			self.GetWin(),
			baseband_freq=0,
			y_per_div=10,
			y_divs=10,
			ref_level=0,
			ref_scale=2.0,
			sample_rate=samp_rate,
			fft_size=512,
			fft_rate=10*480,
			average=False,
			avg_alpha=None,
			title="FFT Plot",
			peak_hold=False,
		)

        self.Add(self.wxgui_fftsink2_1.win)

        self.gr_short_to_float_0 = gr.short_to_float(1, 32768)
        self.gr_short_to_float_1 = gr.short_to_float(1, 32768)
        self.high_pass_filter_0 = gr.fir_filter_fff(1, firdes.high_pass(
			1, samp_rate, cutoff, transition, firdes.WIN_RECTANGULAR, 6.76))
        self.high_pass_filter_1 = gr.fir_filter_fff(1, firdes.high_pass(
			1, samp_rate, cutoff, transition, firdes.WIN_RECTANGULAR, 6.76))


        ##################################################
        # Connections
        ##################################################
        self.connect((self.frame_source, 0), (self.gr_short_to_float_0, 0))
        self.connect((self.frame_source, 1), (self.gr_short_to_float_1, 0))

        self.connect((self.gr_short_to_float_0, 0), (self.high_pass_filter_0, 0))
        self.connect((self.gr_short_to_float_1, 0), (self.high_pass_filter_1, 0))

        self.connect((self.high_pass_filter_0, 0), (self.wxgui_fftsink2_0, 0))
        self.connect((self.high_pass_filter_0, 0), (self.wxgui_scopesink2_0, 0))

        self.connect((self.high_pass_filter_1, 0), (self.wxgui_fftsink2_1, 0))


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    s = FS.FileSource(options.inputfileordir)

    tb = Top_Block(s)

    tb.Run(True)
    