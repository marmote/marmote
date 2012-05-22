#ifndef FSK_TX_H_
#define FSK_TX_H_

#include <a2fxxxm3.h>
#include <Teton_hw_platform.h>

/**
  Memory mapped structure for FSK TX
 */
typedef struct
{
  __IO uint32_t CTRL;                         /*!< Offset: 0x00  Control Register               */
  __IO uint32_t DPHA;                         /*!< Offset: 0x04  Delta-phase Register           */
  __IO uint32_t AMPL;                         /*!< Offset: 0x08  Amplitude Register             */
} FSK_TX_Type;

/**
 * FSK_TX_APB_IF_0 : Memory Map [ 0x40050000 - 0x400500FF ]
 */
#define FSK_TX            ((FSK_TX_Type *)       FSK_TX_APB_IF_0)   /*!< FSK TX register struct */

//#define FSK_TX_AMPL_MAX 0x007FUL
#define FSK_TX_AMPL_MAX 800UL // mV

/**
 * The BBFSK_TX_init() function initializes and starts the FSK TX
 * module in the FPGA fabric. *
 */
void FSK_TX_init(void);


/**
 * The FSK_TX_set_frequency() function sets the frequency of the baseband tone signal.
 *
 * @param freq
 *  The freq parameter specifies the frequency in Hz and is used to calculate the delta-phase
 *  register (DPHA) value residing in the FPGA fabric.
 *
 *  Calculation:
 *                                            freq
 *           DPHA = 2^DCO_PHASE_WIDTH x -----------------,
 *                                       g_FrequencyFPGA
 *
 *  where the DCO_PHASE_WIDTH is 32.
 */
void FSK_TX_set_frequency(uint32_t freq);



/**
 * The FSK_TX_get_frequency() function returns the frequency of the baseband tone signalin Hz.
 *
 * @param
 *  This function does not have a parameter.
 *
 *
 *  Calculation:
 *
 *           frequency = DPHA * g_FrequencyFPGA / 2^DCO_PHASE_WIDTH
 *
 *  where DPHA is an FPGA register and DCO_PHASE_WIDTH is 32.
 */
uint32_t FSK_TX_get_frequency();



/**
 * The FSK_TX_set_amplitude() function sets the amplitude of the baseband tone signal.
 *
 * @param amplitude
 *  The amplitude parameter specifies the peak-to-peak amplitude of the baseband signals
 *  in mV. The amplitude value is used to calculate and writ the AMPL register in the FPGA
 *  fabric.
 *
 *  Valid range: 0 - 400 [mV]
 *
 *  Calculation:
 *                                         amplitude
 *           AMPL = 2^AFE_BUS_WIDTH x -----------------,
 *                                         AMPL_MAX
 *
 *  where the AMPL_MAX is 400 (TBD) and AFE_BUS_WIDTH is 10.
 */
void FSK_TX_set_amplitude(uint32_t amplitude);



/**
 * The FSK_TX_get_amplitude() function returns the actual amplitude of the baseband tone signal.
 *
 * @param
 *  This function does not have a parameter.
 *
 *  Valid range: 0 - 400 [mV]
 *
 *  Calculation:
 *
 *        amplitude = AMPL * AMPL_MAX/2^AFE_BUS_WIDTH
 *
 *  where the AMPL is the FPGA register, AMPL_MAX is 400 (TBD) and AFE_BUS_WIDTH is 10.
 */
uint32_t FSK_TX_get_amplitude(void);



/**
 * The FSK_TX_enable() function enables the phase accumulator of the NCO in the FPGA,
 * generating the tone.
 *
 * @param
 *  This function does not have a parameter. *
 */
void FSK_TX_disable(void);



/**
 * The FSK_TX_disable() function stopsthe phase accumulator of the NCO in the FPGA,
 * generating the tone.
 *
 * @param
 *  This function does not have a parameter. *
 */
void FSK_TX_enable(void);



#endif // FSK_TX_H_
