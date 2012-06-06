#-------------------------------------------------------------------------------
# (c) Copyright 2007 Actel Corporation.  All rights reserved.
# 
# Interrupt disabling/restoration for critical section protection.
#
# SVN $Revision: 3768 $
# SVN $Date: 2011-08-02 06:50:36 +0100 (Tue, 02 Aug 2011) $
#
    .text
    .global HAL_disable_interrupts
    .global HAL_restore_interrupts
    .code 16
    .syntax unified
    .type HAL_disable_interrupts, function
    .type HAL_restore_interrupts, function
#-------------------------------------------------------------------------------
# 
#
HAL_disable_interrupts:    
    mrs r0, PRIMASK
    cpsid I
    bx lr

#-------------------------------------------------------------------------------
#
#
HAL_restore_interrupts:    
    msr PRIMASK, r0
    bx lr

.end
