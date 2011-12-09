/*****************************************************************************
* (c) Copyright  Actel Corporation. All rights reserved.
*
*ACE configuration .c file
*Created by Actel MSS_ACE Configurator Tue Nov 29 10:06:06 2011
*
*/

#include "../../drivers/mss_ace/mss_ace_configurator.h"
#include "ace_config.h"
#include "ace_handles.h"

#include <stdint.h>


#ifdef __cplusplus
extern "C" {
#endif

/*-----------------------------------------------------------------------------
*AB Configuration
*---------------------------------------------------------------------------*/
ace_adc_config_t g_ace_adc_config[ACE_NB_OF_ADC] = 
{
	{
        1024,                      /* uint16_t adc_resolution */
        2560                       /* uint16_t va_ref */
	},
	{
        1024,                      /* uint16_t adc_resolution */
        2560                       /* uint16_t va_ref */
	}
};

/*-----------------------------------------------------------------------------
*Current Monitor External Resistor Value ( milli-ohms )
*---------------------------------------------------------------------------*/
const uint16_t g_ace_current_resistors[ACE_NB_OF_CURRENT_MONITORS] = 
{
	1,	/*CM0 ( NOT USED AS CURRENT MONITOR ) */
	1,	/*CM1 ( NOT USED AS CURRENT MONITOR ) */
	1,	/*CM2 ( NOT USED AS CURRENT MONITOR ) */
	1	/*CM3 ( NOT USED AS CURRENT MONITOR ) */
};

/*-----------------------------------------------------------------------------
*External VAREF usage
*---------------------------------------------------------------------------*/
const uint8_t g_ace_external_varef_used[ACE_NB_OF_ADC] = 
{
	0,
	0
};

/*-----------------------------------------------------------------------------
*Analog Channels
*---------------------------------------------------------------------------*/
/* Names*/
const uint8_t g_ace_channel_0_name[] = "SDD_0";

/* Number of Flags per Channel*/
#define CHANNEL_0_NB_OF_FLAGS           0

/* Input Channel to Flag Array Association*/

/* Channel Table*/
ace_channel_desc_t g_ace_channel_desc_table[ACE_NB_OF_INPUT_CHANNELS] = 
{
	{
        g_ace_channel_0_name,      /* const uint8_t * p_sz_channel_name */
        SDD1_IN,                   /* adc_channel_id_t signal_id; */
        0,                         /* uint16_t signal_ppe_offset */
        CHANNEL_0_NB_OF_FLAGS,     /* uint16_t nb_of_flags */
        0                          /* uint16_t * p_flags_array */
	}
};

/*-----------------------------------------------------------------------------
*Threshold Flags
*---------------------------------------------------------------------------*/
/* Flag Names*/
/* Flag Table*/


/*-----------------------------------------------------------------------------
*PPE Linear Transforms
*---------------------------------------------------------------------------*/
const ppe_transforms_desc_t g_ace_ppe_transforms_desc_table[ACE_NB_OF_INPUT_CHANNELS] = 
{
	{
        15,                        /* uint16_t    m_ppe_offset */
        16,                        /* uint16_t    c_ppe_offset */
        0x4000,                    /* int16_t     default_m2 */
        0x0000                     /* int16_t     default_c2 */
	}
};

/*-----------------------------------------------------------------------------
*Sequencer Procedures
*---------------------------------------------------------------------------*/
/* Procedure Name and Microcode*/
const uint8_t g_ace_sse_proc_0_name[] = "ADC0_MAIN";
const uint16_t g_ace_sse_proc_0_sequence[] = 
{
	0x1704, 0x1602, 0x1200 
};

const uint8_t g_ace_sse_proc_1_name[] = "ADC1_MAIN";
const uint16_t g_ace_sse_proc_1_sequence[] = 
{
	0x2704, 0x2602, 0x282a, 0x2200 
};



/* Procedure Table*/
ace_procedure_desc_t g_sse_sequences_desc_table[ACE_NB_OF_SSE_PROCEDURES] = 
{
	{
        g_ace_sse_proc_0_name,                              /* const uint8_t * p_sz_proc_name */
        2,                                                  /* uint16_t sse_loop_pc */
        0,                                                  /* uint16_t sse_load_offset */
        sizeof(g_ace_sse_proc_0_sequence) / sizeof(uint16_t), /* uint16_t sse_ucode_length */
        g_ace_sse_proc_0_sequence,                          /* const uint16_t * sse_ucode */
        0                                                   /* uint8_t sse_pc_id */
	},
	{
        g_ace_sse_proc_1_name,                              /* const uint8_t * p_sz_proc_name */
        6,                                                  /* uint16_t sse_loop_pc */
        3,                                                  /* uint16_t sse_load_offset */
        sizeof(g_ace_sse_proc_1_sequence) / sizeof(uint16_t), /* uint16_t sse_ucode_length */
        g_ace_sse_proc_1_sequence,                          /* const uint16_t * sse_ucode */
        1                                                   /* uint8_t sse_pc_id */
	}
};


#ifdef __cplusplus
}
#endif

