################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include lwip-1.4.0/src/netif/subdir.mk
-include lwip-1.4.0/src/core/subdir.mk
-include lwip-1.4.0/src/core/snmp/subdir.mk
-include lwip-1.4.0/src/core/ipv4/subdir.mk
-include lwip-1.4.0/src/api/subdir.mk
-include arch/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
MEMORYMAP += \
memory-map.xml \

IHEXFILES += \
lwIPTest_MSS_MSS_CM3_0_app.hex \

SRECFILES += \
lwIPTest_MSS_MSS_CM3_0_app.srec \

LISTINGS += \
lwIPTest_MSS_MSS_CM3_0_app.lst \


# All Target
all: lwIPTest_MSS_MSS_CM3_0_app secondary-outputs

# Tool invocations
lwIPTest_MSS_MSS_CM3_0_app: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU C Linker'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -L"E:\marmote\firmware\MainBoard\lwIPTest\SoftConsole\lwIPTest_MSS_MSS_CM3_0\lwIPTest_MSS_MSS_CM3_0_hw_platform\Debug" -T../../lwIPTest_MSS_MSS_CM3_0_hw_platform/CMSIS/startup_gcc/debug-in-actel-smartfusion-envm.ld -Wl,-Map=$(EXECUTABLE).map -Xlinker -gc-sections -o"lwIPTest_MSS_MSS_CM3_0_app" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

memory-map.xml: $(EXECUTABLE)
	@echo 'Invoking: Memory map generator'
	actel-map -o "memory-map.xml" $(EXECUTABLE) $(BUILDCMD)
	@echo 'Finished building: $@'
	@echo ' '

lwIPTest_MSS_MSS_CM3_0_app.hex: $(EXECUTABLE)
	@echo 'Invoking: GNU Intel Hex File Generator'
	arm-none-eabi-objcopy -O ihex $(EXECUTABLE) "lwIPTest_MSS_MSS_CM3_0_app.hex"
	@echo 'Finished building: $@'
	@echo ' '

lwIPTest_MSS_MSS_CM3_0_app.srec: $(EXECUTABLE)
	@echo 'Invoking: GNU S-Record Generator'
	arm-none-eabi-objcopy -O srec $(EXECUTABLE) "lwIPTest_MSS_MSS_CM3_0_app.srec"
	@echo 'Finished building: $@'
	@echo ' '

lwIPTest_MSS_MSS_CM3_0_app.lst: $(EXECUTABLE)
	@echo 'Invoking: GNU Listing Generator'
	arm-none-eabi-objdump -h -S $(EXECUTABLE) > "lwIPTest_MSS_MSS_CM3_0_app.lst"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean::
	-$(RM) $(MEMORYMAP)$(OBJS)$(C_DEPS)$(SRECFILES)$(IHEXFILES)$(LISTINGS)$(EXECUTABLE) lwIPTest_MSS_MSS_CM3_0_app
	-@echo ' '

secondary-outputs: $(MEMORYMAP) $(IHEXFILES) $(SRECFILES) $(LISTINGS)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
