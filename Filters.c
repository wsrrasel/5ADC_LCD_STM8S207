/*
 * Filters.c
 *
 *  Created on: Mar 9, 2022
 *      Author: RASEL_EEE
 */

#include "Filters.h"



/**
 * @brief Initializes the moving average filter.
 * 
 * This function resets the filter state, including the buffer, sum, 
 * index, and count, preparing it for use.
 * 
 * @param filter Pointer to the MovAvgFilter_ts structure to initialize.
 */
void MovAvgFilter_Init(MovAvgFilter_ts* filter) {
    uint8_t i = 0;
    filter->index = 0;
    filter->count = 0;
    filter->sum = 0;
    
    for (i = 0; i < FILTER_SIZE; i++) {
        filter->buffer[i] = 0;
    }
}

/**
 * @brief Updates the moving average filter with a new value and computes the average.
 * 
 * This function adds a new value to the filter, removes the oldest value, and 
 * calculates the current moving average based on the updated data.
 * 
 * @param filter Pointer to the MovAvgFilter_ts structure representing the filter state.
 * @param newValue The new value to add to the filter.
 * @return uint16_t The current moving average.
 */
uint16_t MovAvgFilter_Update(MovAvgFilter_ts* filter, uint16_t newValue) {
    // Subtract the oldest value from the sum
    filter->sum -= filter->buffer[filter->index];

    // Add the new value to the buffer and the sum
    filter->buffer[filter->index] = newValue;
    filter->sum += newValue;

    // Move to the next index in the circular buffer
    filter->index = (filter->index + 1) % FILTER_SIZE;

    // Keep track of the number of elements added
    if (filter->count < FILTER_SIZE) {
        filter->count++;
    }

    // Return the moving average
    return filter->sum / filter->count;
}