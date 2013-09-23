//-----------------------------------------------------------------------------
// Title         : Joshua board source
// Project       : Marmote Teton (Main Board)
//-----------------------------------------------------------------------------
// File          : joshua.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-02 20:13
// Last update   : 2011-11-02 20:15
// Platform      : Marmote
// Target device : Actel A2F500M3G
// Tool version  : CoreConsole v3.3
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : <+description+>
//-----------------------------------------------------------------------------
// Copyright (c) 2006-2012, Vanderbilt University
// All rights reserved.
//
// Permission to use, copy, modify, and distribute this software and its
// documentation for any purpose, without fee, and without written agreement is
// hereby granted, provided that the above copyright notice, the following
// two paragraphs and the author appear in all copies of this software.
//
// IN NO EVENT SHALL THE VANDERBILT UNIVERSITY BE LIABLE TO ANY PARTY FOR
// DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
// OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE VANDERBILT
// UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// THE VANDERBILT UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
// AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
// ON AN "AS IS" BASIS, AND THE VANDERBILT UNIVERSITY HAS NO OBLIGATION TO
// PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
//-----------------------------------------------------------------------------
// Revisions     :
// Date            Version  Author			Description
// 2012-05-23      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#include "joshua.h"

uint8_t Joshua_init ( )
{
	// TODO: Initialize EEPROM

	// TODO: Query board ID and version
	// TODO: signal error and return if the ID read does not belong to Joshua

	// Initialize MAX2830 transceiver

	Max2830_init();

	return 0;
}

