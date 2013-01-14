//-----------------------------------------------------------------------------
// Title         : Max2830 firmware header
// Project       : Marmote SDR
//-----------------------------------------------------------------------------
// File          : max2830.h
// Author        : Benjamin Babjak and Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2012-05-29 10:13
// Last update   : 2011-05-31 09:15
// Platform      : Marmote
// Target device : Actel A2F500M3G
// Tool version  : CoreConsole v3.3
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : Firmware for the Max2830 RF transceiver chip found on the
//                 Marmote Joshua module.
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
// 2012-05-31      1.1      Sandor Szilvasi
// 2012-05-29      1.0      Benjamin Babjak	Created
//-----------------------------------------------------------------------------



#ifndef MAX2830_H_
#define MAX2830_H_

#include <a2fxxxm3.h>
#include <mss_gpio.h>
#include <mss_spi.h>
#include <mss_ace.h>

#define MSS_GPIO_SHDN       	MSS_GPIO_3		// Shutdown (active-low)
#define MSS_GPIO_RXHP       	MSS_GPIO_4		// Receiver Baseband AC-Coupling High-Pass Corner Frequency
#define MSS_GPIO_ANTSEL     	MSS_GPIO_5		// Antenna Selection
#define MSS_GPIO_LD         	MSS_GPIO_6		// Lock-Detect
#define MSS_GPIO_RXTX       	MSS_GPIO_28		// Rx/Tx Mode (Rx = 0, Tx = 1)

#define MSS_GPIO_SHDN_MASK      MSS_GPIO_3_MASK
#define MSS_GPIO_RXHP_MASK      MSS_GPIO_4_MASK
#define MSS_GPIO_ANTSEL_MASK    MSS_GPIO_5_MASK
#define MSS_GPIO_LD_MASK		MSS_GPIO_6_MASK
#define MSS_GPIO_RXTX_MASK      MSS_GPIO_28_MASK

#define LO_FREQUENCY			20000000uL		// Frequency of the TCXO on the Joshua board


static const uint16_t max2830_tx_lpf_bws[] =
{
		 7200u,  7600u,	 8000u,	 8400u,	 8800u,	 9200u, //  8.0 MHz
		 9900u,	10450u,	11000u,	11550u,	12100u,	12650u, // 11.0 MHz
		14850u,	15675u,	16500u,	17325u,	18150u,	18975u, // 16.5 MHz
		20250u,	21375u,	22500u,	23625u,	24750u,	25875u, // 22.5 MHz
};

static const uint16_t max2830_rx_lpf_bws[] =
{
	    6750u,	 7125u,  7500u,	 7875u,	 8250u, //  7.5 MHz
	    7650u,	 8075u,  8500u,	 8925u,	 9350u, //  8.5 MHz
	   13500u,	14250u, 15000u,	15750u,	16500u, // 15.0 MHz
	   16200u,	17100u, 18000u,	18900u,	19800u, // 18.0 MHz
};

typedef enum __Max2830_mode_t
{
	MAX2830_SHUTDOWN_MODE	= 0,
	MAX2830_STANDBY_MODE	= 1,
	MAX2830_RX_MODE			= 2,
	MAX2830_TX_MODE 		= 3,
	MAX2830_RX_CALIBRATION_MODE = 4,
	MAX2830_TX_CALIBRATION_MODE = 5
} Max2830_operating_mode_t;

typedef enum __Max2830_Analog_Meas_t
{
	MAX2830_ANALOG_MEAS_RSSI	= 0,
	MAX2830_ANALOG_MEAS_TEMP	= 1,
	MAX2830_ANALOG_MEAS_TXPOW	= 2
} Max2830_Analog_Meas_t;


/**
 * The number of bits in a MAX2830 SPI transaction.
 */
#define SPI_FRAME_SIZE_MAX2830 18

/**
 * Array representing the 14-bit values of the 16 MAX2830 registers.
 *
 * Note: As MAX2830 does not support register read the value of its
 *       registers is kept in this array as a reference. Register reads
 *       return values kept in the max2830_regs array.
 */
static uint16_t max2830_regs[16] =
{
		0x1740,
		0x119A,
		0x1003,
		0x0079,
		0x3666,
		0x00A0,
		0x0060,
		0x0022,
		0x3021,
		0x07B5,
		0x1DA4,
		0x005F,
		0x0140,
		0x0E92,
		0x0300,
		0x0145,
};

/*
static uint16_t max2830_regs[16] =
{
		0x1740,
		0x119A,
		0x1003,
		0x0079,
		0x3666,
		0x00A0, // R5 (for 20 MHz TCXO)
		//0x00A4, // R5 Divide reference frequency by 2 (for 40 MHz XTAL)
		0x0060,
		0x1022,
		0x3021,
		0x07B5,
		0x1DA4,
		0x007F,
		0x0140,
		0x0E92,
		0x0300, // R14
		0x0145,
};
*/

