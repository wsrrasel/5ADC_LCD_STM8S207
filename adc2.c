#include "adc2.h"
#include "stm8s_adc2.h"

/**
 * @brief Initializes the ADC channel and its moving average filter.
 * 
 * @param adc Pointer to an ADC_ts structure to initialize.
 * @param channel The ADC channel to configure.
 */
void ADC_Init(ADC_ts *adc, uint8_t channel){
    adc->channel = channel;
    adc->value = 0;
    // FLTR_ClearMovAvg(&adc->movAvgFltr);
    MovAvgFilter_Init(&adc->movAvgFltr);
}


/**
 * @brief Reads the value from a specified ADC channel.
 * 
 * This function initializes the ADC, performs a single conversion on the
 * specified channel, retrieves the result, and deinitializes the ADC.
 * 
 * @param channel The ADC channel to read.
 * @return uint16_t The converted ADC value.
 */
uint16_t ADC_ReadChannel(uint8_t channel){
	uint16_t adcValue = 0;
    /* ADC init */
    ADC2_Init(
        ADC2_CONVERSIONMODE_SINGLE,
        channel,
        ADC2_PRESSEL_FCPU_D2,
        ADC2_EXTTRIG_TIM,
        DISABLE,
        ADC2_ALIGN_RIGHT,
        channel,
        DISABLE
    );

    /*Enable ADC*/
    ADC2_Cmd(ENABLE);

    /*Statr conversion */
    ADC2_StartConversion();

    /*wait for reseting EOC status flag*/
    while (ADC2_GetFlagStatus() == RESET)  {;}
    
    /*clear ROC status flag*/
    ADC2_ClearFlag();

    /*Get the result */
    adcValue = ADC2_GetConversionValue();

    /*Deinit ADC*/
    ADC2_DeInit();

    /*Return ADC value*/
    return adcValue;
}

/**
 * @brief Reads the ADC value for a specific ADC_ts structure and updates its moving average.
 * 
 * This function reads the ADC value for the configured channel, updates the
 * moving average filter, and stores the filtered value in the ADC_ts structure.
 * 
 * @param adc Pointer to an ADC_ts structure representing the ADC configuration and state.
 * @return uint16_t The filtered ADC value.
 */
uint16_t ADC_Read(ADC_ts *adc){
    adc->value = ADC_ReadChannel(adc->channel);
    adc->value = MovAvgFilter_Update(&adc->movAvgFltr, adc->value);
    return adc->value;
}

