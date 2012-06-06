################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lwip-1.4.0/src/api/api_lib.c \
../lwip-1.4.0/src/api/api_msg.c \
../lwip-1.4.0/src/api/err.c \
../lwip-1.4.0/src/api/netbuf.c \
../lwip-1.4.0/src/api/netdb.c \
../lwip-1.4.0/src/api/netifapi.c \
../lwip-1.4.0/src/api/sockets.c \
../lwip-1.4.0/src/api/tcpip.c 

OBJS += \
./lwip-1.4.0/src/api/api_lib.o \
./lwip-1.4.0/src/api/api_msg.o \
./lwip-1.4.0/src/api/err.o \
./lwip-1.4.0/src/api/netbuf.o \
./lwip-1.4.0/src/api/netdb.o \
./lwip-1.4.0/src/api/netifapi.o \
./lwip-1.4.0/src/api/sockets.o \
./lwip-1.4.0/src/api/tcpip.o 

C_DEPS += \
./lwip-1.4.0/src/api/api_lib.d \
./lwip-1.4.0/src/api/api_msg.d \
./lwip-1.4.0/src/api/err.d \
./lwip-1.4.0/src/api/netbuf.d \
./lwip-1.4.0/src/api/netdb.d \
./lwip-1.4.0/src/api/netifapi.d \
./lwip-1.4.0/src/api/sockets.d \
./lwip-1.4.0/src/api/tcpip.d 


# Each subdirectory must supply rules for building sources it contributes
lwip-1.4.0/src/api/%.o: ../lwip-1.4.0/src/api/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_ethernet_mac -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -I"D:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app" -I"D:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include" -I"D:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include\ipv4" -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -v -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


