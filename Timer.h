#ifndef __TIMER_H
#define __TIMER_H
#include "stm8s.h"

#define TIM_PWM_FREQ        500 //in Hz



void TIM_Init(void);
void TIM_SetDuty(uint8_t duty);

#endif