ace_channel_handle_t rssi_handle;


/**
 * The Max2830_init() function initializes the Max2830 RF transceiver chip.
 * It sets the GPIO pins that control the MAX2830 chip and configures it through
 * the SPI bus.
 *
 * Note: - The Max2830_init() function assumes that MSS_GPIO_init() has been
 *         called previously.
 *       - Make sure that the GPIO #defines match the Libero design FPGA I/O pins.
 *       - The Joshua board is initialized with minimal transmit gain.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_init ( void );




/**
 * The Max2830_read_register() function returns the actual content of a MAX2830 register.
 * Note: - The MAX2830 chip does not support SPI read, thus this function returns a locally
 *         stored value, e.g. no actual SPI transaction takes place.
 *
 * @param addr
 *   The address of the MAX2830 register. The valid address range is from 0 to 15.
 *
 * @return
 *   This function returns the value of the MAX2830 register at the address
 *   defined by the parameter addr.
 */
uint16_t Max2830_read_register( uint8_t addr );



/**
 * The Max2830_write_register() function writes a MAX2830 register through the SPI
 * port and updates the local copy of the register value.
 *
 * @param addr
 *   The address of the MAX2830 register. The valid address range is from 0 to 15.
 *
 * @param data
 *   The value to write to the MAX2830 register at address defined by addr.
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_write_register( uint8_t addr, uint16_t data );




/**
 * The Max2830_calibrate() function calibrates the [RX/TX?] path. // TODO
 *
 * Note: Tx calibration involves sine generation in the baseband and this
 *       feature is NOT IMPLMENTED YET.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   This function does not return a value.
 */
//void Max2830_calibrate( void );



/**
 * The Max2830_get_frequency() function reads the local oscillator frequency
 * and returns it in Hz.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The local oscillator frequency in Hz.
 */
uint32_t Max2830_get_frequency( void );

/**
 * The Max2830_set_frequency() function sets the local oscillator frequency to
 * the value specified in the parameter.
 *
 * Note: The frequency step resolution is 20 Hz.
 *
 * @param freq
 *   The requested local oscillator frequency in Hz.
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_frequency( uint32_t freq );


/**
 * The Max2830_get_tx_gain() function reads the actual transmit gain and returns it in dB.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The transmit gain in dB.
 */
float Max2830_get_tx_gain( void );


/**
 * The Max2830_set_tx_gain() function sets the transmitter VGA gain to the dB
 * value specified in the parameter.
 *
 * Note: Bit 10 in Max2830 register 9 is assumed to be set 1 to enable
 *       programming through the 3-wire serial interface.
 *
 * @param gain
 *   The requested transmit gain in dB. The valid gain range is from 0 to 31 dB.
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_tx_gain( float gain );


/**
 * The Max2830_get_tx_bandwidth() function reads the transmit baseband
 * filter cut-off frequency and returns it in kHz.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The transmit baseband filter cut-off frequency in kHz.
 */
uint32_t Max2830_get_tx_bandwidth( void );


/**
 * The Max2830_set_tx_bandwidth() function sets the transmit baseband low-pass
 * filter cut-off frequency to the value specified in the parameter.
 *
 * Note: The transmit bandwidth of the baseband filter can be set in coarse
 *       steps. Thus, the actually set frequency may differ from the requested.
 *       Use the Max2830_get_tx_bandwidth() function to determine the actual
 *       value set.
 *
 * @param
 *   The requested transmit baseband low-pass filter cut-off frequency in Hz.
 *
 *   Valid range: TBD
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_tx_bandwidth( uint32_t bandwidth );


/**
 * The Max2830_get_rx_lna_gain() function reads the actual receive LNA path
 * gain and returns it in dB.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The receive path LNA gain in dB.
 */
float Max2830_get_rx_lna_gain( void );


/**
 * The Max2830_set_rx_lna_gain() function sets the receive path LNA gain to the
 * dB value specified in the parameter.
 *
 * @param gain
 *   The requested receive path LNA gain in dB. The valid gain range is from 0
 *   to 62 dB with 2 dB resolution.
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_rx_lna_gain( float gain );

/**
 * The Max2830_get_rx_vga_gain() function reads the actual receive path VGA
 * gain and returns it in dB.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The receive path VGA gain in dB.
 */
float Max2830_get_rx_vga_gain( void );


/**
 * The Max2830_set_rx_vga_gain() function sets the receiver VGA gains to the
 * dB value specified in the parameter.
 *
 * @param gain
 *   The requested receive path VGA gain in dB. The valid gain range is from
 *   0 to 62 dB.
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_rx_vga_gain( float gain );



/**
 * The Max2830_get_rx_gain() function reads the actual total receive gain and
 * returns it in dB.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The total receive path gain in dB.
 */
