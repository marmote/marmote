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
#include "marmote/cdma_packet_source.h"
#include "marmote/cdma_packet_sink.h"
#include "marmote/pn_spreader_f.h"
#include "marmote/pn_synchronizer.h"
#include "marmote/pn_despreader.h"
#include "marmote/cdma_packet_framer.h"
#include "marmote/pn_spreader_b.h"
#include "marmote/pn_despreader_cc.h"
#include "marmote/pn_synchronizer_cc.h"
#include "marmote/gmsk_packet_framer_b.h"
#include "marmote/pn_matched_filter.h"
%}


%include "marmote/mac_framer_b.h"
GR_SWIG_BLOCK_MAGIC2(marmote, mac_framer_b);
%include "marmote/gmsk_packet_sink_b.h"
GR_SWIG_BLOCK_MAGIC2(marmote, gmsk_packet_sink_b);
%include "marmote/mac_deframer.h"
GR_SWIG_BLOCK_MAGIC2(marmote, mac_deframer);
%include "marmote/traffic_generator.h"
GR_SWIG_BLOCK_MAGIC2(marmote, traffic_generator);

%include "marmote/cdma_packet_source.h"
GR_SWIG_BLOCK_MAGIC2(marmote, cdma_packet_source);
%include "marmote/cdma_packet_sink.h"
GR_SWIG_BLOCK_MAGIC2(marmote, cdma_packet_sink);
%include "marmote/pn_spreader_f.h"
GR_SWIG_BLOCK_MAGIC2(marmote, pn_spreader_f);
%include "marmote/pn_synchronizer.h"
GR_SWIG_BLOCK_MAGIC2(marmote, pn_synchronizer);
%include "marmote/pn_despreader.h"
GR_SWIG_BLOCK_MAGIC2(marmote, pn_despreader);
%include "marmote/cdma_packet_framer.h"
GR_SWIG_BLOCK_MAGIC2(marmote, cdma_packet_framer);
%include "marmote/pn_spreader_b.h"
GR_SWIG_BLOCK_MAGIC2(marmote, pn_spreader_b);
%include "marmote/pn_despreader_cc.h"
GR_SWIG_BLOCK_MAGIC2(marmote, pn_despreader_cc);
%include "marmote/pn_synchronizer_cc.h"
GR_SWIG_BLOCK_MAGIC2(marmote, pn_synchronizer_cc);
%include "marmote/gmsk_packet_framer_b.h"
GR_SWIG_BLOCK_MAGIC2(marmote, gmsk_packet_framer_b);


%include "marmote/pn_matched_filter.h"
GR_SWIG_BLOCK_MAGIC2(marmote, pn_matched_filter);
