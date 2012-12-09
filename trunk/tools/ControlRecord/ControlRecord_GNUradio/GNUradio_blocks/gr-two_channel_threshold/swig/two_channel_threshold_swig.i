/* -*- c++ -*- */

#define TWO_CHANNEL_THRESHOLD_API

%include "gnuradio.i"			// the common stuff

//load generated python docstrings
%include "two_channel_threshold_swig_doc.i"

%{
#include "two_channel_threshold/two_channel_threshold_ssss.h"
%}


%include "two_channel_threshold/two_channel_threshold_ssss.h"
GR_SWIG_BLOCK_MAGIC2(two_channel_threshold, two_channel_threshold_ssss);
