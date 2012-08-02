/*
 * cmd_def.c
 *
 *  Created on: Aug 2, 2012
 *      Author: sszilvasi
 */

#include "cmd_def.h"


CMD_Type CMD_List[] =
{
	"help", CmdHelp,
	"led",  CmdLed,
	NULL,   NULL
};


uint32_t CmdHelp(uint32_t argc, char** argv)
{
	CMD_Type* cmdListItr = CMD_List;

	Yellowstone_print("\nAvailable commands:\n");

	while (cmdListItr->CmdString)
	{
		Yellowstone_write("\n  ", 3);
		Yellowstone_print((const char*)cmdListItr->CmdString);
		cmdListItr++;
	}
	Yellowstone_write("\n", 1);

	return 0;
}

uint32_t CmdLed(uint32_t argc, char** argv)
{
	// Toggle LED
	/*
	if ( MSS_GPIO_get_outputs() & MSS_GPIO_0_MASK )
	{
		MSS_GPIO_set_output( MSS_GPIO_0, 0 );
	}
	else
	{
		MSS_GPIO_set_output( MSS_GPIO_0, 1 );
	}
	*/

	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_output( MSS_GPIO_0, 1 );
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_output( MSS_GPIO_0, 0 );
			return 0;
		}
	}

	// Send help message
  	Yellowstone_print("\nUsage: t led [on | off]");
	return 1;
}
