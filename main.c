/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "SerialCom.h"
#include "stm8s.h"
#include "adc2.h"
#include "Timer.h"
#include "stdio.h"
#include "stm8s_clk.h"
#include "debug.h"
#include "SerialCom.h"
#include "lcd162.h"

#define LED		GPIOB, GPIO_PIN_7

typedef enum {
    ADC_1 = 0,
    ADC_2,
    ADC_3,
    ADC_4,
    ADC_5,
    ADC_MAX
}ADC_Id_te;

typedef struct GVar{
    ADC_ts adc[ADC_MAX];
    uint8_t duty;
}GVar_ts;

GVar_ts gv = {0};

void delay(uint32_t ms);
void ADC_Update(void);
uint16_t ADC_GetValue(ADC_Id_te id);
void BlinkLED(void);
main(){
		uint16_t count = 0;
		char str[32];
		char rxChar;
		/*
		* Configure system clock to run at 16Mhz
		* High speed internal clock prescaler: 1
		*/
		CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  
		/*Debug init*/
		dbg_init();
		dbg_print("\r\n---Started---\r\n");
		
		/*Serial Com port init*/
		Serial_Init();
		
		/*LCD Init*/
		LCD_Begin();
		LCD_Clear();
		LCD_SetCursor(1,1);
		LCD_PrintString("Welcome!");
		delay(2000);
		LCD_Clear();
		LCD_SetCursor(1,1);
		LCD_PrintString("1602 LCD");
		
    /*Init GIPO for LED*/
	  GPIO_Init(LED, GPIO_MODE_OUT_PP_LOW_SLOW);

    	  /*5 ADCs Init*/
    ADC_Init(&gv.adc[ADC_1], ADC_CH_1);
    ADC_Init(&gv.adc[ADC_2], ADC_CH_2);
    ADC_Init(&gv.adc[ADC_3], ADC_CH_3);
    ADC_Init(&gv.adc[ADC_4], ADC_CH_4);
    ADC_Init(&gv.adc[ADC_5], ADC_CH_5);
    
		/*Init Timer for PWM 500Hz, 50% duty*/
    TIM_Init();
    TIM_SetDuty(50); // PWM 50% duty at Timer 2 channel 1S

	

	while (1){
		/*Examples*/
		/*Update ADC-----------*/
		ADC_Update();
        
		/*Blink LED------------*/
    //BlinkLED() 
		
		/*Debug Print----------*/
		dbg_print("Count:%d\r\n", count);
		
		/*Serial Print----------*/
		sprintf(str,"Count:%d\r\n", count);
		Serial_Print(str);
		/*Serial Receive*/
		rxChar = Serial_ReadChar();
		if(rxChar>0){
				dbg_print("%c",rxChar);
				rxChar = 0;
		 }
		
		
		
		/*LCD print------------*/
		sprintf(str,"Count:%d", count);
		LCD_SetCursor(2,1);
		LCD_PrintString(str);
		
		

		count++;
	}
}

void ADC_Update(void){
		uint8_t i = 0;
		for(i = 0; i < ADC_MAX; i++){
				ADC_Read(&gv.adc[i]);
		}
}

uint16_t ADC_GetValue(ADC_Id_te id){
    if(id >= 0 && id < ADC_MAX){
        return gv.adc[id].value;
    }else{
        return 0;
    }
}

void BlinkLED(void){
		GPIO_WriteHigh(LED);
		delay(500);
		GPIO_WriteLow(LED);
		delay(500);
}

void delay(uint32_t ms){
    uint32_t i = 0;
    for(i = 0; i < (120*ms); i++){;}
}