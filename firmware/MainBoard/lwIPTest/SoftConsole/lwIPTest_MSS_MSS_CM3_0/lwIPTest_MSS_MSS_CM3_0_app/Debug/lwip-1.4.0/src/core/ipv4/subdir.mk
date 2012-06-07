################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lwip-1.4.0/src/core/ipv4/autoip.c \
../lwip-1.4.0/src/core/ipv4/icmp.c \
../lwip-1.4.0/src/core/ipv4/igmp.c \
../lwip-1.4.0/src/core/ipv4/inet.c \
../lwip-1.4.0/src/core/ipv4/inet_chksum.c \
../lwip-1.4.0/src/core/ipv4/ip.c \
../lwip-1.4.0/src/core/ipv4/ip_addr.c \
../lwip-1.4.0/src/core/ipv4/ip_frag.c 

OBJS += \
./lwip-1.4.0/src/core/ipv4/autoip.o \
./lwip-1.4.0/src/core/ipv4/icmp.o \
./lwip-1.4.0/src/core/ipv4/igmp.o \
./lwip-1.4.0/src/core/ipv4/inet.o \
./lwip-1.4.0/src/core/ipv4/inet_chksum.o \
./lwip-1.4.0/src/core/ipv4/ip.o \
./lwip-1.4.0/src/core/ipv4/ip_addr.o \
./lwip-1.4.0/src/core/ipv4/ip_frag.o 

C_DEPS += \
./lwip-1.4.0/src/core/ipv4/autoip.d \
./lwip-1.4.0/src/core/ipv4/icmp.d \
./lwip-1.4.0/src/core/ipv4/igmp.d \
./lwip-1.4.0/src/core/ipv4/inet.d \
./lwip-1.4.0/src/core/ipv4/inet_chksum.d \
./lwip-1.4.0/src/core/ipv4/ip.d \
./lwip-1.4.0/src/core/ipv4/ip_addr.d \
./lwip-1.4.0/src/core/ipv4/ip_frag.d 


# Each subdirectory must supply rules for building sources it contributes
lwip-1.4.0/src/core/ipv4/%.o: ../lwip-1.4.0/src/core/ipv4/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_ethernet_mac -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -IE:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -I"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app" -I"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include" -I"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include\ipv4" -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -v -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


