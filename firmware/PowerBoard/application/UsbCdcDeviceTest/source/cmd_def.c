#include "cmd_def.h"
#include "usb_fs.h"

uint8_t LedOn(void)
{
	LED_On(LED2);
	return 0;
}

uint8_t LedOff(void)
{
	LED_Off(LED2);
	return 0;
}

uint8_t PrintHelpMsg(void)
{
    USB_SendMsg("\nhelp mess\n", 11);
    return 0;
}

uint8_t CMD_PowerOn(void)
{
	LED_On(LED2);
	return 0;
}

uint8_t CMD_PowerOff(void)
{
	LED_Off(LED2);
	return 0;
}


