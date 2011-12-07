#include "stm32f10x_conf.h"
#include "stm32f10x.h"

#include "power_board.h"


volatile uint32_t msTicks;                       /* timeTicks counter */

void SysTick_Handler(void) {
	msTicks++;                                     /* increment timeTicks counter */
}

static void Delay (uint32_t dlyTicks) {
	uint32_t curTicks = msTicks;

	while ((msTicks - curTicks) < dlyTicks);
}

		   				
uint16_t temp;
uint16_t volt;
uint16_t ctrl;

int main (void) {

	uint16_t ctr;	

	LED_Init();			
	PowerControl_Init();
	USB_EnableSuspendMode();
	CON_SPI_Init();
	CON_I2C_Init();

	SD_SPI_Init();
	BAT_I2C_Init();

#ifdef CON_GPIO_TEST
	CON_GPIO_Init();
#endif

	SysTick->CTRL |= (SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk);
	SysTick->LOAD = 72000;	
					
	ctr = 0;	
	LED_On(LED1);
	LED_Off(LED2);

	while (1)
	{
		//LED_Toggle(LED2);
		//Delay(250);		
		//Delay(1000);	
		//LED_On(LED2);	
		
//#ifdef POWER_CONTROL_TEST
		//USB_EnableSuspendMode();
		//USB_DisableSuspendMode();

		//USB_EnableHighPowerMode();
		//USB_DisableHighPowerMode();

		/*
		if (WALL_IsPowerGood())
		{
			LED_On(LED1);
			LED_Off(LED2);	
		}
		else
		{
			LED_Off(LED1);
			LED_On(LED2);	
		}
		*/
//#endif

//	POW_EnableMasterSwitch();
//	POW_DisableMasterSwitch();

//#ifdef SPI1_TEST
		//CON_SPI_SendData(ctr++);
		
		/*if
		{
			LED_On(LED2);	
			Delay(100);
		}
		*/
//#endif

//#ifdef I2C1_TEST
		//CON_I2C_SendData(ctr++,0);
//#endif

//#ifdef SPI2_TEST
//		SD_SPI_SendData(ctr++);
		//Delay(1000);		
//#endif


//#ifdef I2C2_TEST

		/*
		for ( ctr = 0 ; ctr <= 0x0F ; ctr++ )
		{
			temp = BAT_ReadRegister(ctr);
		}
		*/

				/*
		// Read temperature
		temp = 0;
		temp = BAT_ReadRegister(0x0C) << 8; // MSB
		temp |= BAT_ReadRegister(0x0D); // LSB
		
		// Read voltage
		temp = 0;
		temp = BAT_ReadRegister(0x08) << 8; // MSB
		temp |= BAT_ReadRegister(0x09); // LSB
		*/

		//Delay(50);

		BAT_WriteRegister(BAT_CONTROL, 0xC0);

		//BAT_WriteRegister(BAT_CHARGE_THRESHOLD_HIGH_MSB, 0xF0F6);
		//temp = BAT_ReadRegister(BAT_CHARGE_THRESHOLD_HIGH_MSB);
		//temp = BAT_ReadRegister(BAT_TEMPERATURE_MSB);
		//volt = BAT_ReadRegister(BAT_VOLTAGE_MSB);

		//Delay(500);

		//BAT_ReadRegister(2);
		ctr = 0xF5F5;
		while (1)
		{
			//BAT_WriteRegister(0x01, (0x01 << 6));   // Temperature
			//BAT_WriteRegister(0x01, (0x02 << 6));   // Voltage
			//BAT_WriteRegister(0x01, (0x0C << 6));   // Voltage
			//ctrl = BAT_ReadRegister(0x01);   // Control
			LED_Toggle(LED1);
			temp = BAT_ReadRegister(BAT_TEMPERATURE_MSB);
			volt = BAT_ReadRegister(BAT_VOLTAGE_MSB);

			//BAT_WriteRegister(BAT_CHARGE_THRESHOLD_HIGH_MSB, ctr++);
			//temp = BAT_ReadRegister(BAT_CHARGE_THRESHOLD_HIGH_MSB);

			//Delay(10);
		}

		for ( ctr = 0 ; ctr < 10 ; ctr++ )
		{		
			LED_On(LED2);
			BAT_ReadRegister(01);
			while (1);
			Delay(1000);
			//LED_Off(LED2);	
		}
		
		//LED_Off(LED1);	

		USB_EnableSuspendMode(); // Reset when powered from USB

		//BAT_ReadRegister(00);
		//LED_Off(LED2);
		//while (1);
        /*
        GPIO_ResetBits(BAT_I2C_SCL_GPIO_PORT, BAT_I2C_SCL_PIN);
        GPIO_SetBits(BAT_I2C_SCL_GPIO_PORT, BAT_I2C_SCL_PIN);

        GPIO_ResetBits(BAT_I2C_SDA_GPIO_PORT, BAT_I2C_SDA_PIN);
        GPIO_SetBits(BAT_I2C_SDA_GPIO_PORT, BAT_I2C_SDA_PIN);
        */
//#endif

#ifdef CON_GPIO_TEST
		CON_GPIO_Set(CON_GPIO0 | CON_GPIO1 | CON_GPIO2 | CON_GPIO3 | CON_GPIO4);
		Delay(500);
		CON_GPIO_Clear(CON_GPIO0 | CON_GPIO1 | CON_GPIO2 | CON_GPIO3 | CON_GPIO4);
		Delay(500);
#endif
	}
}

