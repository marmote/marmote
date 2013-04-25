/* -*- c++ -*- */

#define MARMOTE_API

%include "gnuradio.i"			// the common stuff

//load generated python docstrings
%include "marmote_swig_doc.i"

%{
#include "marmote/mac_framer_b.h"
%}

// Added manually:
#include "mac_framer_b.i"

%include "marmote/mac_framer_b.h"
GR_SWIG_BLOCK_MAGIC2(marmote, mac_framer_b);
