/*******************************************************************************
 * (c) Copyright 2008 Actel Corporation.  All rights reserved.
 * 
 * SVN $Revision: 194 $
 * SVN $Date: 2008-03-14 11:27:33 +0000 (Fri, 14 Mar 2008) $
 */
#ifndef HAL_ASSERT_HEADER
#define HAL_ASSERT_HEADER

#if defined(NDEBUG)
/***************************************************************************//**
 * HAL_ASSERT() is defined out when the NDEBUG symbol is used.
 ******************************************************************************/
#define HAL_ASSERT(CHECK)

#else
/***************************************************************************//**
 * Default behaviour for HAL_ASSERT() macro:
 *------------------------------------------------------------------------------
 * In this mode, an assertion will block the programs execution until a watchdog
 * resets the system.
 ******************************************************************************/

void HAL_assert_fail
(
    const uint8_t * file_name,
    uint32_t line_no
);

#define HAL_ASSERT(CHECK)  \
    do { \
        if (!(CHECK)) \
        { \
            uint8_t file_name[] = __FILE__; \
            HAL_assert_fail(file_name, __LINE__); \
        } \
    } while (0);


#endif  /* NDEBUG */

#endif  /* HAL_ASSERT_HEADER */
