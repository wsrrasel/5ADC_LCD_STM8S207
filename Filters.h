/*
 * Filters.h
 *
 *  Created on: Mar 9, 2022
 *      Author: RASEL_EEE
 */


#ifndef INC_FILTERS_H_
#define INC_FILTERS_H_

#include "stm8s.h"
//#include "OD_Defines.h"
#define FILTER_SIZE 5  // Size of the moving average filter

typedef struct MovAvgFilter{
    uint16_t buffer[FILTER_SIZE];  // Circular buffer to store recent values
    uint8_t index;                  // Current index in the buffer
    uint8_t count;                  // Count of elements added (up to FILTER_SIZE)
    uint32_t sum;                  // Current sum of elements in the buffer
} MovAvgFilter_ts;



void MovAvgFilter_Init(MovAvgFilter_ts* filter);
uint16_t MovAvgFilter_Update(MovAvgFilter_ts* filter, uint16_t newValue);


#endif /* OD_LIB_INC_FILTERS_H_ */
