/* -*- c++ -*- */

#define MARMOTE_API

%include "gnuradio.i"			// the common stuff

//load generated python docstrings
%include "marmote_swig_doc.i"

%{
#include "marmote/mac_framer_b.h"
#include "marmote/gmsk_packet_sink_b.h"
#include "marmote/mac_deframer.h"
#include "marmote/traffic_generator.h"
#include "marmote/ds_spreader_bb.h"
%}


%include "marmote/mac_framer_b.h"
GR_SWIG_BLOCK_MAGIC2(marmote, mac_framer_b);
%include "marmote/gmsk_packet_sink_b.h"
GR_SWIG_BLOCK_MAGIC2(marmote, gmsk_packet_sink_b);
%include "marmote/mac_deframer.h"
GR_SWIG_BLOCK_MAGIC2(marmote, mac_deframer);
%include "marmote/traffic_generator.h"
GR_SWIG_BLOCK_MAGIC2(marmote, traffic_generator);

%include "marmote/ds_spreader_bb.h"
GR_SWIG_BLOCK_MAGIC2(marmote, ds_spreader_bb);
