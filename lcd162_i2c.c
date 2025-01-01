#include "lcd162_i2c.h"


uint8_t currentValue; // Current status of all 8 pins of PCF7584

/**
 * @brief Generates a delay in milliseconds.
 * 
 * @param ms Number of milliseconds to delay.
 */
void Delay_ms (uint32_t ms){
    uint32_t i =0 ;
    uint32_t j=0;
    for (i=0; i<=ms; i++){
        for (j=0; j<210; j++){
            _asm("nop");
        }
    }
}

/**
 * @brief Writes an 8-bit value to all pins of the PCF8574.
 * 
 * @param iData 8-bit data to be written to the PCF8574.
 */
void PCF8574writeAll(u8 iData){
	I2C_GenerateSTART(ENABLE);
	while(!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT));
	I2C_Send7bitAddress(LCD_I2C_Address, I2C_DIRECTION_TX);
	while(!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));
	I2C_SendData(iData);
	while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_TRANSMITTED));
	I2C_GenerateSTOP(ENABLE);
    currentValue=iData;
}

/**
 * @brief Sets the state of a specific pin on the PCF8574.
 * 
 * @param pin Pin number (0-7) on the PCF8574.
 * @param value Pin value (0 for LOW, 1 for HIGH).
 */
void PCF8574write(uint8_t pin, uint8_t value){
      if (value == 0){
          currentValue &= ~(1 << pin); // Set the pin value 0 or 1
      }else{
          currentValue |= (1 << pin); // Set the pin value 0 or 1
      }
      PCF8574writeAll(currentValue);
}

/**
 * @brief Sets the 4 data bits (D4-D7) on the LCD.
 * 
 * @param data 4-bit data to send to the LCD.
 */
void LCD_SetBit(char data){
    PCF8574write(4, data&1); //D4 = 1
    PCF8574write(5, data&2); //D5 = 1
    PCF8574write(6, data&4); //D6 = 1
    PCF8574write(7, data&8); //D7 = 1
}

/**
 * @brief Sends a command to the LCD.
 * 
 * @param a Command code to be sent.
 */
void LCD_Cmd(char cmd){
    PCF8574write(0,0); //RS = 0          
    LCD_SetBit(cmd); //Incoming Hex value
    PCF8574write(2,1); //EN  = 1         
	Delay_ms(2);
	PCF8574write(2,0); //EN  = 0      
}

/**
 * @brief Initializes the LCD and I2C communication.
 */
 void LCD_Begin(void){
    int Input_Clock; // Clock speed in MHz
	Delay_ms(10);
	Input_Clock = CLK_GetClockFreq()/1000000;  // Clock speed in MHz
    I2C_Init(100000, LCD_I2C_Address, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, Input_Clock);
	
    PCF8574writeAll(0b00000000);
	LCD_SetBit(0x00);
	Delay_ms(1000); 
    LCD_Cmd(0x03);
	Delay_ms(5);
	LCD_Cmd(0x03);
	Delay_ms(11);
    LCD_Cmd(0x03); 
    LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
    LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
    LCD_Cmd(0x08); //Select Row 1
    LCD_Cmd(0x00); //Clear Row 1 Display
    LCD_Cmd(0x0C); //Select Row 2
    LCD_Cmd(0x00); //Clear Row 2 Display
    LCD_Cmd(0x06);
 } 
 
 /**
 * @brief Clears the LCD display and resets the cursor.
 */
void LCD_Clear(void){
    LCD_Cmd(0); //Clear the LCD
    LCD_Cmd(1); //Move the curser to first position
}

/**
 * @brief Sets the cursor position on the LCD.
 * 
 * @param row Row number (1 or 2).
 * @param col Column number (1-16).
 */
void LCD_SetCursor(char row, char col){
    char temp,z,y;
    if(row == 1){
        temp = 0x80 + col - 1; //80H is used to move the curser
        z = temp>>4; //Lower 8-bits
        y = temp & 0x0F; //Upper 8-bits
        LCD_Cmd(z); //Set Row
        LCD_Cmd(y); //Set Column
    }else if(row == 2){
        temp = 0xC0 + col - 1;
        z = temp>>4; //Lower 8-bits
        y = temp & 0x0F; //Upper 8-bits
        LCD_Cmd(z); //Set Row
        LCD_Cmd(y); //Set Column
    }
}

/**
 * @brief Prints a single character on the LCD.
 * 
 * @param data ASCII character to display.
 */
void LCD_PrintChar(char data){
   char Lower_Nibble,Upper_Nibble;
   Lower_Nibble = data&0x0F;
   Upper_Nibble = data&0xF0;
   PCF8574write(0,1);             // => RS = 1
	 
   LCD_SetBit(Upper_Nibble>>4);  //Send upper half by shifting by 4
   PCF8574write(2,1); //EN = 1
   Delay_ms(5); 
   PCF8574write(2,0); //EN = 0
	 
   LCD_SetBit(Lower_Nibble); //Send Lower half
   PCF8574write(2,1); //EN = 1
   Delay_ms(5); 
   PCF8574write(2,0); //EN = 0
}

/**
 * @brief Prints a string on the LCD.
 * 
 * @param str Pointer to the string to display.
 */
void LCD_PrintString(char *str){
    int i;
    for(i=0; str[i]!='\0'; i++){
		LCD_PrintChar(str[i]);  //Split the string using pointers and call the Char function 
    }
}

/**
 * @brief Turns on the LCD backlight.
 */
void LCD_OnBL(void){
	PCF8574write(3,1);
}

/**
 * @brief Turns off the LCD backlight.
 */
void LCD_OffBL(void){
	PCF8574write(3,0);
}