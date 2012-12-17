/* -*- c++ -*- */

#define FRAME_SOURCE_API

%include "gnuradio.i"			// the common stuff

//load generated python docstrings
%include "frame_source_swig_doc.i"

%{
#include "frame_source/frame_source_ss.h"
%}


%include "frame_source/frame_source_ss.h"
GR_SWIG_BLOCK_MAGIC2(frame_source, frame_source_ss);
