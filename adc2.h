#ifndef __ADC2_H
#define __ADC2_H
#include "stm8s.h"
#include "stm8s_adc2.h"
#include "Filters.h"

#define ADC_RESOLUTION  1024

#define ADC_CH_1        ADC2_CHANNEL_0
#define ADC_CH_2        ADC2_CHANNEL_1
#define ADC_CH_3        ADC2_CHANNEL_2
#define ADC_CH_4        ADC2_CHANNEL_3
#define ADC_CH_5        ADC2_CHANNEL_4


/**
 * @brief Structure representing an ADC instance.
 */
typedef struct ADC{
    uint8_t channel;
    uint16_t value;
    // FLTR_MovingAverage movAvgFltr;
    MovAvgFilter_ts movAvgFltr;
    
}ADC_ts;

void ADC_Init(ADC_ts *adc, uint8_t channel);
uint16_t ADC_Read(ADC_ts *adc);
uint16_t ADC_ReadChannel(uint8_t channel);

#endif