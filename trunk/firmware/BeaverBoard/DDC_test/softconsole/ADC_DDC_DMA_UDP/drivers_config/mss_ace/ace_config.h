/*****************************************************************************
* (c) Copyright  Actel Corporation. All rights reserved.
*
*ACE configuration .h file
*Created by Actel MSS_ACE Configurator Tue Nov 29 10:06:06 2011
*
*/

#ifndef ACE_CONFIG_H
#define ACE_CONFIG_H


#ifdef __cplusplus
extern "C" {
#endif

/*-----------------------------------------------------------------------------
*CONFIGURATION DATA FORMAT VERSION
*---------------------------------------------------------------------------*/
#define ACE_CFG_DATA_FORMAT_VERSION     2

/*-----------------------------------------------------------------------------
*DEVICE INFORMATION
*---------------------------------------------------------------------------*/
#define SMARTFUSION_200_DEVICE          

/*-----------------------------------------------------------------------------
*COMMON VALUES
*---------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------
*AB VALUES
*---------------------------------------------------------------------------*/
#define ACE_NB_OF_ADC                   2
#define ACE_NB_OF_CURRENT_MONITORS      4
#define MAX_CHANNEL_NAME_LENGTH         5
#define ACE_NB_OF_INPUT_CHANNELS        1

/*-----------------------------------------------------------------------------
*SSE VALUES
*---------------------------------------------------------------------------*/
#define ACE_NB_OF_SSE_PROCEDURES        2
#define MAX_PROCEDURE_NAME_LENGTH       9

/*-----------------------------------------------------------------------------
*PPE VALUES
*---------------------------------------------------------------------------*/
#define ACE_NB_OF_PPE_FLAGS             0
#define MAX_FLAG_NAME_LENGTH            0

#ifdef __cplusplus
}
#endif

#endif /* ACE_CONFIG_H*/
