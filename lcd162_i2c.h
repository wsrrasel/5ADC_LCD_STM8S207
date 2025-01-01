#ifndef __LCD162_H
#define __LCD162_H
#include "STM8S.h"
#include "stm8s_i2c.h"

#define LCD_I2C_Address  (0x27 << 1)

void Delay_ms (uint32_t ms);
void LCD_Begin(void);
void LCD_Clear(void);
void LCD_SetCursor(char row, char col);
void LCD_PrintChar(char data);
void LCD_PrintString(char *str);
void LCD_OnBL(void); // Back light on
void LCD_OffBL(void); // Back light off

#endif // !__LCD162_H
