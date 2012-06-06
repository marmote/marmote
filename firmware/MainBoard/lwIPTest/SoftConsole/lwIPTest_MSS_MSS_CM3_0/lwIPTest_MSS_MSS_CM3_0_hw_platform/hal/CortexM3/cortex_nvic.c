/*******************************************************************************
 * (c) Copyright 2007 Actel Corporation.  All rights reserved.
 * 
 * Legacy Actel HAL Cortex NVIC control functions.
 * The use of these functions should be replaced by calls to the equivalent
 * CMSIS function in your application code.
 *
 * SVN $Revision: 2352 $
 * SVN $Date: 2010-03-01 12:31:51 +0000 (Mon, 01 Mar 2010) $
 */
#include "cortex_nvic.h"
#include "../../CMSIS/mss_assert.h"


/***************************************************************************//**
 * 
 */
void NVIC_init( void )
{
    /*
     * Please use SmartFusion CMSIS-PAL provided NVIC control functions.
     * The use of the Actel HAL NVIC control functions is obsolete on SmartFusion
     * devices.
     * Simply remove the call to NVIC_init() from your application code.
     */
    ASSERT(0);
}

/***************************************************************************//**
 * 
 */
void NVIC_set_handler
(
    uint32_t interrupt_number,
    interrupt_handler_t handler
)
{
    /*
     * Please use SmartFusion CMSIS-PAL provided NVIC control functions.
     * The use of the Actel HAL NVIC control functions is obsolete on SmartFusion
     * devices.
     * Please provide a function using the folowing prototype to handle interrupts
     * from peripherals implemeted in the SmartFusion FPGA fabric:
     *      void Fabric_IRQHandler( void )
     */
    ASSERT(0);
}

/***************************************************************************//**
 * 
 */
void NVIC_set_priority
(
    uint32_t interrupt_number,
    uint8_t priority_level
)
{
    /*
     * Please use SmartFusion CMSIS-PAL provided NVIC control functions.
     * The use of the Actel HAL NVIC control functions is obsolete on SmartFusion
     * devices.
     * Please replace calls to NVIC_set_priority() with a call to the CMSIS-PAL
     * void NVIC_SetPriority(IRQn_Type IRQn, uint32_t priority) function where
     * IRQn is set to Fabric_IRQn in order to set the priority of interrupts
     * generated from peripheral implemented in the SmartFusion FPGA fabric.
     */
    ASSERT(0);
}

/***************************************************************************//**
 * 
 */
void NVIC_enable_interrupt( uint32_t interrupt_number )
{
    /*
     * Please use SmartFusion CMSIS-PAL provided NVIC control functions.
     * The use of the Actel HAL NVIC control functions is obsolete on SmartFusion
     * devices.
     * Please replace calls to NVIC_enable_interrupt() with a call to the CMSIS-PAL
     * void NVIC_EnableIRQ(IRQn_Type IRQn) function where IRQn is set to
     * Fabric_IRQn in order to enable interrupts from peripheral implemented in
     * the SmartFusion FPGA fabric.
     */
    ASSERT(0);
}

/***************************************************************************//**
 * 
 */
void NVIC_disable_interrupt( uint32_t interrupt_number )
{
    /*
     * Please use SmartFusion CMSIS-PAL provided NVIC control functions.
     * The use of the Actel HAL NVIC control functions is obsolete on SmartFusion
     * devices.
     * Please replace calls to NVIC_disable_interrupt() with a call to the CMSIS-PAL
     * void NVIC_DisableIRQ(IRQn_Type IRQn) function where IRQn is set to
     * Fabric_IRQn in order to disable interrupts from peripheral implemented in
     * the SmartFusion FPGA fabric.
     */
    ASSERT(0);
}

/***************************************************************************//**
 * 
 */
void NVIC_clear_interrupt( uint32_t interrupt_number )
{
    /*
     * Please use SmartFusion CMSIS-PAL provided NVIC control functions.
     * The use of the Actel HAL NVIC control functions is obsolete on SmartFusion
     * devices.
     * Please replace calls to NVIC_clear_interrupt() with a call to the CMSIS-PAL
     * void NVIC_ClearPendingIRQ(IRQn_Type IRQn) function where IRQn is set to
     * Fabric_IRQn in order to clear interrupts from peripheral implemented in
     * the SmartFusion FPGA fabric.
     */
    ASSERT(0);
}
