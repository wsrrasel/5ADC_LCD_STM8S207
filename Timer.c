
#include "Timer.h"
#include "stm8s.h"
#include "stm8s_tim2.h"



#define TIM_CLOCK       2000000 // 2MHZ
#define TIM_PERIOD      (TIM_CLOCK/TIM_PWM_FREQ)

static uint16_t period = TIM_PERIOD;

/**
 * @brief Initializes Timer 2 for PWM operation.
 * 
 * This function deinitializes Timer 2, sets up the time base, and configures
 * the Output Compare (OC) mode for PWM generation on channel 1.
 * 
 * - The timer prescaler is set to 1.
 * - The timer period determines the frequency of the PWM signal.
 * - The default duty cycle is set to 50%.
 * - PWM polarity is configured as active high.
 * 
 * @note Ensure the global variable `period` is defined and correctly set 
 *       before calling this function.
 */
void TIM_Init(void){
    TIM2_DeInit();
    TIM2_TimeBaseInit(TIM2_PRESCALER_1, period);
    TIM2_OC1Init(TIM2_OCMODE_PWM1, 
                TIM2_OUTPUTSTATE_ENABLE, 
                (period/2), 
                TIM2_OCPOLARITY_HIGH);
    TIM2_Cmd(ENABLE);
}

/**
 * @brief Sets the PWM duty cycle on Timer 2, Channel 1.
 * 
 * This function calculates the required duty cycle based on the given percentage
 * and updates the Timer 2 Compare Register 1 to set the PWM duty cycle.
 * 
 * @param duty The desired duty cycle as a percentage (0 to 100).
 * 
 * @note If the provided duty cycle is outside the range [0, 100], the function does nothing.
 */
 void TIM_SetDuty(uint8_t duty){
    if(duty >= 0 && duty <= 100){
        uint16_t dutyCycle = (period/100);
        dutyCycle = (dutyCycle*duty);
        TIM2_SetCompare1(dutyCycle);
    }
    
 }