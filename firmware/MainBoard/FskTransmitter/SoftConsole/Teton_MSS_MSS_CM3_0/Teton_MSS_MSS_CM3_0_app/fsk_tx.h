#ifndef FSK_TX_H_
#define FSK_TX_H_

#include <a2fxxxm3.h>
#include <Teton_hw_platform.h>
#include <mss_timer.h>
#include <mss_gpio.h>


/**
  Memory mapped structure for FSK TX
 */
typedef struct
{
  __O  uint32_t CTRL;                         /*!< Offset: 0x00  Control Register           */
  __IO uint32_t DPHA_H;                       /*!< Offset: 0x04  Delta-phase Register MSB   */
  __IO uint32_t DPHA_L;                       /*!< Offset: 0x08  Delta-phase Register LSB   */
  __I  uint32_t DUMMY;				      	  /*!< Offset: 0x0C  Placeholder up to 0x20		*/

  __IO uint32_t I;                            /*!< Offset: 0x10  I Register             	*/
  __IO uint32_t Q;                            /*!< Offset: 0x14  Q Register             	*/
  __IO uint32_t MUX;                          /*!< Offset: 0x18  Multiplexer Register       */
} FSK_TX_Type;

/**
 * FSK_TX_APB_IF_0 : Memory Map [ 0x40050000 - 0x400500FF ]
 */
#define FSK_TX            ((FSK_TX_Type *)       FSK_TX_APB_IF_0)   /*!< FSK TX register struct */

/**
 * The BBFSK_TX_init() function initializes and starts the FSK TX
 * module in the FPGA fabric.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   This function does not return a value.
 */
void FSK_TX_init (
	);

/**
 * The FSK_TX_is_busy() function reflects the state of the transmitter.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   Returns a nonzero value if a transmission is going on, otherwise returns zero.
 *
 *
 */
uint8_t FSK_TX_is_busy( void );

/**
 * The FSK_TX_send() function initiates an FSK transmission with the given
 * payload.
 *
 * @param payload
 *   The payload parameter specifies the 32-bit data to be transmitted.
 *
 * @return
 *   This function does not return a value.
 *
 */
void FSK_TX_send( uint32_t payload );


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
 * The FSK_TX_get_frequency() function returns the frequency of the baseband tone signal in Hz.
 *
 * @param
 *  This function does not have a parameter.
 *
 * @return
 *  Returns the baseband tone signal frequency in Hz.
 *
 *  Calculation:
 *
 *           frequency = DPHA * g_FrequencyFPGA / 2^DCO_PHASE_WIDTH
 *
 *  where DPHA is an FPGA register and DCO_PHASE_WIDTH is 32.
 */
uint32_t FSK_TX_get_frequency();



/**
 * The FSK_TX_enable() function enables the phase accumulator of the NCO in the FPGA,
 * generating the tone.
 *
 * @param
 *  This function does not have a parameter. *
 */
void FSK_TX_disable(void);



/**
 * The FSK_TX_disable() function stops the phase accumulator of the NCO in the FPGA,
 * generating the tone.
 *
 * @param
 *  This function does not have a parameter. *
 */
void FSK_TX_enable(void);


#endif // FSK_TX_H_