float Max2830_get_rx_gain( void );


/**
 * The Max2830_set_rx_gain() function sets the receiver VGA gains to the total
 * dB value specified in the parameter.
 *
 * @param gain
 *   The requested total receive path gain in dB. The valid gain range is from
 *   0 to 95 dB.
 *
 *   The total receive gain control range provided by the MAX2830 is 0 to 95 dB,
 *   where the available LNA gain values are 0 dB, 17 dB (default) and 33 dB and
 *   the available baseband VGA gain steps are from 0 to 62 dB in 2 dB steps.
 *
 *   If the requested gain value can be set by adjusting only the VGA gain,
 *   then the LNA gain is not changed. Otherwise the LNA gain is also adjusted.
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_rx_gain( float gain );


/**
 * The Max2830_get_rx_bandwidth() function reads the low-pass receive
 * baseband filter cut-off frequency and returns it in kHz.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The receive baseband filter cut-off frequency in kHz.
 */
uint32_t Max2830_get_rx_bandwidth( void );


/**
 * The Max2830_set_rx_bandwidth() function sets the low-pass receive baseband
 * low-pass filter cut-off frequency to the value specified in the parameter.
 *
 * Note: The receive bandwidth of the baseband filter can be set in coarse
 *       steps. Thus, the actually set frequency may differ from the requested.
 *       Use the Max2830_get_tx_bandwidth() function to determine the actual
 *       value set.
 *
 *       The receive path incorporates a high-pass filter with cut-off frequency
 *       programmable to 100 Hz, 4 kHz, 30 kHz and 600 kHz. This value is fixed
 *       at 100 Hz by default.
 *
 * @param
 *   The requested receive baseband low-pass filter cut-off frequency in Hz.
 *
 *   Valid range: TBD
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_rx_bandwidth( uint32_t bandwidth );


/**
 * The Max2830_get_mode() returns the actual operating mode of the MAX2830.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The actual state of the MAX2830 transceiver.
 *
 *   Valid values:
 *
 *  	- MAX2830_SHUTDOWN_MODE
 *  	- MAX2830_STANDBY_MODE
 *  	- MAX2830_RX_MODE
 *  	- MAX2830_TX_MODE
 *  	- MAX2830_RX_CALIBRATION_MODE
 *  	- MAX2830_TX_CALIBRATION_MODE
 */
Max2830_operating_mode_t Max2830_get_mode( void );


/**
 * The Max2830_set_mode() function sets the operating mode of the MAX2830
 * to the value specified in the parameter.
 *
 * Note: The state of this pin selects not only between Rx and Tx modes, but
 * 		 also between Shutdown and Standby, and Rx Calibration and Tx
 *       Calibration.
 *
 * @param
 *   The requested state of the MAX2830 transceiver.
 *
 *   Valid values:
 *
 *  	- MAX2830_SHUTDOWN_MODE
 *  	- MAX2830_STANDBY_MODE
 *  	- MAX2830_RX_MODE
 *  	- MAX2830_TX_MODE
 *  	- MAX2830_RX_CALIBRATION_MODE
 *  	- MAX2830_TX_CALIBRATION_MODE
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_mode( Max2830_operating_mode_t mode );


/**
 * The Max2830_get_rssi_output() function returns the selection of the analog
 * source connected to the RSSI output pin.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The name of the requested analog signal.
 *
 *   Valid values:
 *
 *	   - MAX2830_ANALOG_MEAS_RSSI
 *	   - MAX2830_ANALOG_MEAS_TEMP
 *	   - MAX2830_ANALOG_MEAS_TXPOW
 */
Max2830_Analog_Meas_t Max2830_get_rssi_config( void );

/**
 * The Max2830_set_rssi_output() function selects the analog source connected
 * to the RSSI output pin.
 *
 * @param
 *   The requested analog signal.
 *
 *   Valid values:
 *
 *	   - MAX2830_ANALOG_MEAS_RSSI
 *	   - MAX2830_ANALOG_MEAS_TEMP
 *	   - MAX2830_ANALOG_MEAS_TXPOW
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_rssi_config( Max2830_Analog_Meas_t	value );

// TODO: add description
uint16_t Max2830_get_rssi_value( void );


/**
 * The Max2830_get_pa_delay() function returns the delay set between RXTX
 * low-to-high transition and internal PA enable.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The delay between RXTX rise and internal PA enable in us.
 */
uint8_t Max2830_get_pa_delay( void );

/**
 * The Max2830_set_pa_delay() function sets a delay between RXTX low-to-high
 * transition and internal PA enable.
 *
 * @param
 *   The requested delay in 1 us steps. The valid range is from 0 to 7.
 *
 * @return
 *   This function does not return a value.
 */
void Max2830_set_pa_delay( uint8_t delay_us );

#endif /* MAX2830_H_ */
