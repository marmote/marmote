################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lwip-1.4.0/src/core/def.c \
../lwip-1.4.0/src/core/dhcp.c \
../lwip-1.4.0/src/core/dns.c \
../lwip-1.4.0/src/core/init.c \
../lwip-1.4.0/src/core/mem.c \
../lwip-1.4.0/src/core/memp.c \
../lwip-1.4.0/src/core/netif.c \
../lwip-1.4.0/src/core/pbuf.c \
../lwip-1.4.0/src/core/raw.c \
../lwip-1.4.0/src/core/stats.c \
../lwip-1.4.0/src/core/sys.c \
../lwip-1.4.0/src/core/tcp.c \
../lwip-1.4.0/src/core/tcp_in.c \
../lwip-1.4.0/src/core/tcp_out.c \
../lwip-1.4.0/src/core/timers.c \
../lwip-1.4.0/src/core/udp.c 

OBJS += \
./lwip-1.4.0/src/core/def.o \
./lwip-1.4.0/src/core/dhcp.o \
./lwip-1.4.0/src/core/dns.o \
./lwip-1.4.0/src/core/init.o \
./lwip-1.4.0/src/core/mem.o \
./lwip-1.4.0/src/core/memp.o \
./lwip-1.4.0/src/core/netif.o \
./lwip-1.4.0/src/core/pbuf.o \
./lwip-1.4.0/src/core/raw.o \
./lwip-1.4.0/src/core/stats.o \
./lwip-1.4.0/src/core/sys.o \
./lwip-1.4.0/src/core/tcp.o \
./lwip-1.4.0/src/core/tcp_in.o \
./lwip-1.4.0/src/core/tcp_out.o \
./lwip-1.4.0/src/core/timers.o \
./lwip-1.4.0/src/core/udp.o 

C_DEPS += \
./lwip-1.4.0/src/core/def.d \
./lwip-1.4.0/src/core/dhcp.d \
./lwip-1.4.0/src/core/dns.d \
./lwip-1.4.0/src/core/init.d \
./lwip-1.4.0/src/core/mem.d \
./lwip-1.4.0/src/core/memp.d \
./lwip-1.4.0/src/core/netif.d \
./lwip-1.4.0/src/core/pbuf.d \
./lwip-1.4.0/src/core/raw.d \
./lwip-1.4.0/src/core/stats.d \
./lwip-1.4.0/src/core/sys.d \
./lwip-1.4.0/src/core/tcp.d \
./lwip-1.4.0/src/core/tcp_in.d \
./lwip-1.4.0/src/core/tcp_out.d \
./lwip-1.4.0/src/core/timers.d \
./lwip-1.4.0/src/core/udp.d 


# Each subdirectory must supply rules for building sources it contributes
lwip-1.4.0/src/core/%.o: ../lwip-1.4.0/src/core/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_ethernet_mac -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -ID:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -I"D:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app" -I"D:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include" -I"D:\Work\marmote\firmware\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_app\lwip-1.4.0\src\include\ipv4" -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -v -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


