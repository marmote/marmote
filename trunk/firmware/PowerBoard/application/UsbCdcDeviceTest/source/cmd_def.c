#include "cmd_def.h"


// List of command words and associated functions
extern CMD_Type CMD_List[] =
{
    "env",  CmdEnv,     ENV_Yellowstone | ENV_Teton,
    "help", CmdHelp,    ENV_Yellowstone,
    "led",  CmdLed,     ENV_Yellowstone,
    "pwr",  CmdPwr,     ENV_Yellowstone,
    "usb",  CmdUsb,     ENV_Yellowstone,
    "clk",  CmdClock,   ENV_Yellowstone,
    "adc",  CmdAdc,     ENV_Yellowstone,
    "t",    CmdTeton,   ENV_Yellowstone,
    
//     "chrg", CmdCharge,  ENV_Yellowstone,
    "stat", CmdStatus,  ENV_Yellowstone,
//     "bv",   CmdBatVolt, ENV_Yellowstone,
//     "ba",   CmdBatAl,   ENV_Yellowstone,
//    "mon on", CMD_MonitorOn,
//    "mon off", CMD_MonitorOff
    NULL,   NULL,       ENV_NONE,
};

extern ENV_Type ENV_List[] =
{
    {"y",   ENV_Yellowstone},
    {"t",   ENV_Teton},
    {NULL,  ENV_NONE}
};

extern ENV_Enum_Type activeEnv  = ENV_Yellowstone;



uint32_t CmdHelp(uint32_t argc, char** argv)
{    
    CMD_Type* cmdListItr = CMD_List;
    
    USB_SendString("\nAvailable commands:\n");
    
    while (cmdListItr->CmdString)
    {
        if (activeEnv & cmdListItr->CmdEnv)
        {
            USB_SendMsg("\n  ", 3);
            USB_SendString((const char*)cmdListItr->CmdString);
        }      
        cmdListItr++;
    }
    USB_SendMsg("\n", 1);
    
    return 0;
}


uint32_t CmdEnv(uint32_t argc, char** argv)
{
    const ENV_Type* envListItr = ENV_List;

    if (argc == 1)
    {
        while ( envListItr->envString )
        {
            USB_SendMsg("\n  ", 3);
            USB_SendString(envListItr->envString);
            
            if (activeEnv == envListItr->envEnum)
            {
                USB_SendString("\t(active)");
            }
            envListItr++;
        } 
        return 0;
    }

    if (argc == 2)
    {
        while ( envListItr->envString )
        {
            if (!strcmp(*(argv+1), (envListItr->envString)))
            {            
                activeEnv = envListItr->envEnum;
                return 0;
            }
            envListItr++;
        }
        USB_SendString("\nEnvironment ");
        USB_SendString(*(argv+1));
        USB_SendString(" not found");        
    }

    // Send help message
      USB_SendString("\nUsage: env [<new environment>]");
    return 1;
}


uint32_t CmdLed(uint32_t argc, char** argv)
{
    if (argc == 2)
    {
        if (!strcmp(*(argv+1), "on"))
        {            
            LED_On(LED1);
            USB_SendString("\nLED is ON");
            return 0;
        }
    
        if (!strcmp(*(argv+1), "off"))
        {            
            LED_Off(LED1);
            USB_SendString("\nLED is OFF");
            return 0;
        }
    }

    // Send help message
      USB_SendString("\nUsage: led [on | off]");
    return 1;
}

uint32_t CmdPwr(uint32_t argc, char** argv)
{    
    if (argc == 1)
    {
        if (MASTER_SWITCH_GPIO_PORT->ODR & MASTER_SWITCH_PIN)
        {
            USB_SendString("\nPower rails are ON");
            return 0;
        }
        else
        {
            USB_SendString("\nPower rails are OFF");
            return 0;
        }
    }

    if (argc == 2) {
        if (!strcmp(*(argv+1), "on"))
        {            
            //LED_On(LED2);
            POW_EnableMasterSwitch();
            USB_SendString("\nPower rails are ON");
            return 0;
        }
    
        if (!strcmp(*(argv+1), "off"))
        {            
            //LED_Off(LED2);
            POW_DisableMasterSwitch();
            USB_SendString("\nPower rails are OFF");
            return 0;
        }
    }

    // Send help message
      USB_SendString("\nUsage: pwr [on | off]");
    return 1;
}


uint32_t CmdReg(uint32_t argc, char** argv)
{        
    uint8_t addr, data;
    char msg[32];

    if (argc == 2 || argc == 3)
    {
        // Parse first paramter
        addr = atoi(*(argv+1));

        if (addr || !strcmp(*(argv+1), "0"))
        {
            // Register read (only)
            if (argc == 2)
            {
                data = CON_SPI_ReadRegister(addr);
                USB_SendString("\nreg read");

                // Print register value
                sprintf(msg, "\n%3d: %3d", addr, data);
                USB_SendString(msg);
                return 0;
            }

            // Parse second parameter
            data = atoi(*(argv+2));
            if (data || !strcmp(*(argv+2), "0"))
            {
                CON_SPI_WriteRegister(addr, data);
                USB_SendString("\nreg written");

                // Print register value
                sprintf(msg, "\n%3d: %3d (w)", addr, data);
                USB_SendString(msg);
                
                // Read back register value here
                data = CON_SPI_ReadRegister(addr);
                sprintf(msg, "\n%3d: %3d (r)", addr, data);
                USB_SendString(msg);
                return 0;
            }
        }
    }
            
    // Send help message
    USB_SendString("\nUsage: reg <addr> [<new value>]");
    return 1;
}

