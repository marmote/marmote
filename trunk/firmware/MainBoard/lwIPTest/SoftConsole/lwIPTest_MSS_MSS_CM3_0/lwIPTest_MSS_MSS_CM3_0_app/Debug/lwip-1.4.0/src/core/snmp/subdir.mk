################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lwip-1.4.0/src/core/snmp/asn1_dec.c \
../lwip-1.4.0/src/core/snmp/asn1_enc.c \
../lwip-1.4.0/src/core/snmp/mib2.c \
../lwip-1.4.0/src/core/snmp/mib_structs.c \
../lwip-1.4.0/src/core/snmp/msg_in.c \
../lwip-1.4.0/src/core/snmp/msg_out.c 

OBJS += \
./lwip-1.4.0/src/core/snmp/asn1_dec.o \
./lwip-1.4.0/src/core/snmp/asn1_enc.o \
./lwip-1.4.0/src/core/snmp/mib2.o \
./lwip-1.4.0/src/core/snmp/mib_structs.o \
./lwip-1.4.0/src/core/snmp/msg_in.o \
./lwip-1.4.0/src/core/snmp/msg_out.o 

C_DEPS += \
./lwip-1.4.0/src/core/snmp/asn1_dec.d \
./lwip-1.4.0/src/core/snmp/asn1_enc.d \
./lwip-1.4.0/src/core/snmp/mib2.d \
./lwip-1.4.0/src/core/snmp/mib_structs.d \
./lwip-1.4.0/src/core/snmp/msg_in.d \
./lwip-1.4.0/src/core/snmp/msg_out.d 


# Each subdirectory must supply rules for building sources it contributes
lwip-1.4.0/src/core/snmp/%.o: ../lwip-1.4.0/src/core/snmp/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_ethernet_mac -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -I"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app" -I"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include" -I"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include\ipv4" -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -v -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


