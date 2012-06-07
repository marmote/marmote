################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../arch/sys_arch.c 

OBJS += \
./arch/sys_arch.o 

C_DEPS += \
./arch/sys_arch.d 


# Each subdirectory must supply rules for building sources it contributes
arch/%.o: ../arch/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_ethernet_mac -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -I"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app" -I"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include" -I"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include\ipv4" -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -v -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


