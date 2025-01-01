#ifndef __LCD162_H
#define __LCD162_H

#include "STM8S.h"



 //MUST BE DEFINED IN CODE
 #define LCD_RS     GPIOC, GPIO_PIN_1
 #define LCD_EN     GPIOC, GPIO_PIN_2
 #define LCD_DB4    GPIOC, GPIO_PIN_3
 #define LCD_DB5    GPIOC, GPIO_PIN_4
 #define LCD_DB6    GPIOC, GPIO_PIN_5
 #define LCD_DB7    GPIOC, GPIO_PIN_6
 


 void LCD_Cmd(char cmd);
 void LCD_Begin(void);
 void LCD_Clear(void);
 void LCD_SetCursor(char row, char col);
 void LCD_PrintString(char *str);
 void LCD_PrintChar(char data);

#endif