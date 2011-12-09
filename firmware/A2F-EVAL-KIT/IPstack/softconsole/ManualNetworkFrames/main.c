// Create network frames and put it on the wire. Frames are not actually valid,
// so no real communication is done. Use wireshark to monitor packets.


// **************************************************************************
// Standard Includes */
// **************************************************************************
#include <string.h>
//#include <sys/unistd.h>

// **************************************************************************
// Firmware Includes
// **************************************************************************

#include "CMSIS/a2fxxxm3.h"

#include ".\drivers\mss_gpio\mss_gpio.h"
#include "./drivers/mss_ethernet_mac/mss_ethernet_mac.h"
#include "./drivers/mss_timer/mss_timer.h"



// **************************************************************************
// Preprocessor Macros
// **************************************************************************

// **************************************************************************
// Declaration of global variables
// **************************************************************************

const uint8_t		ethheader[]={0x00, 0x48, 0x54, 0x8D, 0xC4, 0xA9, 0x00, 0x00, 0x23, 0x10, 0x20, 0x30, 0x08, 0x00};
const uint8_t		IPheader[]={0x45, 0x00, 0x01, 0x1C, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x11, 0x00, 0x00, 0xC0, 0xA8, 0x01, 0x02, 0xC0, 0xA8, 0x01, 0x01};
//4,5 -> ID
//10,11 -> Checksum
const uint8_t		UDPheader[]={0xBF, 0xFF, 0xFB, 0x07, 0x01, 0x08, 0x00, 0x00};
//6,7 -> Checksum


#define NETIF_MAX_HWADDR_LEN 6U
#define STATIC_MACADDR0                 0x02
#define STATIC_MACADDR1                 0x00
#define STATIC_MACADDR2                 0x23
#define STATIC_MACADDR3                 0x10
#define STATIC_MACADDR4                 0x20
#define STATIC_MACADDR5                 0x30

#define BUFF_LENGTH						64


uint32_t buffer[BUFF_LENGTH];


uint32_t LED;


void low_level_init()
{
	uint8_t hwaddr[NETIF_MAX_HWADDR_LEN];
  /* set MAC hardware address length */
//  netif->hwaddr_len = ETHARP_HWADDR_LEN;

	hwaddr[0] = STATIC_MACADDR0;
	hwaddr[1] = STATIC_MACADDR1;
	hwaddr[2] = STATIC_MACADDR2;
	hwaddr[3] = STATIC_MACADDR3;
	hwaddr[4] = STATIC_MACADDR4;
	hwaddr[5] = STATIC_MACADDR5;

    volatile unsigned long ii;
	enum {WAIT_VAL=3000000ULL};

	for (ii = 0; ii<WAIT_VAL; ii++);
    MSS_GPIO_set_outputs( ~(LED | MSS_GPIO_21_MASK ) );


  /* Do whatever else is needed to initialize interface. */
//SmartFusion begin


  MSS_MAC_init(  MSS_PHY_ADDRESS_AUTO_DETECT );

	for (ii = 0; ii<WAIT_VAL; ii++);
	MSS_GPIO_set_outputs( ~(LED | MSS_GPIO_22_MASK ) );


  // Configure the MAC.
  int32_t mac_cfg;
  mac_cfg = MSS_MAC_get_configuration();

	for (ii = 0; ii<WAIT_VAL; ii++);
  MSS_GPIO_set_outputs( ~(LED | MSS_GPIO_23_MASK ) );



  mac_cfg &= ~( MSS_MAC_CFG_STORE_AND_FORWARD | MSS_MAC_CFG_PASS_BAD_FRAMES );
  mac_cfg |=
  		MSS_MAC_CFG_RECEIVE_ALL |
  		MSS_MAC_CFG_PROMISCUOUS_MODE |
  		MSS_MAC_CFG_FULL_DUPLEX_MODE |
  		MSS_MAC_CFG_TRANSMIT_THRESHOLD_MODE |
  		MSS_MAC_CFG_THRESHOLD_CONTROL_00;

	for (ii = 0; ii<WAIT_VAL; ii++);
  MSS_GPIO_set_outputs( ~(LED | MSS_GPIO_24_MASK ) );


  MSS_MAC_configure( mac_cfg );

	for (ii = 0; ii<WAIT_VAL; ii++);
MSS_GPIO_set_outputs( ~(LED | MSS_GPIO_25_MASK ) );

  MSS_MAC_set_mac_address( hwaddr );


//SmartFusion end

}


// ****************************************************************
// Entry to Main form user boot code
// ****************************************************************
int main()
{
    /*Initialize and Configure GPIO*/
    MSS_GPIO_init();
    MSS_GPIO_config( MSS_GPIO_27 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_26 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_25 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_24 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_23 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_22 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_21 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_20 , MSS_GPIO_OUTPUT_MODE );

//    while(1);

    LED = MSS_GPIO_27_MASK;
//    LED = 0;

    volatile unsigned long ii;
	enum {WAIT_VAL=3000000ULL};

    for (ii = 0; ii<WAIT_VAL; ii++);
    MSS_GPIO_set_outputs( ~(LED | MSS_GPIO_20_MASK ) );

	low_level_init();

    MSS_GPIO_set_outputs( ~(LED | MSS_GPIO_26_MASK ) );

//        	while(1)
           	{
           		uint8_t eth_pkt[sizeof(ethheader)+sizeof(IPheader)+sizeof(UDPheader)+BUFF_LENGTH*sizeof(uint32_t)];
           		uint16_t pkt_idx = 0;
           		memcpy(eth_pkt, ethheader, sizeof(ethheader));
           		pkt_idx += sizeof(ethheader);
           		memcpy(eth_pkt + pkt_idx, IPheader, sizeof(IPheader));
           		pkt_idx += sizeof(IPheader);
           		memcpy(eth_pkt + pkt_idx, UDPheader, sizeof(UDPheader));
           		pkt_idx += sizeof(UDPheader);
           		memcpy(eth_pkt + pkt_idx, buffer, BUFF_LENGTH*sizeof(uint32_t));

           	    //MSS_GPIO_set_outputs( ~MSS_GPIO_22_MASK );

           		while(1)
           		{
           			MSS_MAC_tx_packet( eth_pkt, sizeof(eth_pkt), MSS_MAC_BLOCKING);
               	    //MSS_GPIO_set_outputs( ~MSS_GPIO_23_MASK );
           		}
           	}

    return 0;
}