uint32_t CmdClock(uint32_t argc, char** argv)
{
    char buf[64];
    RCC_ClocksTypeDef RCC_Clocks;
    
    RCC_GetClocksFreq(&RCC_Clocks);
    
    USB_SendString("\nCurrent clock configuration:\n\n");
    
    sprintf(buf, "SYSCLK  %8d Hz\n", RCC_Clocks.SYSCLK_Frequency);
    USB_SendString(buf);

    sprintf(buf, "HCLK    %8d Hz\n", RCC_Clocks.HCLK_Frequency);
    USB_SendString(buf);

    sprintf(buf, "PCLK1   %8d Hz\n", RCC_Clocks.PCLK1_Frequency);
    USB_SendString(buf);

    sprintf(buf, "PCLK2   %8d Hz\n", RCC_Clocks.PCLK2_Frequency);
    USB_SendString(buf);

    sprintf(buf, "ADCCLK  %8d Hz\n", RCC_Clocks.ADCCLK_Frequency);
    USB_SendString(buf);  

    return 0;
}


uint32_t CmdAdc(uint32_t argc, char** argv)
{    
    char buf[64];

    /*
    sprintf(buf, "\nV_sup:  %4d mV", MON_ReadAdc(ADC_CH_V_SUP));
    USB_SendString(buf);
    */

    sprintf(buf, "\nSUP:  %4d mA", MON_ReadAdc(ADC_CH_I_SUP));
    USB_SendString(buf);

    sprintf(buf, " \t%4d mV", MON_ReadAdc(ADC_CH_V_SUP));
    USB_SendString(buf);

    sprintf(buf, "\nD3V3: %4d mA", MON_ReadAdc(ADC_CH_I_D3V3));
    USB_SendString(buf);

    sprintf(buf, "\nA3V3: %4d mA", MON_ReadAdc(ADC_CH_I_A3V3));
    USB_SendString(buf);

    sprintf(buf, "\nD1V5: %4d mA", MON_ReadAdc(ADC_CH_I_D1V5));
    USB_SendString(buf);

    sprintf(buf, "\nA1V5: %4d mA", MON_ReadAdc(ADC_CH_I_A1V5));
    USB_SendString(buf);

    return 0;
}


uint32_t CmdTeton(uint32_t argc, char** argv)
{    
    char buf[128];
    uint8_t len;
    uint8_t i;

    if ( argc > 1 )
    {
        // FIXME: no length check
        strcpy(buf, *(argv+1));
        strcat(buf, " ");
        for ( i = 2 ; i < argc ; i++ )
        {
            strcat(buf, *(argv+i));
            strcat(buf, " ");
        }
        // Replace last space with '\n'
        len = strlen(buf);
        buf[len-1] = '\n';

        CON_SPI_Write( (const uint8_t*)buf, len );
        return 0;
    }

    // Send help message
      USB_SendString("\nUsage: t <msg to forward>");
    return 1;
}


uint32_t CmdStatus(uint32_t argc, char** argv)
{
    char buf[32];
    uint32_t reg;

    if (argc == 1)
    {
        USB_SendString("\nBattery voltage: ");
        reg = BAT_ReadRegister(BAT_VOLTAGE_MSB);
        sprintf(buf, " %.2f mV ", 6.0*reg/65535);
        USB_SendString(buf);
        sprintf(buf, " (0x%04X)", reg);
        USB_SendString(buf);
        
        USB_SendString("\nBattery alarm:   ");
        reg = BAT_ReadRegister(BAT_VOLTAGE_THRESHOLD_LOW) << 8;
        sprintf(buf, " %.2f mV ", 6.0*reg/65535);
        USB_SendString(buf);
        sprintf(buf, " (0x%04X)", reg);
        USB_SendString(buf);

        USB_SendString("\nCharger:          ");
        if (BAT_IsCharging())
        {
            USB_SendString("ON");
        }
        else
        {
            USB_SendString("OFF");
        }
        
        USB_SendString("\nUSB power:        ");
        if (USB_SUSP_GPIO_PORT->IDR & USB_SUSP_PIN)
        {
            USB_SendString("OFF");
        }
        else
        {
            USB_SendString("ON");
        }

        return 0;
    }

    // Send help message
    USB_SendString("\nUsage: stat");
    return 1;
}

uint32_t CmdUsb(uint32_t argc, char** argv)
{
    if (argc == 1)
    {
        USB_SendString("\nUSB power is ");
        if (USB_SUSP_GPIO_PORT->IDR & USB_SUSP_PIN)
        {
            USB_SendString("OFF");
        }
        else
        {
            USB_SendString("ON");
        }
        return 0;
    }

    if (argc == 2) {
        if (!strcmp(*(argv+1), "on"))
        {
            USB_DisableSuspendMode();
            USB_SendString("\nUSB power is ON");
            return 0;
        }
        if (!strcmp(*(argv+1), "off"))
        {
            USB_EnableSuspendMode();
            USB_SendString("\nUSB power is OFF");
            return 0;
        }
    }

    // Send help message
    USB_SendString("\nUsage: usb [on | off]");
    return 1;
}
